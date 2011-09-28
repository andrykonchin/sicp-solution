#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Рассмотрим задачу представления отрезков прямой на плоскости. Каждый отрезок представляется
; как пара точек: начало и конец. Определите конструктор make-segment и селекторы 
; start-segment и end-segment, которые определяют представление отрезков в терминах точек. 
; Далее, точку можно представить как пару чисел: координата x и координата y. Соответственно, 
; напишите конструктор make-point и селекторы x-point и y-point, которые определяют такое 
; представление. Наконец, используя свои селекторы и конструктор, напишите процедуру 
; midpoint-segment, которая принимает отрезок в качестве аргумента и возвращает его середину 
; (точку, координаты которой являются средним координат концов отрезка)


(define (midpoint-segment s)
  (let ((x (/ (+ (x-point (start-segment s)) (x-point (end-segment s))) 2))
        (y (/ (+ (y-point (start-segment s)) (y-point (end-segment s))) 2)))
    (make-point x y)))

(define (make-segment start end) (cons start end))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

; тест

(define start (make-point 0.0 0.0))
(define end   (make-point 3.0 3.0))
(define s (make-segment start end))
(define m (midpoint-segment s))

(check-close? (x-point m) 1.5)
(check-close? (y-point m) 1.5)