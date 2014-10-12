#lang racket

(require
  rackunit
  "../helpers/example.rkt")

(check-equal? (run-example "echo" "line") "line")
