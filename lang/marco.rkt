#lang racket

(require
  "../interpreter.rkt"
  "../core-env.rkt")

(provide
  #%datum
  make-core-env
  eval
  (rename-out [module-begin #%module-begin]))

(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ stx)
     (syntax (#%module-begin stx))]))
