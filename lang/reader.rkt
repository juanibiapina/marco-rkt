#lang s-exp syntax/module-reader
marco/lang/marco

#:read marco-read
#:read-syntax marco-read-syntax
#:whole-body-readers? #t

(require
  "lexer.rkt"
  "parser.rkt"
  "../interpreter.rkt"
  "../core-env.rkt"
  (prefix-in m: "../language/main.rkt"))

(define (marco-read in)
  (map syntax->datum (marco-read-syntax #f in)))

(define (marco-read-syntax src in)
  (let* ([token-gen (make-token-gen in src)]
         [ast (parse token-gen)]
         [env (make-core-env)]
         [env (m:extend
                env
                "module-path"
                (m:string
                          (path->string
                            (let-values ([(path name _) (split-path (collection-file-path "main.rkt" "marco"))])
                              (build-path path "modules")))))])
    (with-syntax ([ast ast] [env env])
      (list
        (syntax (eval ast env))))))
