#lang racket

(require
  rackunit
  (only-in "../../../interpreter.rkt" marco)
  "../../../language.rkt")

(check-equal? (marco (def :x 1) x) (integer 1))
