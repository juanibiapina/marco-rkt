#lang racket

(require parser-tools/lex)
(require (prefix-in : parser-tools/lex-sre))

(provide
  make-token-gen
  token-<integer>
  token-<eof>
  marco-tokens)

(define-lex-abbrevs
  [lex:whitespace (:or #\newline #\return #\tab #\space #\vtab)])

(define-tokens marco-tokens (<eof> <integer>))

(define lex
  (lexer
    [(:+ lex:whitespace) (void)]
    [(eof) (token-<eof> eof)]
    [(:+ numeric) (token-<integer> (string->number lexeme))]))

(define (make-token-gen port src)
  (port-count-lines! port)
  (lambda ()
    (let loop ()
      (let ([v (lex port)])
        (if (void? v)
          (loop)
          v)))))
