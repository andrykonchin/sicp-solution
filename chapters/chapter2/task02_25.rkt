#lang racket

(require rackunit)

; Укажите комбинации car и cdr, которые извлекают 7 из следующих списков:
; (1 3 (5 7) 9)
; ((7))
; (1 (2 (3 (4 (5 (6 7))))))



(check-eq? (car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
           7)

(check-eq? (car (car '((7))))
           7)

(check-eq? (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr '(1 (2 (3 (4 (5 (6 7))))))))))))))))))
           7)