#lang racket

(require
  "lexer.rkt"
  "parser.rkt"
  "core-env.rkt"
  "environment.rkt"
  (prefix-in m: "language.rkt")
  (for-syntax (only-in racket/string string-join)))

(provide
  eval
  eval-port
  marco)

(define (eval exp env)
  (match exp
    [(m:program #f)
     void]
    [(m:program (list exprs ...))
     (let loop ([exprs exprs] [result #f])
       (if (null? exprs)
         result
         (loop (cdr exprs) (eval (car exprs) env))))]
    [(m:integer _) exp]
    [(m:string _) exp]
    [(m:symbol _) exp]
    [(m:native-block _) exp]
    [(m:name name) (lookup env name)]
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
               (extend
                 result-env
                 formal
                 arg))
             (m:closure-env closure) formal args)])
    (invoke (m:function-body f) extended-env env)))

(define (invoke block closure dynamic)
  (match block
    [(m:native-block l)
     (l closure dynamic)]))

(define (eval-string str)
  (define token-gen (make-token-gen (open-input-string str) #f))
  (define ast (parse token-gen))
  (eval ast (make-core-env)))

(define (eval-port port)
  (define token-gen (make-token-gen port #f))
  (define ast (parse token-gen))
  (eval ast (make-core-env)))

(define-syntax (marco stx)
  (with-syntax ([code (string-join (map (lambda (s) (format "~s" (syntax->datum s))) (cdr (syntax-e stx))) " ")])
    (syntax (eval-string code))))
