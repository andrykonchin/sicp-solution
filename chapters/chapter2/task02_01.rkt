#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Определите улучшенную версию mul-rat, которая принимала бы как положительные, так и
; отрицательные аргументы. Make-rat должна нормализовывать знак так, чтобы в случае, если
; рациональное число положительно, то и его числитель, и знаменатель были бы положительны, а
; если оно отрицательно, то чтобы только его числитель был отрицателен.


(define (mul-rat x y)
  (make-rat (* (number x) (number y))
            (* (denom  x) (denom  y))))

(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (normalize-sign-rat (cons (/ n g) (/ d g)))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (normalize-sign-rat x)
  (if (< (denom x) 0)
      (make-rat (- (number x)) (- (denom x)))
      x))

(define (number x) (car x))

(define (denom x) (cdr x))

; тесты

(check-eq? (mul-rat (make-rat 1 2)
                    (make-rat 1 2))
           (cons 1 2))

(check-eq? (mul-rat (make-rat 1 2)
                    (make-rat 1 -2))
           (cons -1 2))

(check-eq? (mul-rat (make-rat 1 2) 
                    (make-rat -1 2))
           (cons -1 2))

(check-eq? (mul-rat (make-rat 1 2) 
                    (make-rat -1 -2))
           (cons 1 2))