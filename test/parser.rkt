#lang racket/base

(require
  rackunit
  rackunit/text-ui
  "../lexer.rkt"
  (prefix-in parser: "../parser.rkt")
  (prefix-in m: "../language.rkt"))

(define (parse str)
  (define token-gen (make-token-gen (open-input-string str) #f))
  (parser:parse token-gen))

(define suite
  (test-suite
    "parser tests"

    (test-case
      "integers"

      (check-equal? (parse "0") (list (m:integer 0))))

    (test-case
      "string"

      (check-equal? (parse "\"some string\"") (list (m:string "some string"))))))

(run-tests suite)
