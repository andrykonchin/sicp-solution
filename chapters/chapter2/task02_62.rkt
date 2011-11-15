#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Дайте представление порядка Θ(n) для операции union-set с представлением 
; в виде упорядоченных списков

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((< (car set1) (car set2)) (cons (car set1) (union-set (cdr set1) set2)))
        ((> (car set1) (car set2)) (cons (car set2) (union-set set1 (cdr set2))))
        (else (cons (car set2) (union-set (cdr set1) (cdr set2))))))

; тест

(check-equal? (union-set '(1 2 3 4) '(3 4 5 6))
              '(1 2 3 4 5 6))

(check-equal? (union-set '(3 4 5 6) '(1 2 3 4))
              '(1 2 3 4 5 6))