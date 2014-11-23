#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" marco)
  "../../language/symbol.rkt")

(check-equal? (marco ":x") (symbol "x"))
(check-equal? (marco ":lol") (symbol "lol"))
(check-equal? (marco ":withnumber1") (symbol "withnumber1"))
