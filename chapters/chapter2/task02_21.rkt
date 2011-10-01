#lang racket

(require rackunit)

; Процедура square-list принимает в качестве аргумента список чисел и возвращает список
; квадратов этих чисел.
; (square-list (list 1 2 3 4))
; (1 4 9 16)
;
; Перед Вами два различных определения square-list. Закончите их, вставив пропущенные выражения:
;
; (define (square-list items)
;   (if (null? items)
;       nil
;       (cons <??> <??>)))
; 
; (define (square-list items)
;   (map <??> <??>))


(define (square-list-first items)
  (if (null? items)
      null
      (cons (square (car items)) (square-list-first (cdr items)))))

(define (square-list-second items)
  (map square items))

(define (square x) (* x x))

; тест

(check-equal? (square-list-first '(1 2 3 4))
              '(1 4 9 16))

(check-equal? (square-list-second '(1 2 3 4))
              '(1 4 9 16))