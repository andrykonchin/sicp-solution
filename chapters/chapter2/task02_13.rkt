#lang racket

(require rackunit
         "../../utils/test_helper.rkt"
         "lib/interval.rkt")

; Покажите, что, если предположить, что погрешность составляет малую долю величины интервала,
; то погрешность в процентах произведения двух интервалов можно получить из погрешности в
; процентах исходных интервалов по простой приближенной формуле. Задачу можно упростить,
; если предположить, что все числа положительные.

; Точная формула для вычисления погрешности в процентах: dzp = dxp + dyp + dx*dyp
; Приближенная формула: dzp = dxp + dyp 

(define (mul-positive-interval x y)
  (make-center-percent (* (center  x) (center  y))
                       (+ (percent x) (percent y))))

; тесты

(define i1 (make-center-percent 10 0.1))
(define i2 (make-center-percent 20 0.1))

(check-close? (percent (mul-interval          i1 i2))
              (percent (mul-positive-interval i1 i2)))