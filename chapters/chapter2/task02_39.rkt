#lang racket

(require rackunit
         "lib/fold.rkt")

; Закончите следующие определения reverse (упражнение 2.18) в терминах процедур 
; fold-right и fold-left из упражнения 2.38.
;
; (define (reverse sequence)
;   (fold-right (lambda (x y) <??>) nil sequence))
;
; (define (reverse sequence)
;   (fold-left (lambda (x y) <??>) nil sequence))

(define (reverse-v1 sequence)
  (fold-right (lambda (x lst) (append lst (list x)))
              null
              sequence))

(define (reverse-v2 sequence)
  (fold-left (lambda (lst x) (cons x lst))
             null
             sequence))

; тест

(check-equal? (reverse-v1 '(1 2 3 4))
              '(4 3 2 1))

(check-equal? (reverse-v2 '(1 2 3 4))
              '(4 3 2 1))