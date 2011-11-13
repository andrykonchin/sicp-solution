#lang racket

(require rackunit
         "lib/deriv.rkt")

; Расширьте программу дифференцирования так, чтобы она работала с суммами и произведениями
; любого (больше двух) количества термов. Тогда последний из приведенных выше примеров мог бы
; быть записан как
;
; (deriv ’(* x y (+ x 3)) ’x)
;
; Попытайтесь сделать это, изменяя только представление сумм и произведений, не трогая процедуру deriv. 
; Тогда, например, процедура addend будет возвращать первое слагаемое суммы, а augend сумму остальных.

(define (deriv-mod exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv-mod (addend exp) var)
                   (deriv-mod (augend-mod exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv-mod (multiplicand-mod exp) var))
          (make-product (deriv-mod (multiplier exp) var)
                        (multiplicand-mod exp))))
        (else
         (error "неизвестный тип выражения -- DERIV" exp))))

(define (augend-mod s)
  (if (> (length s) 3) 
      (append (list '+) (cddr s))
      (caddr s)))

(define (multiplicand-mod p)
  (if (> (length p) 3) 
      (append (list '*) (cddr p))
      (caddr p)))

; тест

(check-equal? (augend-mod '(+ 1 2 3))
              '(+ 2 3))

(check-equal? (multiplicand-mod '(* 1 2 3))
              '(* 2 3))

(check-equal? (deriv-mod '(* x y (+ x 3)) 'x)
              '(+ (* x y) (* y (+ x 3))))

(check-equal? (deriv-mod '(* (* x y) (+ x 3)) 'x)
              '(+ (* x y) (* y (+ x 3))))