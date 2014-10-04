#lang racket/base

(require rackunit)

(require "../lexer.rkt")
(require "../parser.rkt")
(require (prefix-in marco: "../language.rkt"))

(define parse
  (lambda args
    (define current 0)

    (define gen
      (lambda ()
        (begin0
          (list-ref args current)
          (set! current (add1 current)))))

    (marco-parser gen)))


(define suite
  (test-suite
    "parser tests"

    (test-case
      "integers"

      (check-equal? (parse (token-<integer> 0) (token-<eof> eof)) (marco:integer 0)))))


(require rackunit/text-ui)

(run-tests suite)
