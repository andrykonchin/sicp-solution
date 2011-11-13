#lang racket

(require rackunit
         "lib/deriv.rkt")

; Покажите, как расширить простейшую программу дифференцирования так, чтобы она воспринимала
; больше разных типов выражений. Например, реализуйте правило взятия производной
;
;  d(u^n)               du
; ------- = n*u^(n−1)*(----)
;   dx                  dx
;
; добавив еще одну проверку к программе deriv и определив соответствующие процедуры exponentiation?,
; base, exponent и make-exponentiation (обозначать возведение в степень можно символом **). 
; Встройте правила, что любое выражение, возведенное в степень 0, дает 1,
; а возведенное в степень 1 равно самому себе.

(define (deriv-with-exp exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-with-exp (addend exp) var)
                   (deriv-with-exp (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv-with-exp (multiplicand exp) var))
          (make-product (deriv-with-exp (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-product (make-exponentiation (base exp) (- (exponent exp) 1)) 
                                     (deriv-with-exp (base exp) var))))
        (else
         (error "неизвестный тип выражения -- DERIV" exp))))

(define (exponentiation? x)
  (and (list? x) (eq? (length x) 3) (eq? (car x) '**)))

(define (exponent e) (caddr e))

(define (base e) (cadr e))

(define (make-exponentiation a n)
  (cond
    ((eq? n 0) 1)
    ((eq? n 1) a)
    (else (list '** a n))))

; тест

(check-equal? (deriv-with-exp '(+ x (** x 4)) 'x)
              '(+ 1 (* 4 (** x 3))))

(check-equal? (deriv-with-exp '(** x 2) 'x)       ; => x^1 => x
              '(* 2 x))

(check-equal? (deriv-with-exp '(** x 1) 'x)       ; => x^0 => 1
              '1)

(check-equal? (deriv-with-exp '(* (* x y) (+ x 3)) 'x)
              '(+ (* x y) (* y (+ x 3))))