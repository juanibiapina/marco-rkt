#lang racket

(require
  (prefix-in m: "../language/main.rkt")
  "../loader.rkt"
  "../core-env.rkt")

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

(define env
  (let* ([env (make-core-env)]
         [env
           (m:extend
             env
             "module-path"
             (m:string module-path))])
    env))

(eval-file filename env)
