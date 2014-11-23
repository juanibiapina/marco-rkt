#lang marco

(check-equal?
  (if true
    { 1 }
    { 2 })
  1)

(check-equal?
  (if false
    { 1 }
    { 2 })
  2)
