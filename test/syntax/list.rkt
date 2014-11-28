#lang racket

(require
  rackunit
  "../helpers/eval.rkt"
  (prefix-in m: "../../language/main.rkt"))

(check-equal? (eval "[]") (m:nil))
(check-equal? (eval "[1]") (m:pair (m:integer 1) (m:nil)))
