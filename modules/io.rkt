#lang racket

(require
  "../environment.rkt"
  (prefix-in m: "../language.rkt"))

(provide
  module)

(define read-line-fun
  (m:function
    (list "port")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([port (lookup closure "port")]
               [racket-port (m:port-value port)])
          (m:string (read-line racket-port)))))))

(define module
  (let ([env (make-env)])
    (m:module
      env
      (list
        (cons
          "read-line"
          (m:closure env read-line-fun))
        (cons
          "stdin"
          (m:port (current-input-port)))))))
