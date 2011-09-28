#lang racket

; Напишите процедуру, вычисляющую элементы треугольника Паскаля с помощью
; рекурсивного процесса.

(define (pascal-triangle lines-number)
  (if (= lines-number 1)
    '((1))
    (let ((prev-triangle (pascal-triangle (- lines-number 1))))
      (append prev-triangle (list (build-next-line (last prev-triangle))))))) 

(define (build-next-line base-line)
  (append '(1) (line-iter base-line) '(1)))

(define (line-iter line-tail)
  (if (= (length line-tail) 1)
    '()
    (cons (+ (car line-tail) (cadr line-tail)) 
          (line-iter (cdr line-tail)))))

; Пример треугольника Паскаля 
(for-each (lambda (x) (display x) (newline) ) 
          (pascal-triangle 6))





