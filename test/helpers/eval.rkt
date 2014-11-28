#lang racket

(require
  "../../core-env.rkt"
  "../../loader.rkt")

(provide
  eval)

(define (eval code)
  (define env (make-core-env))

  (eval-string code env))
