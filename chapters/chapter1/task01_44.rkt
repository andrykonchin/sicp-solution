#lang racket

(require "test_helper.rkt")

; Напишите процедуру smooth,
; которая в качестве ввода принимает процедуру, вычисляющую f, и возвращает процедуру,
; вычисляющую сглаженную версию f.

(define (smooth f)
  (define dx 0.0001)
  (lambda (x)
    (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))

; Покажите, как породить n-кратно сглаженную функцию с помощью smooth и
; repeated из упражнения 1.43.

(define (n-fold-smooth f n)
  (repeated (smooth f) n))

(define (repeated f n)
  (define (compose-n f n)
    (if (= n 1)
        f
        (compose f (compose-n f (- n 1)))))
  (define composed-function (compose-n f n))
  (lambda (x)
    (composed-function x)))

(define (compose f g)
  (lambda (x) (f (g x))))

; тесты

(check-close? ((smooth  cos)  1) (/ (+ (cos   0.9999) (cos   1) (cos   1.0001)) 3))
(check-close? ((smooth sqrt) 21) (/ (+ (sqrt 20.9999) (sqrt 21) (sqrt 21.0001)) 3))