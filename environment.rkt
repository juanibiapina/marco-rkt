#lang racket

(provide
  make-env
  extend
  lookup)

(define (make-env)
  null)

(define (extend env name value)
  (cons (cons name value) env))

(define (lookup env name)
  (cond
    [(null? env) (error (format "Unbound name: ~a" name))]
    [(equal? (caar env) name) (cdar env)]
    [#t (lookup (cdr env) name)]))
