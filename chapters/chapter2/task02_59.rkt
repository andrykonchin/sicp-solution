#lang racket

(require rackunit
         "../../utils/test_helper.rkt"
         "lib/set.rkt")

; Реализуйте операцию union-set для представления множеств в виде неупорядоченных списков.

(define (union-set set1 set2)
  (cond ((null? set2) set1)
        ((element-of-set? (car set2) set1)
            (union-set set1 (cdr set2)))
        (else (cons (car set2) (union-set set1 (cdr set2))))))

; тест

(check-true (element-of-set? 1 (union-set '(1 2 3) '(2 3 4))))
(check-true (element-of-set? 2 (union-set '(1 2 3) '(2 3 4))))
(check-true (element-of-set? 3 (union-set '(1 2 3) '(2 3 4))))
(check-true (element-of-set? 4 (union-set '(1 2 3) '(2 3 4))))
