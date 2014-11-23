#lang racket/base

(provide
  boolean
  boolean-e)

(struct boolean (value) #:transparent)

(define boolean-e boolean-value)
