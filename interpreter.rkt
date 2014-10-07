#lang racket

(require
  "lexer.rkt"
  "parser.rkt"
  (prefix-in m: "language.rkt")
  (for-syntax (only-in racket/string string-join)))

(provide
  marco)

(define (lookup name)
  (m:integer 42))

(define (eval exp)
  (match exp
    [(m:program #f)
     void]
    [(m:program (list exprs ...))
     (last (map eval exprs))]
    [(m:integer _) exp]
    [(m:string _) exp]
    [(m:name name) (lookup name)]
    [(m:application (list forms ...))
     (let* ([eforms (map eval forms)]
            [pred (car eforms)]
            [args (cdr eforms)])
       (eval pred))]))


(define (eval-string str)
  (define token-gen (make-token-gen (open-input-string str) #f))
  (define ast (parse token-gen))
  (eval ast))

(define-syntax (marco stx)
  (with-syntax ([code (string-join (map (lambda (s) (format "~s" (syntax->datum s))) (cdr (syntax-e stx))) " ")])
    (syntax (eval-string code))))
