#lang marco

(def :f (function [] { 4 }))

(check-equal? (f) 4)

(def :f2 (function [:x] { x }))

(check-equal? (f2 2) 2)

(def :fr (function [:i] {
  (if (= i 0)
    { true }
    { (recurse (- i 1)) })
}))

(check-equal? (fr 3) true)
