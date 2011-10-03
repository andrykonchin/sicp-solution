#lang racket

(require rackunit
         "lib/accumulate.rkt")
 
; Заполните пропущенные выражения, так, чтобы получились определения некоторых базовых 
; операций по работе со списками в виде накопления:
;
; (define (map p sequence) 
;   (accumulate (lambda (x y) ⟨??⟩) nil sequence))
;
; (define (append seq1 seq2)
;   (accumulate cons ⟨??⟩ ⟨??⟩))
;
; (define (length sequence) 
;   (accumulate ⟨??⟩ 0 sequence))

(define (map p sequence) 
  (accumulate (lambda (el lst) (cons (p el) lst)) null sequence))

(define (append seq1 seq2) 
  (accumulate cons seq2 seq1))

(define (length sequence) 
  (accumulate (lambda (el s) (+ s 1)) 0 sequence))


; тест

(check-equal? (map (lambda (x) (+ x 1)) 
                   '(1 2 3))
              '(2 3 4))

(check-equal? (append '(1 2 3) '(4 5 6))
              '(1 2 3 4 5 6))

(check-eq? (length '(1 2 3))
           3)