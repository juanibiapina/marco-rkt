#lang racket/base

(require
  rackunit
  parser-tools/lex
  "../../tokens.rkt")

(define teof (token <eof>))

(check-equal? (token-name teof) '<eof>)
(check-equal? (token-value teof) #f)

(define t4 (token <integer> 4))

(check-equal? (token-name t4) '<integer>)
(check-equal? (token-value t4) 4)
