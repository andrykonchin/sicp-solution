#lang racket

; Что напечатает интерпретатор в ответ на каждое из следующих выражений?

(list 'a 'b 'c)                          ; => '(a b c)
(list (list 'george))                    ; => '((georg))
(cdr '((x1 x2) (y1 y2)))                 ; => '((y1 y2)) 
(cadr '((x1 x2) (y1 y2)))                ; => '(y1 y2)
(pair? (car '(a short list)))            ; => false
(memq 'red '((red shoes) (blue socks)))  ; => false
(memq 'red '(red shoes blue socks))      ; => '(red shoes blue socks)