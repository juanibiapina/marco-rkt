#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (prefix-in m:core: "modules/core.rkt"))

(provide
  make-core-env)

(define (make-core-env)
  (let ([env (make-env)])
    (extend
      (extend
        env
        "nil"
        m:core:nil)
    "def"
    (m:closure env m:core:def))))
