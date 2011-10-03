#lang racket

(require rackunit
         "lib/accumulate.rkt"
         "lib/enumerate-tree.rkt")


; Переопределите count-leaves из раздела 2.2.2 в виде накопления:
; (define (count-leaves t)
;   (accumulate <??> <??> (map <??> <??>)))

(define (count-leaves t)
  (accumulate + 
              0 
              (map (lambda (x) 1) 
                   (enumerate-tree t))))

; тест

(check-eq? (count-leaves (list 1 (list 2 (list 3 4))))
           4)
