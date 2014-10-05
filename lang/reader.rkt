#lang s-exp syntax/module-reader
marco/lang/marco

#:read marco-read
#:read-syntax marco-read-syntax
#:whole-body-readers? #t

(require "../compiler.rkt")

(define (marco-read in)
  (map syntax->datum (marco-read-syntax #f in)))

(define (marco-read-syntax src in)
  (compile in src))
