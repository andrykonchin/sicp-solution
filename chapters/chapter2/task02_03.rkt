#lang racket

(require rackunit
         "../../utils/test_helper.rkt"
         "lib/segment.rkt")

; Реализуйте представление прямоугольников на плоскости. (Подсказка: Вам могут потребоваться
; результаты упражнения 2.2.) Определите в терминах своих конструкторов и селекторов процедуры,
; которые вычисляют периметр и площадь прямоугольника. Теперь реализуйте другое представление
; для прямоугольников. Можете ли Вы спроектировать свою систему с подходящими барьерами
; абстракции так, чтобы одни и те же процедуры вычисления периметра и площади работали с
; любым из Ваших представлений?


(define (perimetr-rectangle r)
  (+ (* 2 (width-rectangle r)) (* 2 (height-rectangle r))))

(define (square-rectangle r)
  (* (width-rectangle r) (height-rectangle r)))

; первая реализация

(define (width-rectangle r)
  (length-segment (make-segment (car r) (cadr r))))

(define (height-rectangle r)
  (length-segment (make-segment (cadr r) (caddr r))))

(define (make-rectangle a b c d)
  (list a b c d))


; тест

(define r (make-rectangle (make-point 0.0 0.0)
                          (make-point 4.0 0.0)
                          (make-point 4.0 2.0)
                          (make-point 0.0 2.0)))

(check-close? (perimetr-rectangle r) 12.0)
(check-close? (square-rectangle   r)  8.0)