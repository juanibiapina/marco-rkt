#lang racket

(require
  "lang/lexer.rkt"
  "lang/parser.rkt"
  (prefix-in m: "language/main.rkt") ; should it need this?
  "interpreter.rkt"
  "core-env.rkt")

(provide
  marco
  eval-port
  eval-with-bindings)

(define (eval-port port [src #f])
  (let* ([token-gen (make-token-gen port src)]
         [ast (parse token-gen)]
         [env (make-core-env)])
    (eval ast env)))

(define (eval-with-bindings port . bindings)
  (let* ([token-gen (make-token-gen port #f)]
         [ast (parse token-gen)]
         [env (make-core-env)]
         [env
           (foldl
             (lambda (binding env)
               (m:extend
                 env
                 (car binding)
                 (cdr binding)))
             env
             bindings)])
    (eval ast env)))

(define (marco code)
  (eval-port (open-input-string code)))
