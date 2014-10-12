#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (prefix-in module: "modules/core.rkt")
  (prefix-in module: "modules/marcounit.rkt"))

(provide
  make-core-env)

(define (make-core-env)
  (let ([env (make-env)])
    (include (include env module:core) module:marcounit)))

(define (include env module) ; probably in wrong place
  (let ([exports (m:module-exports module)])
    (foldl
      (lambda (export env)
        (extend
          env
          (m:symbol-name (car export))
          (cdr export)))
      env
      exports)))
