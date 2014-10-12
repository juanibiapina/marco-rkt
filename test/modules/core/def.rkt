#lang marco

(def :x 1)
(check-equal? x 1)

(def :s "string")
(check-equal? s "string")

(def :define def)
(define :a 2)
(check-equal? a 2)

(def :y x)
(check-equal? y 1)

//(def :x 2)

(check-equal? (def :b 4) nil)

//(def 2 1)

//(def :x)

//(def :x 1 2)
