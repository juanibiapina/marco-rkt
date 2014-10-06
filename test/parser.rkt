#lang racket/base

(require
  rackunit
  rackunit/text-ui
  "../lexer.rkt"
  (prefix-in parser: "../parser.rkt")
  (prefix-in m: "../language.rkt"))

(define parse
  (lambda args
    (define current args)

    (define gen
      (lambda ()
        (if (null? current)
          (token-<eof> eof)
          (begin0
            (car args)
            (set! current (cdr args))))))

    (parser:parse gen)))


(define suite
  (test-suite
    "parser tests"

    (test-case
      "integers"

      (check-equal? (parse (token-<integer> 0)) (list (m:integer 0))))

    (test-case
      "string"

      (check-equal? (parse (token-<string> "some string")) (list (m:string "some string"))))))

(run-tests suite)
