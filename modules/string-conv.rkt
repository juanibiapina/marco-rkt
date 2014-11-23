#lang racket

(require
  (prefix-in m: "../language/main.rkt"))

(provide
  module)

(define parse-int-fun
  (m:function
    (list "value" "radix")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([value (m:lookup closure "value")]
               [radix (m:lookup closure "radix")])
          (m:integer (string->number (m:string-v value) (m:integer-v radix))))))))

(define module
  (let ([env (m:make-env)])
    (m:module
      env
      (list
        (cons
          "parse-int"
          (m:closure env parse-int-fun))))))
