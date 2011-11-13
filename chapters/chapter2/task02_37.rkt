#lang racket

(require rackunit
         "lib/accumulate.rkt"
         "lib/accumulate-n.rkt")

; Заполните пропуски в следующих процедурах для вычисления остальных матричных операций.
; (Процедура accumulate-n описана в упражнении 2.36.)
;
; (define (matrix-*-vector m v)
;   (map <??> m))
;
; (define (transpose mat)
;   (accumulate-n <??> <??> mat))
;
; (define (matrix-*-matrix m n)
;   (let ((cols (transpose n)))
;     (map <??> m)))


(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (w) (dot-product v w))
       m))

(define (transpose m)
  (accumulate-n cons null m))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (map (lambda (col) (dot-product row col)) 
                            cols))
         m)))

; тест

(check-equal? (matrix-*-vector '((25 35 10) (15 27 8))
                               '(50 70 130))
              '(5000 3680))

(check-equal? (transpose '((1 2 3) (4 5 6) (7 8 9)))
              '((1 4 7) (2 5 8) (3 6 9)))

(check-equal? (matrix-*-matrix '((14 21 6) (2 52 30))
                               '((10 17) (93 -2) (-1 5)))
              '((2087 226) (4826 80)))