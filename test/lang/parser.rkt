#lang racket/base

(require
  rackunit
  rackunit/text-ui
  "../../lexer.rkt"
  (prefix-in parser: "../../parser.rkt")
  (prefix-in m: "../../language.rkt"))

(define (parse str)
  (define token-gen (make-token-gen (open-input-string str) #f))
  (parser:parse token-gen))

(check-equal? (parse "") (m:program #f))

(check-equal? (parse "name") (m:program (list (m:name "name"))))

(check-equal? (parse "(5 6)") (m:program (list (m:application (list (m:integer 5) (m:integer 6))))))
(check-equal? (parse "(add 6)") (m:program (list (m:application (list (m:name "add") (m:integer 6))))))
