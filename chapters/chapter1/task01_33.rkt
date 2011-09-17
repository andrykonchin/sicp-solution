#lang racket

(require rackunit
         "test_helper.rkt")

; Можно получить еще более общую версию accumulate (упражнение 1.32), если ввести понятие
; фильтра (filter) на комбинируемые термы. То есть комбинировать только те термы, порожденные
; из значений диапазона, которые удовлетворяют указанному условию. Получающаяся абстракция
; filtered-accumulate получает те же аргументы, что и accumulate, плюс дополнительный
; одноаргументный предикат, который определяет фильтр. Запишите filtered-accumulate в
; виде процедуры. Покажите, как с помощью filtered-accumulate выразить следующее:
;
; а. сумму квадратов простых чисел в интервале от a до b (в предположении, что процедура
; prime? уже написана);


(define (filtered-accumulate predicate combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (predicate a)
          (combiner (term a) (filtered-accumulate predicate combiner null-value term (next a) next b))
          (filtered-accumulate predicate combiner null-value term (next a) next b))))

(define (prime-square-sum a b)
  (define (square x ) (* x x))
  (define (prime? x) #t)
  (define (inc x) (+ x 1))
  (filtered-accumulate prime? + 0 square a inc b))


; б. произведение всех положительных целых чисел меньше n, которые просты по отношению к
; n (то есть всех таких положительных целых чисел i < n, что НОД(i, n) = 1)

(define (prime-product n)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define (prime-n? x) (= (gcd x n) 1))
  (define (inc x) (+ x 1))
  (define (identity x) x)
  (filtered-accumulate prime-n? * 1 identity 1 inc (- n 1)))

; тест

(check-eq? (prime-product 8) (* 1 3 5 7))
(check-eq? (prime-product 21) (* 1 2 4 5 8 10 11 13 16 17 19 20))