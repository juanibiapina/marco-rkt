#lang racket/base

(provide
  symbol
  symbol-e)

(struct symbol (name) #:transparent)

(define symbol-e symbol-name)
