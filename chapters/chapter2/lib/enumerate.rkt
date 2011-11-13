#lang racket

(define (enumerate-interval low high)
  (if (> low high)
      null
      (cons low (enumerate-interval (+ low 1) high))))

; (enumerate-interval 2 7)
; => (2 3 4 5 6 7)


(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

; (enumerate-tree (list 1 (list 2 (list 3 4)) 5))
; => (1 2 3 4 5)

(provide enumerate-interval
         enumerate-tree)