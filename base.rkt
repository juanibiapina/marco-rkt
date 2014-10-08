#lang racket

(require
  "environment.rkt"
  (prefix-in m: "language.rkt"))

(provide
  (all-defined-out))

(define nil
  (m:nil))

(define def
  (m:function
    (list "name" "value")
    (m:native-body
      (lambda (closure dynamic)
        (extend-env
          dynamic
          (lookup-env closure "name")
          (lookup-env closure "value"))
        nil))))
