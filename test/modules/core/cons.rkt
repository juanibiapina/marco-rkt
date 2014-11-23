#lang marco

(check-equal? (cons 1 nil) [1])
(check-equal? (cons 1 [1 2]) [1 1 2])
