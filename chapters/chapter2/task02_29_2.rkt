#lang racket

(require rackunit)

; г. Допустим, мы изменили представление мобилей, так что конструкторы теперь приняли такой вид:
; (define (make-mobile left right)
;   (cons left right))
;
; (define (make-branch length structure)
;   (cons length structure))
;
; Как много Вам нужно изменить в программах, чтобы перейти на новое представление?


; Нужно изменить реализацию селекторов - left-branch, right-branch, branch-length и branch-structure

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch m) (car m))

(define (right-branch m) (cdr m)) ; изменена

(define (branch-length b) (car b))

(define (branch-structure b) (cdr b)) ; изменена

(define (total-weight m)
  (if (not (pair? m))
      m
      (+ (total-weight (branch-structure (left-branch m)))
           (total-weight (branch-structure (right-branch m))))))

(define (balanced? m)
  (if (pair? m)
      (and (branch-angular-momentums-eq? m)
           (balanced? (branch-structure (left-branch m)))
           (balanced? (branch-structure (right-branch m))))
      true))

(define (branch-angular-momentums-eq? m)
  (eq? (angular-momentum (left-branch m))
       (angular-momentum (right-branch m))))

(define (angular-momentum b)
  (* (branch-length b)
     (total-weight (branch-structure b))))


; тест

; а. 
(define lb (make-branch 1 100))
(define rb (make-branch 2 200))
(define m  (make-mobile lb rb))

(define lb2 (make-branch 3 300))
(define rb2 (make-branch 4 m))
(define m2  (make-mobile lb2 rb2))

(check-equal? (left-branch m) lb)

(check-equal? (right-branch m) rb)

(check-eq? (branch-length lb) 1)

(check-eq? (branch-structure lb) 100)

; б. 

(check-eq? (total-weight m) 300)

(check-eq? (total-weight m2) 600)

; в. 

(define balanced-mobile 
  (make-mobile (make-branch 1 100)
               (make-branch 2 50)))

(define not-balanced-mobile
  (make-mobile (make-branch 1 100)
               (make-branch 1 50)))

(define balanced-deep-mobile 
  (make-mobile (make-branch 1 (total-weight balanced-mobile))
               (make-branch 1 balanced-mobile)))

(define not-balanced-deep-mobile-with-not-balanced-submibiles
  (make-mobile (make-branch 1 not-balanced-mobile)
               (make-branch 1 not-balanced-mobile)))

(define not-balanced-deep-mobile-with-balanced-submibiles
  (make-mobile (make-branch 2 balanced-mobile)
               (make-branch 1 balanced-mobile)))


(check-true  (balanced? balanced-mobile))

(check-false (balanced? not-balanced-mobile))

(check-true  (balanced? balanced-deep-mobile))

(check-false (balanced? not-balanced-deep-mobile-with-not-balanced-submibiles))

(check-false (balanced? not-balanced-deep-mobile-with-balanced-submibiles))