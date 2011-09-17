#lang racket

(require rackunit
         "test_helper.rkt")


; а. Процедура sum — всего лишь простейшая из обширного множества подобных абстракций,
; которые можно выразить через процедуры высших порядков.
; Напишите аналогичную процедуру под названием product, которая вычисляет произведение 
; значений функции в точках на указанном интервале. 
; Покажите, как с помощью этой процедуры определить factorial. 
; Кроме того, при помощи product вычислите приближенное значение π по формуле:
;
; pi   2*4*4*6*6*8 ...
; -- = ---------------
; 4    3*3*5*5*7*7 ...

(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))


(define (factorial n)
  (define (identity x) x)
  (define (inc x) (+ x 1))
  (product identity 1 inc n))

(define (pi-new n)
  (define (inc x) (+ x 1))
  (define (pi-term k)
    (if (even? k)
        (/ (+ k 2) (+ k 3))
        (/ (+ k 3) (+ k 2))))
  (* 4.0 (product pi-term 0.0 inc n)))

; тесты

(check-eq? (factorial 10)
           (* 1 2 3 4 5 6 7 8 9 10))
(check-close? (pi-new 1000000) pi)


; б. Если Ваша процедура product порождает рекурсивный процесс, перепишите ее так, чтобы
; она порождала итеративный. Если она порождает итеративный процесс, перепишите ее так, чтобы
; она порождала рекурсивный.

(define (product-rec term a next b)
  (if (> a b)
      1
      (* (term a) (product-rec term (next a) next b))))