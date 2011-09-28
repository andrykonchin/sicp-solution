#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Покажите, что, если предположить, что погрешность составляет малую долю величины интервала,
; то погрешность в процентах произведения двух интервалов можно получить из погрешности в
; процентах исходных интервалов по простой приближенной формуле. Задачу можно упростить,
; если предположить, что все числа положительные.

; Точная формула для вычисления погрешности в процентах: dzp = dxp + dyp + dx*dyp
; Приближенная формула: dzp = dxp + dyp 

(define (mul-positive-interval x y)
  (make-center-percent (* (center  x) (center  y))
                       (+ (percent x) (percent y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-center-percent c p)
  (let (( w (* c (/ p 100.0))))
    (make-interval (- c w) (+ c w))))

(define (percent i)
  (* (/ (width i) (center i)) 100.0))
  
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2.0))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-interval a b) (cons a b))

(define (lower-bound i) (car i))

(define (upper-bound i) (cdr i))


; тесты

(define i1 (make-center-percent 10 0.1))
(define i2 (make-center-percent 20 0.1))

(check-close? (percent (mul-interval          i1 i2))
              (percent (mul-positive-interval i1 i2)))