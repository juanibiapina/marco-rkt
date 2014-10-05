#lang racket/base

(require
  parser-tools/yacc
  syntax/readerr)

(require "lexer.rkt")
(require (prefix-in m: "language.rkt"))

(provide parse)

(define (on-error ok? name stx)
  (raise-read-error (format "parse error near ~a" name)
    (syntax-source stx)
    (syntax-line stx)
    (syntax-column stx)
    (syntax-position stx)
    (syntax-span stx)))

(define parse
  (parser
    (tokens marco-tokens)
    (error on-error)
    (start <program>)
    (end <eof>)
    (grammar
      (<program> [(<integer>) (m:integer $1)]
                 [(<string>) (m:string $1)]))))
