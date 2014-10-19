#lang racket

(require
  (prefix-in m: "../language/main.rkt"))

(provide
  module)

(define read-line-fun
  (m:function
    (list "port")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([port (m:lookup closure "port")]
               [racket-port (m:port-value port)])
          (m:string (read-line racket-port)))))))

(define module
  (let ([env (m:make-env)])
    (m:module
      env
      (list
        (cons
          "read-line"
          (m:closure env read-line-fun))
        (cons
          "stdin"
          (m:port (current-input-port)))))))
