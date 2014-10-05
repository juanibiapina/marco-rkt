#lang racket

(require
  (prefix-in m: "language.rkt"))

(provide generate-code)

(define (generate-code ast)
  (list
    (match ast
      [(m:integer v) (datum->syntax #f v)])))
