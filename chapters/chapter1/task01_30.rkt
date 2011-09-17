#lang racket

(require rackunit
         "test_helper.rkt")

; Процедура sum порождает линейную рекурсию. Ее можно переписать так, чтобы суммирование
; выполнялось итеративно. Покажите, как сделать это...

(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
  (iter a 0))

; тест

(define (inc n) (+ n 1))

(define (cube x) (* x x x))

(define (sum-cubes a b)
  (sum-iter cube a inc b))

(check-eq? (sum-cubes 1 10)
           (apply + (map cube '(1 2 3 4 5 6 7 8 9 10))))