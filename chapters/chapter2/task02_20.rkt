#lang racket

(require rackunit)

; Используя эту (точечную) нотацию, напишите процедуру same-parity, которая принимает одно или
; более целое число и возвращает список всех тех аргументов, у которых четность та же, что у
; первого аргумента

(define (same-parity n . lst)
  (select (cons n lst) 
          (lambda (x) (eq? (even? n) (even? x)))))

(define (select lst predicate)
  (if (null? lst)
      null
      (if (predicate (car lst))
          (cons (car lst) (select (cdr lst) predicate))
          (select (cdr lst) predicate))))

; тест

(check-equal? (same-parity 1 2 3 4 5 6 7)
              '(1 3 5 7))

(check-equal? (same-parity 2 3 4 5 6 7)
              '(2 4 6))

(check-equal? (same-parity 2)
              '(2))