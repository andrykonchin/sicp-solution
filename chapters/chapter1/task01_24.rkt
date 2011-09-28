#lang racket

(require rackunit
         "test_helper.rkt")

; Модифицируйте процедуру timed-prime-test из упражнения 1.22 так, чтобы она использовала
; fast-prime? (метод Ферма) и проверьте каждое из 12 простых чисел, найденных в этом упражнении. 
; Исходя из того, что у теста Ферма порядок роста Θ(log n), то какого соотношения времени
; Вы бы ожидали между проверкой на простоту поблизости от 1 000 000 и поблизости от 1000?
; Подтверждают ли это Ваши данные? Можете ли Вы объяснить наблюдаемое несоответствие, если оно есть?


(define (search-for-primes a b)
  (if (> a b)
      '()
      (if (and (not (even? a)) (timed-prime-test a))
          (append (list a) (search-for-primes (+ a 2) b))
          (search-for-primes (+ a 1) b))))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-inexact-milliseconds)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (or (report-prime (- (current-inexact-milliseconds) start-time)) #t)
      #f))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (prime? n)
  (fast-prime? n 100))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (random-module (- n 1))))))

(define (random-module n)
  (if (> n 4294967087)
      4294967087
      n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (square x) (* x x))


; Проверим найденные ранее 12 простых чисел тестом Ферма

(fast-prime?    1009 100) ; => #t
(fast-prime?    1013 100) ; => #t
(fast-prime?    1019 100) ; => #t
(fast-prime?   10007 100) ; => #t
(fast-prime?   10009 100) ; => #t
(fast-prime?   10037 100) ; => #t
(fast-prime?  100003 100) ; => #t
(fast-prime?  100019 100) ; => #t
(fast-prime?  100043 100) ; => #t
(fast-prime? 1000003 100) ; => #t
(fast-prime? 1000033 100) ; => #t
(fast-prime? 1000037 100) ; => #t

; Все числа прошли тест Ферма
; Проверим во сколько увеличится время прохождения теста Ферма.
; Ожидаемое соотношение - log(10^6)/log(10^3) ~ 2

(time (for-each prime? (make-list 1000 1009 )))
; cpu time: 437 real time: 440 gc time: 0

(time (for-each prime? (make-list 1000 1000003 )))
; cpu time: 764 real time: 765 gc time: 0

; Ожидаемое соотношение подтверждается 