#lang racket

(provide
  make-env
  extend
  mutate
  lookup
  export
  get-exports)

(struct environment (bindings exports) #:mutable)

(define (make-env)
  (environment null null))

(define (extend env name value)
  (environment
    (cons (cons name value) (environment-bindings env))
    (environment-exports env)))

(define (mutate env name value)
  (set-environment-bindings! env (cons (cons name value) (environment-bindings env))))

(define (lookup env name)
  (let ([bindings (environment-bindings env)])
    (let loop ([bindings bindings])
      (cond
        [(null? bindings) (error (format "Unbound name: ~a" name))]
        [(equal? (caar bindings) name) (cdar bindings)]
        [#t (loop (cdr bindings))]))))

(define (export env name value)
  (set-environment-exports!
    env
    (cons
      (cons name value)
      (environment-exports env))))

(define (get-exports env)
  (environment-exports env))
