#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" marco)
  (prefix-in m: "../../language/main.rkt"))

(check-equal? (marco "[]") (m:nil))
(check-equal? (marco "[1]") (m:list (list (m:integer 1))))
