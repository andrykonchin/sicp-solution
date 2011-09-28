#lang racket

(require rackunit
         "../../utils/test_helper.rkt")


(define (perimetr-rectangle r)
  (+ (* 2 (width-rectangle r)) (* 2 (height-rectangle r))))

(define (square-rectangle r)
  (* (width-rectangle r) (height-rectangle r)))

; вторая реализация

(define (width-rectangle r) (length-segment (car r)))

(define (height-rectangle r) (length-segment (cdr r)))

(define (make-rectangle a b c)
  (cons (make-segment a b)
        (make-segment b c)))

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

(define r (make-rectangle (make-point 4.0 0.0)
                          (make-point 0.0 0.0)
                          (make-point 0.0 2.0)))

(check-close? (perimetr-rectangle r) 12.0)
(check-close? (square-rectangle   r)  8.0)