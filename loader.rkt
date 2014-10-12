#lang racket

(require
  "lexer.rkt"
  "parser.rkt"
  "interpreter.rkt"
  "environment.rkt"
  "core-env.rkt"
  (for-syntax (only-in racket/string string-join)))

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
               (extend
                 env
                 (car binding)
                 (cdr binding)))
             env
             bindings)])
    (eval ast env)))

(define (marco code)
  (eval-port (open-input-string code)))