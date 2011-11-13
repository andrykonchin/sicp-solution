#lang racket

(require rackunit)

; Двумерный вектор v, идущий от начала координат к точке, можно представить в виде пары,
; состоящей из x-координаты и y-координаты. Реализуйте абстракцию данных для векторов, 
; написав конструктор make-vect и соответствующие селекторы xcor-vect и ycor-vect. 
; В терминах своих селекторов и конструктора реализуйте процедуры add-vect, sub-vect и scale-vect,
; которые выполняют операции сложения, вычитания векторов и умножения вектора на скаляр:
;   (x1, y1) + (x2, y2) = (x1 + x2, y1 + y2)
;   (x1, y1) − (x2, y2) = (x1 − x2, y1 − y2)
;   s * (x, y) = (sx, sy)

(define (make-vect x y) (cons x y))

(define (xcor-vect v) (car v))

(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
             (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
             (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

; тесты

(check-eq? (xcor-vect (make-vect 1 2))
           1)

(check-eq? (ycor-vect (make-vect 1 2))
           2)

(check-equal? (add-vect (make-vect 1 2) (make-vect 3 4))
              (make-vect 4 6))

(check-equal? (sub-vect (make-vect 1 2) (make-vect 3 4))
              (make-vect -2 -2))

(check-equal? (scale-vect 2 (make-vect 1 2))
              (make-vect 2 4))