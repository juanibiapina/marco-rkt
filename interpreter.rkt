#lang racket

(require
  "lexer.rkt"
  "parser.rkt"
  "base-env.rkt"
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
    [(m:symbol _) exp]
    [(m:name name) (lookup-env env name)]
    [(m:native-body l)
     (l env env)]
    [(m:closure _ _) exp]
    [(m:application (list forms ...))
     (let* ([eforms (map (lambda (e) (eval e env)) forms)]
            [closure (car eforms)]
            [args (cdr eforms)])
       (apply closure args env))]))

(define (apply closure args env)
  (let* ([f (m:closure-function closure)]
         [formal (m:function-formal f)]
         [extended-env
           (foldl
             (lambda (formal arg result-env)
               (extend-env
                 result-env
                 formal
                 arg))
             (m:closure-env closure) formal args)])
    (eval (m:function-body f) extended-env)))

(define (eval-string str)
  (define token-gen (make-token-gen (open-input-string str) #f))
  (define ast (parse token-gen))
  (eval ast (make-base-env)))

(define-syntax (marco stx)
  (with-syntax ([code (string-join (map (lambda (s) (format "~s" (syntax->datum s))) (cdr (syntax-e stx))) " ")])
    (syntax (eval-string code))))
