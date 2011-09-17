#lang racket

(require rackunit
         "test_helper.rkt")

; С помощью правила Симпсона интеграл функции f между a и b приближенно вычисляется в виде
;
;    (h/3)[y0 + 4y1 + 2y2 + 4y3 + 2y4 + . . . + 2yn−2 + 4yn−1 + yn]
;
; где h = (b − a)/n, для какого-то четного целого числа n, а yk = f(a + kh). 
; (Увеличение n повышает точность приближенного вычисления.) Определите процедуру, которая принимает в качестве
; аргументов f, a, b и n, и возвращает значение интеграла, вычисленное по правилу Симпсона. 


(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpson-integral f a b n)
  (define (calc-y k h) (f (+ a (* h k))))
  (define (term-coeff k)
    (cond 
      ((= k 0)   1)
      ((= k n)   1)
      ((even? k) 2)
      (else      4)))
  (define (term k h)
    (* (term-coeff k) (calc-y k h)))
  (define (term-sum k h)
    (define (iter k result)
      (if (> k n)
          result
          (iter (+ k 1) (+ result (term k h)))))
    (iter 0 0.0))
  (let ((h (/ (- a b) n)))
    (* (/ h 3) (term-sum 0 h))))


; С помощью этой процедуры проинтегрируйте cube между 0 и 1 (с n = 100 и n = 1000) и сравните
; результаты с процедурой integral, приведенной выше.

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2)) add-dx b) dx))

(define (cube x)
  (* x x x))

(simpson-integral cube 0 1 100)   ; => 0.25
(simpson-integral cube 0 1 1000)  ; => 0.25000000000000006

(integral cube 0 1 0.001)         ; => 0.249999875000001
(integral cube 0 1 0.000001)      ; => 0.2500000000014447


; Алгоритм Симпсона дает точное значение интеграла. 
; Функция integral выячисляет интеграл с некоторой погрешностью и для точных вычислений требуется уменьшить шаг вычислений, 
; что приводит к увеличению времени вычисления