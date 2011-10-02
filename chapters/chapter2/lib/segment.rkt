#lang racket

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

(provide make-segment
         length-segment
         start-segment
         end-segment
         make-point
         x-point
         y-point)