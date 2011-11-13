#lang racket

(require "accumulate.rkt")

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

(provide flatmap)