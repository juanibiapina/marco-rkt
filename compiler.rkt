#lang racket

(require
  "lexer.rkt"
  "parser.rkt"
  "code-generator.rkt")

(provide compile)

(define (compile port src)
  (define token-gen (make-token-gen port src))
  (define ast (parse token-gen))
  (define code (generate-code ast))
  code)
