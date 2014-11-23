#lang marco

(def :string-conv (require "string-conv"))

(def :one (string-conv.parse-int "1" 10))

(check-equal? one 1)
