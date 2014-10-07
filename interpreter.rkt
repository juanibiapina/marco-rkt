#lang racket

(require
  "lexer.rkt"
  "parser.rkt"
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (for-syntax (only-in racket/string string-join)))

(provide
  marco)

(define (eval exp env)
  (match exp
    [(m:program #f)
     void]
    [(m:program (list exprs ...))
     (last (map (lambda (e) (eval e env)) exprs))]
    [(m:integer _) exp]
    [(m:string _) exp]
    [(m:name name) (lookup-env env name)]
    [(m:application (list forms ...))
     (let* ([eforms (map (lambda (e) (eval e env)) forms)]
            [pred (car eforms)]
            [args (cdr eforms)])
       (eval pred env))]))


(define (eval-string str)
  (define token-gen (make-token-gen (open-input-string str) #f))
  (define ast (parse token-gen))
  (eval ast (make-env)))

(define-syntax (marco stx)
  (with-syntax ([code (string-join (map (lambda (s) (format "~s" (syntax->datum s))) (cdr (syntax-e stx))) " ")])
    (syntax (eval-string code))))
