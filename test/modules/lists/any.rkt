#lang marco

(def :lists (require "lists"))

(def :even? (function [:n] {
  (if (= (% n 2) 0)
    { true }
    { false })
}))

(check-equal? (lists.any nil even?) false)
(check-equal? (lists.any [1 3 5 7 9] even?) false)
(check-equal? (lists.any [2 1 3 5 7 9] even?) true)
(check-equal? (lists.any [1 3 5 7 9 2] even?) true)
