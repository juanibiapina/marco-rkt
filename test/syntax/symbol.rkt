#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" marco)
  "../../language/symbol.rkt")

(check-equal? (marco ":x") (symbol "x"))
(check-equal? (marco ":lol") (symbol "lol"))
