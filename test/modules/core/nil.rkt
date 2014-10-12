#lang racket

(require
  rackunit
  (only-in "../../../loader.rkt" marco)
  "../../../language.rkt")

(check-equal? (marco "nil") (nil))
