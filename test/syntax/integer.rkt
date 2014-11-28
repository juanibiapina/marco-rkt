#lang racket

(require
  rackunit
  (only-in "../../loader.rkt" eval-string)
  "../../language/main.rkt")

(check-equal? (eval-string "0") (integer 0))
(check-equal? (eval-string "5") (integer 5))
(check-equal? (eval-string "42") (integer 42))
(check-equal? (eval-string "19703461") (integer 19703461))

(check-equal? (eval-string "-1") (integer -1))
(check-equal? (eval-string "-1000") (integer -1000))
