#lang racket

(require rackunit
         "../../utils/test_helper.rkt"
         "lib/interval.rkt")

; Покажите, что Дайко прав. Исследуйте поведение системы на различных арифметических 
; выражениях. Создайте несколько интервалов A и B и вычислите с их помощью выражения A/A и A/B.
; Наибольшую пользу Вы получите, если будете использовать интервалы, радиус которых составляет 
; малую часть от среднего значения.

; Пример Дайко
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

; Вычисление примеров Дайко

(define r1 (make-center-percent 10 0.1))
(define r2 (make-center-percent 15 0.2))

(display "Примеры Дайко")
(print-center-percent (par1 r1 r2))
(print-center-percent (par2 r1 r2))

; Вычисление A/A и A/B для разных пар интервалов

; Группа 1
(newline)
(newline)
(display "Группа 1")

(define a1 (make-center-percent 10 0.1))
(define b1 (make-center-percent 15 0.2))

(print-center-percent (div-interval a1 a1))
(print-center-percent (div-interval a1 b1))

; Группа 2
(newline)
(newline)
(display "Группа 2")

(define a2 (make-center-percent 230 0.9))
(define b2 (make-center-percent  23 0.4))

(print-center-percent (div-interval a2 a2))
(print-center-percent (div-interval a2 b2))

; Группа 3
(newline)
(newline)
(display "Группа 3")

(define a3 (make-center-percent 54 0.67))
(define b3 (make-center-percent  3 0.01))

(print-center-percent (div-interval a3 a3))
(print-center-percent (div-interval a3 b3))

; Выводы
; Утверждение Дайко подтверждаются - разные формулы дают результат с разной точностью
; Реализация арифметических операций дает значительную погрешность при представлении интервала как пара центр-процент.

