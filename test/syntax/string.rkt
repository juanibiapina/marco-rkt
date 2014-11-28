#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" eval-string)
  "../../language/main.rkt")

(check-equal? (eval-string "\"some string\"") (string "some string") "a string")
(check-equal? (eval-string "\"\"") (string "") "empty string")
