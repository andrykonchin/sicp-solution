#lang racket

; Хьюго Дум пытается переписать первую из процедур square-list из упражнения 2.21 так,
; чтобы она работала как итеративный процесс.
; К сожалению, такое определение square-list выдает список результатов в порядке, обратном
; желаемому. Почему?

(define (square-list-v1 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items null))

(define (square x) (* x x))

(square-list-v1 '(1 2 3 4)) ; => '(16 9 4 1)

; Для каждого очередного элемента списка (начиная с его начала) квадрат числа помещается в начало списка-результата.
; Соответственно чтобы в результате был правильный порядок элементов списка - на каждом шаге квадрат числа надо добавлять в конец
; текущего списка-результата



; Затем Хьюго пытается исправить ошибку, обменяв аргументы cons.
; И так программа тоже не работает. Объясните это.

(define (square-list-v2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items null))

(square-list-v2 '(1 2 3 4)) ; => '((((() . 1) . 4) . 9) . 16)

; Хьюго вместо списка создает бинарное дерево, листьями которого являются возведенные в квадрат элементы списка.
; Корректный вариант функции

(define (square-list-v3 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer
                      (list (square (car things)))))))
  (iter items null))

(square-list-v3 '(1 2 3 4)) ; => '(1 4 9 16)

