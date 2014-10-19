#lang racket/base

(require
  rackunit
  "../../language/environment.rkt")

(define env
  (extend (make-env) "a" 1))

(check-exn exn:fail? (lambda () (lookup env "notthere")))
(check-equal? (lookup env "a") 1)
(check-equal? (lookup (extend env "b" 42) "b") 42)
(check-equal? (lookup (extend env "b" 42) "a") 1)
