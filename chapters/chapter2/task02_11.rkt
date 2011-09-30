#lang racket

(require rackunit
         "../../utils/test_helper.rkt"
         "lib/interval.rkt")

; Проходя мимо, Бен делает туманное замечание: «Если проверять знаки концов интервалов, 
; можно разбить mul-interval на девять случаев, из которых только в одном требуется более двух умножений». 
; Перепишите эту процедуру в соответствии с предложением Бена.


(define (new-mul-interval x y)
  (define (neg a) (<= a 0))
  (define (pos a) (>  a 0))
  (let ((x1 (lower-bound x))
        (x2 (upper-bound x))
        (y1 (lower-bound y))
        (y2 (upper-bound y)))
    (cond
      ((and (neg x1) (neg x2) (neg y1) (neg y2)) (make-interval (* x2 y2) (* x1 y1)))
      ((and (neg x1) (neg x2) (neg y1) (pos y2)) (make-interval (* x1 y2) (* x1 y1)))
      ((and (neg x1) (neg x2) (pos y1) (pos y2)) (make-interval (* x1 y2) (* x2 y1)))
      ((and (neg x1) (pos x2) (neg y1) (neg y2)) (make-interval (* x2 y1) (* x1 y1)))
      ((and (neg x1) (pos x2) (pos y1) (pos y2)) (make-interval (* x1 y2) (* x2 y2)))
      ((and (pos x1) (pos x2) (neg y1) (neg y2)) (make-interval (* x2 y1) (* x1 y2)))
      ((and (pos x1) (pos x2) (pos y1) (pos y2)) (make-interval (* x1 y1) (* x2 y2)))
      ((and (pos x1) (pos x2) (neg y1) (pos y2)) (make-interval (* x2 y1) (* x2 y2)))
      ((and (neg x1) (pos x2) (neg y1) (pos y2)) (make-interval (min (* x1 y2) (* x2 y1)) (* x2 y2)))
      )))


; тесты

(check-equal? (new-mul-interval (make-interval 1 4) (make-interval 3 5))
              (mul-interval     (make-interval 1 4) (make-interval 3 5)))

(check-equal? (new-mul-interval (make-interval -1 4) (make-interval -3 5))
              (mul-interval     (make-interval -1 4) (make-interval -3 5)))

(check-equal? (new-mul-interval (make-interval -4 -1) (make-interval -5 -3))
              (mul-interval     (make-interval -4 -1) (make-interval -5 -3)))