#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

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

; базовые примитивы

(define (make-segment start end) (cons start end))

(define (length-segment s)
  (let ((dx (- (x-point (start-segment s)) (x-point (end-segment s))))
        (dy (- (y-point (start-segment s)) (y-point (end-segment s)))))
    (sqrt (+ (* dx dx) (* dy dy)))))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

; тест

(define r (make-rectangle (make-point 0.0 0.0)
                          (make-point 4.0 0.0)
                          (make-point 4.0 2.0)
                          (make-point 0.0 2.0)))

(check-close? (perimetr-rectangle r) 12.0)
(check-close? (square-rectangle   r)  8.0)