#lang racket

(require "lib/transform-painter.rkt"
         "lib/vector.rkt")

; Определите для рисовалок операцию below. Below принимает в качестве аргументов две рисовалки. 
; Когда получившейся рисовалке передается рамка, она рисует в нижней ее половине при
; помощи первой рисовалки, а в верхней при помощи второй. 
; Определите below двумя способами — один раз аналогично процедуре beside, как она приведена выше, 
; а второй раз через beside и операции вращения

(define (below-using-transform painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-bottom
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              (make-vect 0.0 1.0)
                              split-point))
          (paint-top
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.0 1.0))))
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))

(define (below-using-rotation painter1 painter2)
  (define (rotate-90 painter)
    (transform-painter painter
                       (make-vect 0.0 1.0)
                       (make-vect 0.0 0.0)
                       (make-vect 1.0 1.0)))
  (define (rotate-back-90 painter)
    (transform-painter painter
                       (make-vect 1.0 0.0)
                       (make-vect 0.0 0.0)
                       (make-vect 1.0 1.0)))
  (rotate-back-90 (beside (rotate-90 painter1) 
                          (rotate-90 painter2))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))