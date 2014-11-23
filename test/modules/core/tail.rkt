#lang marco

(check-equal? (tail [1 2 3]) [2 3])
(check-equal? (tail [0]) nil)
