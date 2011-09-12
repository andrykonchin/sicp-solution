#lang racket

(require rackunit
         "test_helper.rkt")

; Проверка good-enough?, которую мы использовали для вычисления квадратных корней, будет
; довольно неэффективна для поиска квадратных корней от очень маленьких чисел. Кроме того, в
; настоящих компьютерах арифметические операции почти всегда вычисляются с ограниченной точностью. 
; Поэтому наш тест оказывается неадекватным и для очень больших чисел. Альтернативный
; подход к реализации good-enough? состоит в том, чтобы следить, как от одной итерации к другой
; изменяется guess, и остановиться, когда изменение оказывается небольшой долей значения
; приближения. Разработайте процедуру вычисления квадратного корня, которая использует такой
; вариант проверки на завершение. Верно ли, что на больших и маленьких числах она работает
; лучше?


(define (sqrt-iter-new guess x)
  (let ((improved-guess (improve guess x)))
    (if (good-enough-new? guess improved-guess)
        guess
        (sqrt-iter-new improved-guess x))))

(define (good-enough-new? guess improved-guess)
  (< (abs (- guess improved-guess)) (* guess 0.0001)))

(define (improve guess x)
  (average guess (next-guess guess x)))

(define (average x y) 
  (/ (+ x y) 2))

(define (next-guess guess x)
  (/ x guess))



; тесты

(check-close? (sqrt-iter-new 1 4.0) 2)