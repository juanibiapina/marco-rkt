#lang marco

(check-equal? true true)
(check-equal? false false)

(check-equal? (not true) false)
(check-equal? (not false) true)
