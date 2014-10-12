#lang s-exp syntax/module-reader
marco/lang/marco

#:read marco-read
#:read-syntax marco-read-syntax
#:whole-body-readers? #t

(require
  "lexer.rkt"
  "parser.rkt"
  "../interpreter.rkt"
  "../core-env.rkt")

(define (marco-read in)
  (map syntax->datum (marco-read-syntax #f in)))

(define (marco-read-syntax src in)
  (let* ([token-gen (make-token-gen in src)]
         [ast (parse token-gen)])
    (with-syntax ([ast ast])
      (list
        (syntax (eval ast (make-core-env)))))))
