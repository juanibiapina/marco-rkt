#lang racket

(require
  "../../loader.rkt"
  (prefix-in m: "../../language.rkt"))

(provide
  run-example)

(define (example-filename name)
  (format "../../examples/~a.mrc" name))

(define (run-example name [input ""])
  (define result (open-output-string))
  (define input-port (open-input-string input))

  (call-with-input-file
    (example-filename name)
    (lambda (port)
      (parameterize ([current-output-port result]
                     [current-input-port input-port])
        (eval-with-bindings
          port
          (cons "module-path" (m:string "../../modules"))))
      (get-output-string result))))
