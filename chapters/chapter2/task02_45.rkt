#lang racket

; Right-split и up-split можно выразить как разновидности общей операции разделения.
; Определите процедуру split с таким свойством, что вычисление
;
; (define right-split (split beside below))
; (define up-split (split below beside))
;
; порождает процедуры right-split и up-split с таким же поведением, 
; как и определенные ранее.

(define (split op1 op2)
  (define custom-split (lambda (painter n)
                         (if (= n 0)
                             painter
                             (let ((smaller (custom-split painter (- n 1))))
                               (op1 painter (op2 smaller smaller))))))
  custom-split)

(define (beside) null)
(define (below) null)

(define right-split (split beside below))
(define up-split    (split below beside))