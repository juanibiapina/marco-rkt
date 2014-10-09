#lang racket

(require
  rackunit
  (only-in "../../../interpreter.rkt" marco))

(check-equal? (marco (def :x 1) x) (marco 1))
