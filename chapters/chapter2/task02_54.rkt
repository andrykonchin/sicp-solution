#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Предикат equal? для двух списков возвращает истину, если они содержат одни и те же элементы
; в одинаковом порядке. Например,
;
; (equal? ’(this is a list) ’(this is a list))
;
; истинно, но
;
;(equal? ’(this is a list) ’(this (is a) list))
;
; ложно.
; Более точно, можно определить equal? рекурсивно в терминах базового равенства символов eq?, 
; сказав, что a равно b, если оба они символы и для них выполняется eq? либо оба они
; списки и при этом верно, что (car a) равняется в смысле equal? (car b), а (cdr a) равняется
; в смысле equal? (cdr b). Пользуясь этой идеей, напишите equal? в виде процедуры

(define (my-equal? a b)
  (cond ((and (pair? a) (pair? b)) 
         (and (my-equal? (car a) (car b))
              (my-equal? (cdr a) (cdr b))))
        ((and (not (pair? a)) (not (pair? b)))   
         (eq? a b))
        (else false)))

; тесты

(check-true (my-equal? 1 1))

(check-false (my-equal? 1 2))

(check-true (my-equal? '(1) '(1)))

(check-false (my-equal? '(1) '(2)))

(check-true (my-equal? '(1 2 (3) 4) '(1 2 (3) 4)))

(check-false (my-equal? '(1 2 (3) 4) '(1 2 3 4)))