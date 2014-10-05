#lang racket/base

(require rackunit)


(require "../lexer.rkt")

(define (lex value)
  ((make-token-gen (open-input-string value) #f)))

(define suite
  (test-suite
    "lexer tests"

    (check-equal? (lex "    1  ") (token-<integer> 1) "ignores whitespace")

    (test-case
      "integers"

      (check-equal? (lex "0") (token-<integer> 0))
      (check-equal? (lex "5") (token-<integer> 5)))))


(require rackunit/text-ui)

(run-tests suite)
