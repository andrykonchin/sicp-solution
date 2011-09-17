#lang racket

(require rackunit
         "test_helper.rkt")

; Напишите процедуру, которая развивается в виде итеративного процесса и реализует возведение в
; степень за логарифмическое число шагов, как fast-expt.

(define (fast-expt b n)
  (expt-iter 1 b n))

(define (expt-iter a b n)
  (cond ((= n 0) a)
        ((even? n) (expt-iter a (square b) (/ n 2)))
        (else (expt-iter (* a b) b (- n 1)))))

(define (even? n)
  (= (remainder n 2) 0))

(define (square x)
  (* x x))


; тесты

(check-eq? (fast-expt 3  3)  27)
(check-eq? (fast-expt 2  5)  32)
(check-eq? (fast-expt 13 2) 169)


