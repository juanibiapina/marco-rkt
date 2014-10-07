#lang racket

(provide
  make-env
  extend-env
  lookup-env)

(define (make-env)
  null)

(define (extend-env env name value)
  (cons (cons name value) env))

(define (lookup-env env name)
  (cond
    [(null? env) (error (format "Unbound name: ~a" name))]
    [(equal? (caar env) name) (cdar env)]
    [#t (lookup-env (cdr env) name)]))
