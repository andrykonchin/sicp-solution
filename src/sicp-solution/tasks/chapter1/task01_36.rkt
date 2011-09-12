#lang racket

; Измените процедуру fixed-point так, чтобы она печатала последовательность приближений,
; которые порождает, с помощью примитивов newline и display, показанных в упражнении 1.22. 
; Затем найдите решение уравнения x^x = 1000 путем поиска неподвижной точки x → log(1000)/ log(x).
; Посчитайте, сколько шагов это занимает при использовании торможения
; усреднением и без него.


(define (fixed-point-mod f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (newline)
  (display 'start)
  (newline)
  (try first-guess))

; Решение уравнения x^x = 1000

(define (f x)
  (/ (log 1000) (log x)))

(fixed-point-mod f 10) ; => 4.555532257016376

; Сравнение вычисления с усреднением и без
; Без усреднений - 33 шага, с устреднением - 10

(define (average-dump f)
  (define (average a b) (/ (+ a b) 2))
  (lambda (x) (average x (f x))))

(fixed-point-mod (average-dump f) 10)