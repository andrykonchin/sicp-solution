#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Покажите, что можно представлять пары неотрицательных целых чисел, используя только числа
; и арифметические операции, если представлять пару a и b как произведение (2^a)*(3^b). 
; Дайте соответствующие определения процедур cons, car и cdr.

(define (cons a b )
  (* (expt 2 a) (expt 3 b)))


(define (cdr c)
  (define (count c)
    (if (not (= (remainder c 3) 0))
        0
        (+ 1 (count (/ c 3)))))
  (count c))

(define (car c)
  (define (count c)
    (if (not (= (remainder c 2) 0))
        0
        (+ 1 (count (/ c 2)))))
  (count c))

; тесты

(check-eq? (car (cons 6 9)) 6)

(check-eq? (cdr (cons 6 9)) 9)