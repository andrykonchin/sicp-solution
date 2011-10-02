#lang racket

(require rackunit)

; Определите процедуру last-pair, которая возвращает список, содержащий только последний
; элемент данного (непустого) списка.

(define (last-pair lst)
  (if (null? (cdr lst))
      lst
      (last-pair (cdr lst))))

; тест

(check-equal? (last-pair '(23 72 149 34))
              '(34))

(check-equal? (last-pair '(34))
              '(34))
         