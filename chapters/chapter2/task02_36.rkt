#lang racket

(require rackunit
         "lib/accumulate.rkt"
         "lib/enumerate-tree.rkt")

; Процедура accumulate-n подобна accumulate, только свой третий аргумент она воспринимает 
; как последовательность последовательностей, причем предполагается, что все они содержат
; одинаковое количество элементов. Она применяет указанную процедуру накопления ко всем первым 
; элементам последовательностей, вторым элементам последовательностей и так далее, 
; и возвращает последовательность результатов. 
;
; Заполните пробелы в следующем определении accumulate-n:
;
; (define (accumulate-n op init seqs)
;   (if (null? (car seqs))
;       nil
;       (cons (accumulate op init <??>)
;             (accumulate-n op init <??>))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

; тест

(check-equal? (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
              '(22 26 30))
