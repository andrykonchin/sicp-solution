#lang racket

(require rackunit)

; Измените свою процедуру reverse из упражнения 2.18 так, чтобы получилась процедура deep-reverse, 
; которая принимает список в качестве аргумента и возвращает в качестве значения список, 
; где порядок элементов обратный и подсписки также обращены.

(define (deep-reverse lst)
  (cond
    ((null? lst) null)
    ((not (pair? lst)) lst)
    (else (append (deep-reverse (cdr lst))
                  (list (deep-reverse (car lst)))))))

; тест

(check-equal? (deep-reverse '((1 2) (3 4)))
              '((4 3) (2 1)))

(check-equal? (deep-reverse '(1 4 9 16 25))
              '(25 16 9 4 1))
