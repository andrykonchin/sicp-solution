#lang racket

(require "lib/vec-segment.rkt"
         "lib/vector.rkt"
         "lib/frame.rkt")

; С помощью segments->painter определите следующие элементарные рисовалки:
; а. Рисовалку, которая обводит указанную рамку.
; б. Рисовалку, которая рисует «Х», соединяя противоположные концы рамки.
; в. Рисовалку, которая рисует ромб, соединяя между собой середины сторон рамки.
; г. Рисовалку wave.

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (draw-line) null)

;=============

; а
(define (painter-borders frame)
  (segments->painter (list (make-segment (make-vect 0 0) (make-vect 1 0))
                           (make-segment (make-vect 1 0) (make-vect 1 1))
                           (make-segment (make-vect 1 1) (make-vect 0 1))
                           (make-segment (make-vect 0 1) (make-vect 0 0)))
                     frame))

; б
(define (painter-x frame)
  (segments->painter (list (make-segment (make-vect 0 0) (make-vect 1 1))
                           (make-segment (make-vect 1 0) (make-vect 0 1)))
                     frame))

; в
(define (painter-rhombus frame)
  (segments->painter (list (make-segment (make-vect 0.5 0  ) (make-vect 1   0.5))
                           (make-segment (make-vect 1   0.5) (make-vect 0.5 1  ))
                           (make-segment (make-vect 0.5 1  ) (make-vect 0   0.5))
                           (make-segment (make-vect 0   0.5) (make-vect 0.5 0  )))
                     frame))

; г

; .....