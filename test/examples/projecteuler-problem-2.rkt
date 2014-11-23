#lang racket

(require
  rackunit
  "../helpers/example.rkt")

(check-equal? (run-example "projecteuler/problem-2" "4000000") "4613732")
