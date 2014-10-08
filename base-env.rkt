#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (prefix-in m:base: "base.rkt"))

(provide
  make-base-env)

(define (make-base-env)
  (let ([env (make-env)])
    (extend
      (extend
        env
        "nil"
        m:base:nil)
    "def"
    (m:closure env m:base:def))))
