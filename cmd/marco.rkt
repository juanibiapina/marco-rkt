#lang racket

(require
  (prefix-in m: "../language/main.rkt")
  "../loader.rkt")

(define marco-root
  (let ([value (getenv "MARCOROOT")])
    (if value
      value
      (error "MARCOROOT not set"))))

(define module-path
  (path->string
    (build-path marco-root "modules")))

(define filename
  (command-line
    #:args (filename)
    filename))

(call-with-input-file
  filename
  (lambda (port)
    (eval-with-bindings
      port
      (cons "module-path" (m:string module-path)))
    (void)))
