#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Рассуждая в духе Лизы, опишите, как можно вычислить разность двух интервалов. 
; Напишите соответствующую процедуру вычитания, называемую sub-interval.


(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (make-interval a b) (cons a b))

(define (lower-bound i) (min (car i) (cdr i)))

(define (upper-bound i) (max (car i) (cdr i)))

; тесты

; x +/- dx              =   4 +/- 0.2
; y +/- dy              = 1.1 +/- 0.3
; (x - y) +/- (dx + xy) = 2.9 +/- 0.5
; интервал для (x - y)  = [2.4, 3.4]

(define i (sub-interval (make-interval 3.8 4.2) (make-interval 0.8 1.4)))

(check-close? (lower-bound i) 2.4)
(check-close? (upper-bound i) 3.4)

