#lang racket

; Определите процедуру up-split, которую использует corner-split. 
; Она подобна right-split, но только меняет местами роли below и beside.
;
;(define (right-split painter n)
;  (if (= n 0)
;      painter
;      (let ((smaller (right-split painter (- n 1))))
;        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))



(define (beside) null)
(define (below) null)




