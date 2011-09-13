#lang racket

(require rackunit
         "test_helper.rkt")

; Лиза П. Хакер жалуется, что при написании expmod мы делаем много лишней работы. В конце
; концов, говорит она, раз мы уже знаем, как вычислять степени, можно просто написать
;
; (define (expmod base exp m)
;   (remainder (fast-expt base exp) m))
;
; Права ли она? Стала бы эта процедура столь же хорошо работать при проверке простых чисел?
; Объясните.


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (square x) (* x x))

 (define (expmod-alt base exp m)
   (remainder (fast-expt base exp) m))
 
 (define (fast-expt b n)
   (cond ((= n 0) 1)
         ((even? n) (square (fast-expt b (/ n 2))))
         (else (* b (fast-expt b (- n 1))))))


; Определим время работы обоих версий функции возведения в степень по модулю
 
(time-test expmod-alt '(1000000 1000000 10)) ; => 2494.0
(time-test expmod     '(1000000 1000000 10)) ; => 1.0

; Предложенная Лизой П. Хакер версия функции выполняет вычисления за значительно большее время.
; Реализация expmod работает эффективнее так как на каждом шаге вычисляется остаток от деления и
; в вычислениях участвуют числа значительно меньшего порядка чем в expmod-alt.
