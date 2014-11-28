#lang racket

(require
  rackunit
  "../helpers/eval.rkt"
  "../../language/main.rkt")

(check-equal? (eval "\"some string\"") (string "some string") "a string")
(check-equal? (eval "\"\"") (string "") "empty string")
