#lang racket

(require
  rackunit
  (prefix-in m: "../language/main.rkt"))

(provide
  module)

(define check-equal?-fun
  (m:function
    (list "actual" "expected")
    (m:native-block
      (lambda (closure dynamic)
        (let ([actual (m:lookup closure "actual")]
              [expected (m:lookup closure "expected")])
          (check-equal? actual expected))))))

(define module
  (let ([env (m:make-env)])
    (m:module
      env
      (list
        (cons
          "check-equal?"
          (m:closure env check-equal?-fun))))))
