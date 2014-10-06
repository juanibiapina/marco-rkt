#lang racket

(require
  (prefix-in m: "language.rkt"))

(provide generate-code)

(define (generate-code form)
  (match form
    [(list forms ...) (map generate-code forms)]
    [(m:application forms) (map generate-code forms)]
    [(m:integer v) (datum->syntax #f v)]
    [(m:string v) (datum->syntax #f v)]))
