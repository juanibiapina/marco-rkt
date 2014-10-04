#lang racket

(require parser-tools/yacc)
(require "lexer.rkt")
(require (prefix-in marco: "language.rkt"))

(provide marco-parser)

(define (on-error ok? name value)
  (raise (format "parse error near ~a" name)))

(define marco-parser
  (parser
    (tokens marco-tokens)
    (error on-error)
    (start <program>)
    (end <eof>)
    (grammar
      (<program> [(<integer>) (marco:integer $1)]))))
