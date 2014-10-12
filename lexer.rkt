#lang racket/base

(require
  parser-tools/lex
  (prefix-in : parser-tools/lex-sre)
  racket/string
  "tokens.rkt")

(provide
  make-token-gen)

(define-lex-abbrevs
  [lex:whitespace (:or #\newline #\return #\tab #\space #\vtab)]
  [lex:integer (:: (:? #\-) (:+ numeric))]
  [lex:identifier (:+ (:or alphabetic #\-))])

(define (make-nested-name str)
  (token <nested-name> (string-split str ".")))

(define lex
  (lexer
    [(:+ lex:whitespace) (void)]
    [(eof) (token <eof>)]
    [(:: #\" (:* (:~ #\")) #\") (token <string> (substring lexeme 1 (- (string-length lexeme) 1)))]
    [#\( (token <lparem>)]
    [#\) (token <rparem>)]
    [#\[ (token <lbracket>)]
    [#\] (token <rbracket>)]
    [(:: lex:identifier (:+ (:: #\. lex:identifier)))
     (make-nested-name lexeme)]
    [lex:identifier (token <name> lexeme)]
    [(:: #\: lex:identifier) (token <symbol> (substring lexeme 1))]
    [lex:integer (token <integer> (string->number lexeme))]))

(define (make-token-gen port src)
  (port-count-lines! port)
  (lambda ()
    (let loop ()
      (let ([v (lex port)])
        (if (void? v)
          (loop)
          v)))))
