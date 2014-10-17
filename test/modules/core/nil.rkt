#lang marco

(check-equal? nil nil)
(check-equal? (nil? nil) true)
(check-equal? (nil? 0) false)
(check-equal? (nil? []) true)
(check-equal? (nil? [1]) false)
