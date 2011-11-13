#lang racket

(require rackunit
         "lib/enumerate.rkt"
         "lib/flatmap.rkt")

; Напишите процедуру, которая находит все такие упорядоченные тройки различных 
; положительных целых чисел i, j и k, меньших или равных данному целому числу n, 
; сумма которых равна данному числу s.

(define (tuples-whose-sum-is-equal-to n s)
  (define (tuple-sum-is-equal? tuple) (= (apply + tuple) s))
  (filter tuple-sum-is-equal? (unique-tuples n)))

(define (unique-tuples n)
  (flatmap (lambda (i) (flatmap (lambda (j) (map (lambda (k) (list i j k))
                                                 (enumerate-interval 1 n)))
                                (enumerate-interval 1 n)))
           (enumerate-interval 1 n)))

; тест

(check-equal? (tuples-whose-sum-is-equal-to 3 4)
              '((1 1 2) (1 2 1) (2 1 1)))