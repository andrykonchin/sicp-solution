#lang racket

(require rackunit)

; Вот два варианта конструкторов для рамок:
;
; (define (make-frame origin edge1 edge2)
;   (list origin edge1 edge2))
;
; (define (make-frame origin edge1 edge2)
;   (cons origin (cons edge1 edge2)))


(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame) (car frame))

(define (edge1-frame frame) (cadr frame))

(define (edge2-frame frame) (cddr frame))


; тесты

(define frame (make-frame 1 2 3))

(check-equal? (origin-frame frame) 1)

(check-equal? (edge1-frame frame)  2)

(check-equal? (edge2-frame frame)  3)
