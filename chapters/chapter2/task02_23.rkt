#lang racket

; Процедура for-each похожа на map. В качестве аргументов она принимает процедуру и список элементов. 
; Однако вместо того, чтобы формировать список результатов, for-each просто применяет процедуру
; по очереди ко всем элементам слева направо. Результаты применения процедуры к аргументам не
; используются вообще — for-each применяют к процедурам, которые осуществляют какое-либо действие вроде печати.
; Напишите реализацию for-each.


(define (for-each-v1 f lst)
  (cond ((null? lst) true)
        (else (f (car lst))
              (for-each f (cdr lst))
              true
         )))

(define (for-each-v2 f lst)
  (map f lst)
  true)



; тест

(display "Version 1")
(for-each-v1 (lambda (x) (newline) (display x))
             (list 57 321 88))

; Должен вывести
; => 57
; => 321
; => 88

(newline)
(newline)
(display "Version 2")
(for-each-v2 (lambda (x) (newline) (display x))
             (list 57 321 88))