#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (prefix-in module: "modules/core.rkt"))

(provide
  make-core-env)

(define (make-core-env)
  (let ([env (make-env)])
    (include env module:core)))

(define (include env module)
  (let ([exports (m:module-exports module)])
    (foldl
      (lambda (export env)
        (extend
          env
          (m:symbol-name (car export))
          (cdr export)))
      env
      exports)))
