#lang racket

(require rackunit)

; Определите процедуру reverse, которая принимает список как аргумент и возвращает список,
; состоящий из тех же элементов в обратном порядке

(define (reverse lst)
  (if (null? lst)
      null
      (append (reverse (cdr lst)) (list (car lst)))))

; тест

(check-equal? (reverse '(1 4 9 16 25))
              '(25 16 9 4 1))