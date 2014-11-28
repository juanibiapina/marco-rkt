#lang racket

(require
  "lang/lexer.rkt"
  "lang/parser.rkt"
  "interpreter.rkt")

(provide
  eval-file
  eval-string
  eval-port)

(define (eval-port port src env)
  (let* ([token-gen (make-token-gen port src)]
         [ast (parse token-gen)])
    (eval ast env)))

(define (eval-file filename env)
  (call-with-input-file
    filename
    (lambda (port)
      (eval-port
        port
        filename
        env))))

(define (eval-string code env)
  (eval-port (open-input-string code) #f env))
