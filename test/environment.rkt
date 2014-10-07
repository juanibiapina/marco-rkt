#lang racket/base

(require
  rackunit
  "../environment.rkt")

(define env
  (extend-env (make-env) "a" 1))

(check-exn exn:fail? (lambda () (lookup-env env "notthere")))
(check-equal? (lookup-env env "a") 1)
(check-equal? (lookup-env (extend-env env "b" 42) "b") 42)
(check-equal? (lookup-env (extend-env env "b" 42) "a") 1)
