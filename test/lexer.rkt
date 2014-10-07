#lang racket/base

(require
  rackunit
  "../lexer.rkt"
  "../tokens.rkt")

(define (lex value)
  ((make-token-gen (open-input-string value) #f)))

(check-equal? (lex "    1  ") (token <integer> 1) "ignores whitespace")

(check-equal? (lex "simplename") (token <name> "simplename") "simple name")

(check-equal? (lex "(") (token <lparem>))
(check-equal? (lex ")") (token <rparem>))

