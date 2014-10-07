#lang racket

(require
  rackunit
  (only-in "../../interpreter.rkt" marco)
  "../../language.rkt")

(check-equal? (marco "some string") (string "some string") "a string")
(check-equal? (marco "") (string "") "empty string")
