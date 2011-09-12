#lang racket

(require rackunit
         "test_helper.rkt")

; Определите процедуру (tan-cf x k), которая вычисляет приближение к
; тангенсу на основе формулы Ламберта


(define (tan-cf x k)
  (define (n i) 
    (if (= i 1)
        x
        (- (* x x))))
  (define (d i) (- (* 2 i) 1))
  (define (tan-rec cur-k)
    (if (= cur-k k)
      (d cur-k)
      (/ (n cur-k) (+ (d cur-k) (tan-rec (+ cur-k 1))))))
  (exact->inexact (cont-frac n d k)))

(define (cont-frac n d k)
  (define (rec cur-k)
    (if (= cur-k k)
      (d cur-k)
      (/ (n cur-k) (+ (d cur-k) (rec (+ cur-k 1))))))
  (rec 1))


; тесты

(check-close? (tan-cf 0        1000) 0             )
(check-close? (tan-cf (/ pi 6) 1000) (/ (sqrt 3) 3))
(check-close? (tan-cf (/ pi 4) 1000) 1             )
(check-close? (tan-cf (/ pi 3) 1000) (sqrt 3)      )
(check-close? (tan-cf pi       1000) 0             )