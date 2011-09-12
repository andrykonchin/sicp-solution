#lang racket

(require rackunit
         "test_helper.rkt")

; Существует хитрый алгоритм получения чисел Фибоначчи за логарифмическое число шагов.
; Вспомните трансформацию переменных состояния a и b процесса fib-iter из раздела 1.2.2:
; a ← a + b и b ← a. Назовем эту трансформацию T и заметим, что n-кратное применение T, начиная
; с 1 и 0, дает нам пару Fib(n + 1) и Fib(n). Другими словами, числа Фибоначчи получаются
; путем применения Tn, n-ой степени трансформации T, к паре (1,0). Теперь рассмотрим T как
; частный случай p = 0, q = 1 в семействе трансформаций Tpq, где Tpq преобразует пару (a, b) по
; правилу a ← bq + aq + ap, b ← bp + aq. Покажите, что двукратное применение трансформации
; Tpq равносильно однократному применению трансформации Tp′q′ того же типа, и вычислите p′ и q′
; через p и q. Это дает нам прямой способ возводить такие трансформации в квадрат, и таким
; образом, мы можем вычислить Tn с помощью последовательного возведения в квадрат, как в
; процедуре fast-expt. Используя все эти идеи, завершите следующую процедуру, которая дает
; результат за логарифмическое число шагов ...


; Покажем что существуют p' и q', для которых
; Tp′q′ = Tpq(Tpq)
;
; Выразим преобразование Tpq(Tpq) как функцию от a и b
;
; На первом шаге
; a ← bq + aq + ap
; b ← bp + aq
;
; На втором шаге
; a ← (bp + aq)q + ( bq + aq + ap)q + ( bq + aq + ap)p
; b ← (bp + aq)p + (bq + aq + ap)q
;
; Приведем подобные и попробуем привести к виду Tpq
; a ← b(2pq + q^2) + a(2qp + q^2) + a(q^2 + p^2)
; b ← b(q^2 + p^2) + a(2qp + q^2)
;
; Очевидно, что двукратное преобразование Tpq может быть выражено как Tp′q′, где
; q' = 2pq + q^2
; p' = q^2 + p^2

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q)) ; вычислить p’
                   (+ (* 2 p q) (square q))  ; вычислить q’
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(define (square x) (* x x))

; тесты

(check-eq? (fib 1) 1)
(check-eq? (fib 2) 1)
(check-eq? (fib 3) 2)
(check-eq? (fib 4) 3)
(check-eq? (fib 5) 5)
(check-eq? (fib 6) 8)
(check-eq? (fib 7) 13)

