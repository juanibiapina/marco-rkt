#lang racket

(require
  parser-tools/lex)

(provide
  token-<string>
  token-<integer>
  token-<eof>
  valued-tokens
  empty-tokens)

(define-empty-tokens empty-tokens (<eof>))

(define-tokens valued-tokens (<integer> <string>))
