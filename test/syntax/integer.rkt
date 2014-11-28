#lang racket

(require
  rackunit
  "../helpers/eval.rkt"
  "../../language/main.rkt")

(check-equal? (eval "0") (integer 0))
(check-equal? (eval "5") (integer 5))
(check-equal? (eval "42") (integer 42))
(check-equal? (eval "19703461") (integer 19703461))

(check-equal? (eval "-1") (integer -1))
(check-equal? (eval "-1000") (integer -1000))
