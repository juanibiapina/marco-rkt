#lang marco

(check-equal? (= 1 1) true)
(check-equal? (= 1 2) false)

(check-equal? (+ 1 1) 2)
(check-equal? (+ 2 1) 3)
(check-equal? (+ 4 2) 6)

(check-equal? (- 1 1) 0)
(check-equal? (- 4 2) 2)
(check-equal? (- 1 5) -4)

(check-equal? (% 1 1) 0)
(check-equal? (% 2 1) 0)
(check-equal? (% 4 2) 0)
(check-equal? (% 4 3) 1)
(check-equal? (% 8 3) 2)
