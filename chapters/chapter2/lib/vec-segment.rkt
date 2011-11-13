#lang racket

(define (make-segment start end) (cons start end))

(define (start-segment s) (car s))

(define (end-segment s) (cdr s))

(provide make-segment
         start-segment
         end-segment)