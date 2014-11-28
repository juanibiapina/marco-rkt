#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" eval-string)
  "../../language/symbol.rkt")

(check-equal? (eval-string ":x") (symbol "x"))
(check-equal? (eval-string ":lol") (symbol "lol"))
(check-equal? (eval-string ":withnumber1") (symbol "withnumber1"))
