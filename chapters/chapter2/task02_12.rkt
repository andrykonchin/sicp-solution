#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Определите конструктор make-center-percent, который принимает среднее значение и 
; погрешность в процентах и выдает требуемый интервал. Нужно также определить селектор percent,
; который для данного интервала выдает погрешность в процентах. Селектор center остается тем
; же, что приведен выше.


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

(check-equal? (make-center-percent 10 1)
              (make-interval 9.9 10.1))

(check-close? (percent (make-center-percent 10 1)) 1)

(check-close? (center (make-center-percent 10 1)) 10)