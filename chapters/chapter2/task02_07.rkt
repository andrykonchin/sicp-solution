#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Программа Лизы неполна, поскольку она не определила, как реализуется абстракция интервала.
; Вот определение конструктора интервала:
;   (define (make-interval a b) (cons a b))
; Завершите реализацию, определив селекторы upper-bound и lower-bound.

(define (make-interval a b) (cons a b))

(define (lower-bound i) (min (car i) (cdr i)))

(define (upper-bound i) (max (car i) (cdr i)))

; тесты

(check-eq? (lower-bound (make-interval 1 2))
           1)

(check-eq? (upper-bound (make-interval 1 2))
           2)