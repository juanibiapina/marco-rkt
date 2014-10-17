#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (prefix-in core: "modules/core.rkt")
  (prefix-in unit: "modules/unit.rkt"))

(provide
  make-core-env)

(define (make-core-env)
  (let ([env (make-env)])
    (include (include env core:module) unit:module)))

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
