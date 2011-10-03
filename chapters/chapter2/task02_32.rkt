#lang racket

(require rackunit)

; Множество можно представить как список его различных элементов, 
; а множество его подмножеств как список списков. 
; Например, если множество равно (1 2 3), то множество его подмножеств равно 
; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)). 
; Закончите следующее определение процедуры, которая порождает множество подмножеств 
; и дайте ясное объяснение, почему она работает:
;
; (define (subsets s) 
;   (if (null? s)
;       (list nil) 
;       (let ((rest (subsets (cdr s))))
;         (append rest (map ⟨??⟩ rest)))))


(define (subsets s) 
  (if (null? s)
      (list null) 
      (let ((rest (subsets (cdr s))))
        (append rest 
                (map (lambda (lst) (cons (car s) lst))
                     rest)))))

; тест

(check-equal? (subsets '(1 2 3))
              '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))
