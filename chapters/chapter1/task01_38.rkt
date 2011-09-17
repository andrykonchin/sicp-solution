#lang racket

(require rackunit
         "test_helper.rkt")

; Напишите программу, использующую Вашу процедуру cont-frac из упражнения 1.37 для вычисления e на
; основании формулы Эйлера.

(define (cont-frac n d k)
  (define (rec cur-k)
    (if (= cur-k k)
      (d cur-k)
      (/ (n cur-k) (+ (d cur-k) (rec (+ cur-k 1))))))
  (rec 1))

(define (euler k)
  (define (n i) 1)
  (define (d i)
    (cond ((= (remainder i 3) 0) 1)
          ((= (remainder i 3) 1) 1)
          ((= (remainder i 3) 2) (* (+ (quotient i 3) 1) 2))))
  (exact->inexact (+ 2 (cont-frac n d k))))

; тест

(define e-etalon 2.71828182845904523536028747135)
(check-close? (euler 100) e-etalon)