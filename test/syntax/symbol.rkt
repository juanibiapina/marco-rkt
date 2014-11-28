#lang racket

(require
  rackunit
  "../helpers/eval.rkt"
  "../../language/symbol.rkt")

(check-equal? (eval ":x") (symbol "x"))
(check-equal? (eval ":lol") (symbol "lol"))
(check-equal? (eval ":withnumber1") (symbol "withnumber1"))
