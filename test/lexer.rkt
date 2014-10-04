#lang racket/base

(require rackunit)


(require "../lexer.rkt")

(define (lex value)
  (marco-lexer (open-input-string value)))

(define suite
  (test-suite
    "lexer tests"

    (test-case
      "integers"

      (check-equal? (lex "0") (token-<integer> 0))
      (check-equal? (lex "5") (token-<integer> 5)))))


(require rackunit/text-ui)

(run-tests suite)
