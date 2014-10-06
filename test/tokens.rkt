#lang racket/base

(require
  rackunit
  rackunit/text-ui
  parser-tools/lex
  "../tokens.rkt")

(define suite
  (test-suite
    "token tests"

    (test-case
      "empty token"

      (define t (token <eof>))

      (check-equal? (token-name t) '<eof>)
      (check-equal? (token-value t) #f))

    (test-case
      "valued token"

      (define t (token <integer> 4))

      (check-equal? (token-name t) '<integer>)
      (check-equal? (token-value t) 4))))

(run-tests suite)
