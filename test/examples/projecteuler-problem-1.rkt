#lang racket

(require
  rackunit
  "../helpers/example.rkt")

(check-equal? (run-example "projecteuler/problem-1" "1000") "233168")
