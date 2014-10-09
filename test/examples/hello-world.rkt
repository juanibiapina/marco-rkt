#lang racket

(require
  rackunit
  "../helpers/example.rkt")

(check-equal? (run-example "hello-world") "Hello World")
