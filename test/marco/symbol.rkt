#lang racket

(require
  rackunit
  (only-in "../../interpreter.rkt" marco)
  "../../language.rkt")

(check-equal? (marco :x) (symbol "x"))
(check-equal? (marco :lol) (symbol "lol"))
