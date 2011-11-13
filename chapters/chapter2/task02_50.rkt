#lang racket

(require "lib/transform-painter.rkt"
         "lib/vector.rkt")

; Определите преобразование flip-horiz, которое обращает изображение 
; вокруг горизонтальной оси, а также преобразования,
; которые вращают рисовалки против часовой стрелки на 180 и 270 градусов.

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)   ; новая исходная точка
                     (make-vect 0.0 0.0)   ; новый конец edge1
                     (make-vect 1.0 1.0))) ; новый конец edge2

(define (flip-180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)   ; новая исходная точка
                     (make-vect 0.0 1.0)   ; новый конец edge1
                     (make-vect 1.0 0.0))) ; новый конец edge2

(define (flip-270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)   ; новая исходная точка
                     (make-vect 0.0 0.0)   ; новый конец edge1
                     (make-vect 1.0 1.0))) ; новый конец edge2

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)   ; новая исходная точка
                     (make-vect 1.0 1.0)   ; новый конец edge1
                     (make-vect 0.0 0.0))) ; новый конец edge2


