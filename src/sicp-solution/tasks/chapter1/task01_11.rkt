#lang racket

(require rackunit
         "test_helper.rkt")

; Функция f определяется правилом: f(n) = n, если n < 3, и f(n) = f(n−1)+f(n−2)+f(n−3),
; если n ≥ 3. Напишите процедуру, вычисляющую f с помощью рекурсивного процесса. Напишите
; процедуру, вычисляющую f с помощью итеративного процесса.


(define (f-recursive n)
  (if (< n 3)
      n
      (+ (f-recursive (- n 1)) (f-recursive (- n 2)) (f-recursive (- n 3)))))

(define (f-iterative n)
  (define (new-val prev-lst)
    (apply + prev-lst))
  (define (f-iter prev-lst current-n max-n)
    (if (> current-n  max-n)
        (caddr prev-lst)
        (f-iter (append (cdr prev-lst) (list (new-val prev-lst))) (+ current-n 1) max-n)))
  (if (< n 3)
      n
      (f-iter '(0 1 2) 3 n)))


; тесты

(check-eq? (f-recursive 1)          1)
(check-eq? (f-recursive 2)          2)
(check-eq? (f-recursive 3) (+  2 1 0))
(check-eq? (f-recursive 4) (+  3 2 1))
(check-eq? (f-recursive 5) (+  6 3 2))
(check-eq? (f-recursive 6) (+ 11 6 3))