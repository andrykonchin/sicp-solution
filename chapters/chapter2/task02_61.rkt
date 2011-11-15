#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Напишите реализацию adjoin-set для упорядоченного представления. 
; По аналогии с element-of-set? покажите, как использовать упорядочение, 
; чтобы получить процедуру, которая в среднем требует только половину числа шагов, 
; которое требуется при неупорядоченном представлении.

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((> x (car set)) (cons (car set) (adjoin-set x (cdr set))))
        ((equal? x (car set)) set)
        (else (cons x set))))

; тест

(check-equal? (adjoin-set 3 '(1 2 4))
              '(1 2 3 4))

(check-equal? (adjoin-set 3 '(1 2 3 4))
              '(1 2 3 4))

(check-equal? (adjoin-set 0 '(1 2 3 4))
              '(0 1 2 3 4))

(check-equal? (adjoin-set 5 '(1 2 3 4))
              '(1 2 3 4 5))