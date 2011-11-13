#lang racket

(require rackunit
         "lib/enumerate.rkt"
         "lib/prime.rkt"
         "lib/accumulate.rkt")

; Определите процедуру unique-pairs, которая, получая целое число n, 
; порождает последовательность пар (i, j), таких, что 1 ≤ j < i ≤ n. 
; С помощью unique-pairs упростите данное выше определение prime-sum-pairs.

(define (prime-sum-pairs-v2 n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

(define (unique-pairs n)
  (flatmap (lambda (i) (map (lambda (j) (list i j))
                            (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

; =====

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                (lambda (i)
                  (map (lambda (j) (list i j))
                       (enumerate-interval 1 (- i 1))))
                (enumerate-interval 1 n)))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

; тест

(check-equal? (prime-sum-pairs-v2 5)
              (prime-sum-pairs    5))

(check-equal? (prime-sum-pairs-v2 21)
              (prime-sum-pairs    21))








