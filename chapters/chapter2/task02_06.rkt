#lang racket

(require rackunit
         "../../utils/test_helper.rkt")

; Определите one (единицу) и two (двойку) напрямую (не через zero и add-1). 
; Дайте прямое определение процедуры сложения + (не в терминах повторяющегося применения add-1).

(define (plus m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(define two (lambda (f) (lambda (x) (f (f x)))))

(define one (lambda (f) (lambda (x) (f x))))

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; тесты

(check-equal? ((one cdr) '(1 2 3 4))
              '(2 3 4))

(check-equal? ((two cdr) '(1 2 3 4))
              '(3 4))

(check-equal? (((plus one two) cdr) '(1 2 3 4 ))
              '(4))