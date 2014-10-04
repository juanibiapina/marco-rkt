#lang racket

(require parser-tools/lex)
(require (prefix-in : parser-tools/lex-sre))

(provide
  marco-lexer
  token-<integer>
  token-<eof>
  marco-tokens)

(define-tokens marco-tokens (<eof> <integer>))

(define marco-lexer
  (lexer
    [(eof) (token-<eof> eof)]
    [numeric (token-<integer> (string->number lexeme))]))
