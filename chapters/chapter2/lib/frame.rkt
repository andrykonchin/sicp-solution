#lang racket

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame) (car frame))

(define (edge1-frame frame) (cadr frame))

(define (edge2-frame frame) (caddr frame))

(provide make-frame
         origin-frame
         edge1-frame
         edge2-frame)