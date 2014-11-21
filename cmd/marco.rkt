#lang racket

(require
  (prefix-in m: "../language/main.rkt")
  "../loader.rkt")

(define filename
  (command-line
    #:args (filename)
    filename))

(call-with-input-file
  filename
  (lambda (port)
    (eval-with-bindings
      port
      (cons
        "module-path"
        (m:string
          (path->string
            (let-values ([(path name _) (split-path (collection-file-path "main.rkt" "marco"))])
              (build-path path "modules"))))))
    (void)))
