#lang racket

(require
  parser-tools/lex)

(provide
  token
  valued-tokens
  empty-tokens)

(define-empty-tokens empty-tokens (<eof> <lparem> <rparem>))

(define-tokens valued-tokens (<integer> <string>))

(define-syntax (token stx)
  (syntax-case stx ()
    [(_ name)
     (let ([name (syntax name)])
       (with-syntax ([token-name (string->symbol (format "token-~a" (syntax-e name)))])
         (syntax (token-name))))]
    [(_ name value)
     (let ([name (syntax name)])
       (with-syntax ([token-name (string->symbol (format "token-~a" (syntax-e name)))])
         (syntax (token-name value))))]))
