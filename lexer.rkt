#lang racket/base

(require
  parser-tools/lex
  (prefix-in : parser-tools/lex-sre))

(provide
  make-token-gen
  token-<integer>
  token-<string>
  token-<eof>
  marco-tokens)

(define-lex-abbrevs
  [lex:whitespace (:or #\newline #\return #\tab #\space #\vtab)]
  [lex:integer (:: (:? #\-) (:+ numeric))])

(define-tokens marco-tokens (<eof> <integer> <string>))

(define lex
  (lexer
    [(:+ lex:whitespace) (void)]
    [(eof) (token-<eof> eof)]
    [(:: #\" (:* (:~ #\")) #\") (token-<string> (substring lexeme 1 (- (string-length lexeme) 1)))]
    [lex:integer (token-<integer> (string->number lexeme))]))

(define (make-token-gen port src)
  (port-count-lines! port)
  (lambda ()
    (let loop ()
      (let ([v (lex port)])
        (if (void? v)
          (loop)
          v)))))
