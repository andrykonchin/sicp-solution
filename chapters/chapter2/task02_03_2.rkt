#lang racket

(require rackunit
         "../../utils/test_helper.rkt"
         "lib/segment.rkt")


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


; тест

(define r (make-rectangle (make-point 4.0 0.0)
                          (make-point 0.0 0.0)
                          (make-point 0.0 2.0)))

(check-close? (perimetr-rectangle r) 12.0)
(check-close? (square-rectangle   r)  8.0)