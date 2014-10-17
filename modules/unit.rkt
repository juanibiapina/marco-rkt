#lang racket

(require
  rackunit
  "../environment.rkt"
  (prefix-in m: "../language.rkt"))

(provide
  unit)

(define check-equal?-fun
  (m:function
    (list "actual" "expected")
    (m:native-block
      (lambda (closure dynamic)
        (let ([actual (lookup closure "actual")]
              [expected (lookup closure "expected")])
          (check-equal? actual expected))))))

(define unit
  (let ([env (make-env)])
    (m:module
      env
      (list
        (cons
          (m:symbol "check-equal?")
          (m:closure env check-equal?-fun))))))
