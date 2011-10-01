#lang racket

(require rackunit)

; Определите процедуры first-denomination, except-first-denomination и no-more? в
; терминах элементарных операций над списковыми структурами. 
; Влияет ли порядок списка coin-values на результат, получаемый cc? Почему?


(define (count-change amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (count-change amount
                (except-first-denomination coin-values))
            (count-change (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (no-more? coin-values) (null? coin-values))

(define (except-first-denomination coin-values) (cdr coin-values))

(define (first-denomination coin-values) (car coin-values))

; тест

(define us-coins (list 50 25 10 5 1))
(check-eq? (count-change 100 us-coins)
           292)

; Порядок списка coin-values не влияет на результат.


