#lang racket

; Допустим, мы определили x и y как два списка

(define x (list 1 2 3))
(define y (list 4 5 6))

; Какой результат напечатает интерпретатор в ответ на следующие выражения

; (append x y)
; (cons x y)
; (list x y)

(append x y) ; => (1 2 3 4 5 6)
(cons x y)   ; => ((1 2 3) 4 5 6)
(list x y)   ; => ((1 2 3) (4 5 6))