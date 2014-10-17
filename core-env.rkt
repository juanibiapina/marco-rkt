#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (prefix-in module: "modules/core.rkt")
  (prefix-in module: "modules/unit.rkt"))

(provide
  make-core-env)

(define (make-core-env)
  (let ([env (make-env)])
    (include (include env module:core) module:unit)))

(define (include env module) ; probably in wrong place
  (let ([exports (m:module-exports module)])
    (foldl
      (lambda (export env)
        (extend
          env
          (car export)
          (cdr export)))
      env
      exports)))
