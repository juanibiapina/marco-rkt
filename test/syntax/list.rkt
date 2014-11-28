#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" eval-string)
  (prefix-in m: "../../language/main.rkt"))

(check-equal? (eval-string "[]") (m:nil))
(check-equal? (eval-string "[1]") (m:list (list (m:integer 1))))
