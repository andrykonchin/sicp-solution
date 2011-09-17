#lang racket

(require "test_helper.rkt")

; Проделайте эксперименты, чтобы понять, сколько торможений усреднением нужно, чтобы вычислить
; корень n-ой степени как неподвижную точку на основе многократного торможения усреднением
; функции y → x/yn−1. 
; Используя свои результаты для того, напишите простую процедуру вычисления корней n-ой степени
; с помощью процедур fixed-point, average-damp и repeated из упражнения 1.43


(define (root-n x n)
  (define (f y) (/ x (expt y (- n 1))))
  (define (repeat-count i)
    (ceiling (/ (log (+ i 1)) (log 2))))
  (fixed-point ((repeated average-dump (repeat-count n)) f) 1.0))

(define (average-dump f)
  (define (average a b) (/ (+ a b) 2))
  (lambda (x) (average x (f x))))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

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

(check-close? (root-n 9 1) (expt 9 (/ 1 1)))
(check-close? (root-n 9 2) (expt 9 (/ 1 2)))
(check-close? (root-n 9 3) (expt 9 (/ 1 3)))
(check-close? (root-n 9 4) (expt 9 (/ 1 4)))
(check-close? (root-n 9 5) (expt 9 (/ 1 5)))

(check-close? (root-n 9 10) (expt 9 (/ 1 10)))
(check-close? (root-n 9 30) (expt 9 (/ 1 30)))
(check-close? (root-n 9 60) (expt 9 (/ 1 60)))
(check-close? (root-n 9 99) (expt 9 (/ 1 99)))