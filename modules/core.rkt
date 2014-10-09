#lang racket

(require
  "../environment.rkt"
  (prefix-in m: "../language.rkt"))

(provide
  core)

(define nil
  (m:nil))

(define def
  (m:function
    (list "name" "value")
    (m:native-block
      (lambda (closure dynamic)
        (mutate
          dynamic
          (m:symbol-name (lookup closure "name"))
          (lookup closure "value"))
        nil))))

(define print
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (match (lookup closure "value")
          [(m:string v) (display v)])
        nil))))

(define core
  (let ([env (make-env)])
    (m:module
      env
      (list
        (cons
          (m:symbol "nil")
          nil)
        (cons
          (m:symbol "def")
          (m:closure env def))
        (cons
          (m:symbol "print")
          (m:closure env print))))))
