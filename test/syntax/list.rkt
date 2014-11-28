#lang racket

(require
  rackunit
  "../helpers/eval.rkt"
  (prefix-in m: "../../language/main.rkt"))

(check-equal? (eval "[]") (m:nil))
(check-equal? (eval "[1]") (m:list (list (m:integer 1))))
