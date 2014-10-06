#lang racket

(require
  parser-tools/lex)

(provide
  token-<string>
  token-<integer>
  token-<eof>
  marco-tokens)

(define-tokens marco-tokens (<eof> <integer> <string>))
