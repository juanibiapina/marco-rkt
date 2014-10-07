#lang racket/base

(require
  rackunit
  rackunit/text-ui
  "../lexer.rkt"
  "../tokens.rkt")

(define (lex value)
  ((make-token-gen (open-input-string value) #f)))

(define suite
  (test-suite
    "lexer tests"

    (check-equal? (lex "    1  ") (token <integer> 1) "ignores whitespace")

    (test-case
      "name"

      (check-equal? (lex "simplename") (token <name> "simplename") "simple name"))

    (test-case
      "parenthesis"

      (check-equal? (lex "(") (token <lparem>))
      (check-equal? (lex ")") (token <rparem>)))

    ))

(run-tests suite)
