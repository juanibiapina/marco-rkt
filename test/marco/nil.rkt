#lang racket

(require
  rackunit
  (only-in "../../interpreter.rkt" marco)
  "../../language.rkt")

(check-equal? (marco nil) (nil))
