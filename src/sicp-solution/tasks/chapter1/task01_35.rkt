#lang racket

(require rackunit
         "test_helper.rkt")

; Покажите, что золотое сечение φ (раздел 1.2.2) есть неподвижная точка трансформации 
; x → 1 + 1/x, и используйте этот факт для вычисления φ с помощью процедуры fixed-point

; Задана функция
; y = 1 + 1/x

; Фиксированная точка - решение уравнения
; x = 1 + 1/x
; x^2 = x + 1
; x^2 - x - 1 = 0

; Решаем квадратное уравнение
; D = b^2 - 4ac
; D = (-1)^2 - 4*1*(-1) = 1 + 4 = 5

;        1 + sqrt(5) 
; x1 = --------------
;            2
           
;        1 - sqrt(5) 
; x2 = --------------
;            2
           
; x1 = φ, соответственно φ является неподвижной точкой исходной функции



; вычисление φ с помощью процедуры fixed-point

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

(define fi-etalon (/ (+ 1 (sqrt 5)) 2))

(define (fi) 
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1))

(check-close? fi-etalon (fi))
