#lang racket

(require
  "../../interpreter.rkt")

(provide
  run-example)

(define (example-filename name)
  (format "../../examples/~a.mrc" name))

(define (run-example name)
  (define result (open-output-string))

  (call-with-input-file
    (example-filename name)
    (lambda (port)
      (parameterize ([current-output-port result])
        (eval-port port))
      (get-output-string result))))
