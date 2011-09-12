#lang racket

(require rackunit
         "test_helper.rkt")


; Покажите, что числа Кармайкла, перечисленные в сноске 47, действительно «обманывают» тест
; Ферма: напишите процедуру, которая берет целое число n и проверяет, правда ли an равняется a
; по модулю n для всех a < n, и проверьте эту процедуру на этих числах Кармайкла


(define (charmichael-prime-test? n)
  (fast-prime? n (- n 1)))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (square x) (* x x))


; Проверим числа Кармайкла тестом Ферма

(check-true (andmap 
             charmichael-prime-test? 
             '(561 1105 1729 2465 2821 6601))) ; => true


