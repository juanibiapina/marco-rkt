#lang marco

(def :lists (require "lists"))

(def :f (function [:e] { e }))

(check-equal? (lists.filter [] f) [])
