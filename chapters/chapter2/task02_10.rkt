#lang racket

; Бен Битобор, системный программист-эксперт, смотрит через плечо Лизы и замечает: 
; неясно, что должно означать деление на интервал, пересекающий ноль. 
; Модифицируйте код Лизы так, чтобы программа проверяла это условие и сообщала об ошибке, если оно возникает.

(define (div-interval x y)
  (if (contain-zero? y)
      (display "Error: division by zero!")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (contain-zero? i)
  (and (<= (lower-bound i) 0) (>= (upper-bound i) 0)))
  
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (make-interval a b) (cons a b))

(define (lower-bound i) (min (car i) (cdr i)))

(define (upper-bound i) (max (car i) (cdr i)))

; тесты

(div-interval (make-interval 1 2) (make-interval 1 2))
(div-interval (make-interval 1 2) (make-interval -1 1))
