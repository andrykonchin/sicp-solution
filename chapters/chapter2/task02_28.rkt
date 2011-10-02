#lang racket

(require rackunit)

; Напишите процедуру fringe, которая берет в качестве аргумента дерево (представленное в виде списка) 
; и возвращает список, элементы которого — все листья дерева, упорядоченные слева направо. 

(define (fringe tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (fringe (car tree)) (fringe (cdr tree))))))

; тест

(define x (list (list 1 2) (list 3 4)))

(check-equal? (fringe x)
              '(1 2 3 4))

(check-equal? (fringe (list x x))
              '(1 2 3 4 1 2 3 4))