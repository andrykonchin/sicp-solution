#lang racket

(require "lib/interval.rkt")

; Бен Битобор, системный программист-эксперт, смотрит через плечо Лизы и замечает: 
; неясно, что должно означать деление на интервал, пересекающий ноль. 
; Модифицируйте код Лизы так, чтобы программа проверяла это условие и сообщала об ошибке, если оно возникает.

(define (div-interval-upd x y)
  (if (contain-zero? y)
      (display "Error: division by zero!")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define (contain-zero? i)
  (and (<= (lower-bound i) 0) 
       (>= (upper-bound i) 0)))

; тесты

(div-interval-upd (make-interval 1 2) (make-interval  1 2)) ; => '(0.5 . 2.0)
(div-interval-upd (make-interval 1 2) (make-interval -1 1)) ; => Error: division by zero!
