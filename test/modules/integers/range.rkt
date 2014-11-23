#lang marco

(def :integers (require "integers"))

(check-equal? (integers.range 0 1) [0])
(check-equal? (integers.range 1 10) [1 2 3 4 5 6 7 8 9])

