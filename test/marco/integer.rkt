#lang racket

(require
  rackunit
  (only-in "../../interpreter.rkt" marco)
  "../../language.rkt")

(check-equal? (marco 0) (integer 0))
(check-equal? (marco 5) (integer 5))
(check-equal? (marco 42) (integer 42))
(check-equal? (marco 19703461) (integer 19703461))

(check-equal? (marco -1) (integer -1))
(check-equal? (marco -1000) (integer -1000))
