#lang racket

(require rackunit
         "test_helper.rkt")

; а. Покажите, что sum и product (упражнение 1.31) являются частными случаями еще более
; общего понятия, называемого накопление (accumulation), которое комбинирует множество термов
; с помощью некоторой общей функции накопления
;
; (accumulate combiner null-value term a next b)


(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (term a)))))
  (iter a null-value))

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

; тест

(define (inc x) (+ x 1))

(define (cube x) (* x x x))

(check-eq? (sum cube 1 inc 10)
           (apply + (map cube '(1 2 3 4 5 6 7 8 9 10))))


; б. Если Ваша процедура accumulate порождает рекурсивный процесс, перепишите ее так,
; чтобы она порождала итеративный. Если она порождает итеративный процесс, перепишите ее так,
; чтобы она порождала рекурсивный

(define (accumulate-rec combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-rec combiner null-value term (next a) next b))))