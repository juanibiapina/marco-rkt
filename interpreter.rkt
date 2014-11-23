#lang racket

(require
  "lang/lexer.rkt"
  "lang/parser.rkt"
  (prefix-in m: "language/main.rkt")
  (for-syntax (only-in racket/string string-join)))

(provide
  eval
  eval-into-module)

(define (eval-into-module port env)
  (let* ([token-gen (make-token-gen port #f)]
         [ast (parse token-gen)]
         [result (eval ast env)])
    (m:make-module env)))

(define (eval exp env)
  (match exp
    [(m:program #f)
     (void)]
    [(m:program (list exprs ...))
     (let loop ([exprs exprs] [result #f])
       (if (null? exprs)
         result
         (loop (cdr exprs) (eval (car exprs) env))))]
    [(m:nil) exp]
    [(m:integer _) exp]
    [(m:string _) exp]
    [(m:symbol _) exp]
    [(m:block _) exp]
    [(m:native-block _) exp]
    [(m:name name) (m:lookup env name)]
    [(m:nested-name names)
     (let* ([module (m:lookup env (car names))]
            [exports (m:module-exports module)])
       (if (null? exports)
         (error (format "Module doesn't export binding ~a" (cadr names)))
         (foldl
           (lambda (name result)
             (let ([exports (m:module-exports result)])
               (let loop ([exports exports])
                 (cond
                   [(null? exports)
                    (error (format "Module doesn't export binding '~a'" name))]
                   [(equal? (caar exports) name) (cdar exports)]
                   [#t (loop (cdr exports))]))))
           module
           (cdr names))))]
    [(m:closure _ _) exp]
    [(m:list forms)
     (m:list (map (lambda (e) (eval e env)) forms))]
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
               (m:extend
                 result-env
                 (if (m:symbol? formal)
                   (m:symbol-e formal)
                   formal)
                 arg))
             (m:closure-env closure) formal args)])
    (invoke (m:function-body f) extended-env env)))

(define (invoke block closure dynamic)
  (match block
    [(m:native-block l)
     (l closure dynamic)]
    [(m:block forms)
     (foldl
       (lambda (form result)
         (eval form closure))
       m:nil
       forms)]))
