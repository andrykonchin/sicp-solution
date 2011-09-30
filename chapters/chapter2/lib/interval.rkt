#lang racket

(define (print-center-percent r)
  (newline)
  (display (center r))
  (display " ; ")
  (display (percent r)))

(define (make-center-percent c p)
  (let (( w (* c (/ p 100.0))))
    (make-interval (- c w) (+ c w))))

(define (percent i)
  (* (/ (width i) (center i)) 100.0))
  
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2.0))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (make-interval a b) (cons a b))

(define (lower-bound i) (min (car i) (cdr i)))

(define (upper-bound i) (max (car i) (cdr i)))

(provide print-center-percent
         make-center-percent
         percent
         center
         mul-interval
         div-interval
         add-interval
         make-interval 
         lower-bound
         upper-bound)