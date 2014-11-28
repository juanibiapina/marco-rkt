#lang racket

(require
  "../../core-env.rkt"
  "../../loader.rkt"
  (prefix-in m: "../../language/main.rkt"))

(provide
  run-example)

(define (example-filename name)
  (format "../../examples/~a.mrc" name))

(define (run-example name [input ""])
  (define result (open-output-string))
  (define input-port (open-input-string input))
  (define env
    (let* ([env (make-core-env)]
           [env
             (m:extend
               env
               "module-path"
               (m:string "../../modules"))])
      env))

  (parameterize ([current-output-port result]
                 [current-input-port input-port])
    (eval-file
      (example-filename name)
      env)
    (get-output-string result)))
