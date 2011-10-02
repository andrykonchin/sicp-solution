#lang racket

(require rackunit)

; Определите процедуру square-tree, подобную процедуре square-list из упражнения 2.21. 
; Определите square-tree как прямо (то есть без использования процедур высших порядков), 
; так и с помощью map и рекурсии

(define (square-tree-direct-version tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree-direct-version (car tree))
                    (square-tree-direct-version (cdr tree))))))

(define (square-tree-map-version tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map-version sub-tree)
             (square sub-tree)))
       tree))

(define (square x) (* x x))

; тест

(check-equal? (square-tree-direct-version (list 1
                                                (list 2 (list 3 4) 5)
                                                (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))


(check-equal? (square-tree-map-version (list 1
                                             (list 2 (list 3 4) 5)
                                             (list 6 7)))
              '(1 (4 (9 16) 25) (36 49)))