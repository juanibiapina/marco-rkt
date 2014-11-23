#lang marco

(def :p (pair 1 "string"))

(check-equal? (first p) 1)
(check-equal? (second p) "string")
