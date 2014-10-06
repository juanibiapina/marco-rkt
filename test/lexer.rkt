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
      "integers"

      (check-equal? (lex "0") (token <integer> 0))
      (check-equal? (lex "5") (token <integer> 5))
      (check-equal? (lex "42") (token <integer> 42))
      (check-equal? (lex "19703461") (token <integer> 19703461))
      (check-equal? (lex "-1") (token <integer> -1)))

    (test-case
     "strings"

     (check-equal? (lex "\"some string\"") (token <string> "some string") "a string")
     (check-equal? (lex "\"\"") (token <string> "") "empty string"))

    (test-case
      "parenthesis"

      (check-equal? (lex "(") (token <lparem>))
      (check-equal? (lex ")") (token <rparem>)))

    ))

(run-tests suite)
