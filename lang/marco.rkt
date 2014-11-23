#lang racket

(require
  "../loader.rkt"
  "../core-env.rkt")

(provide
  #%datum
  eval
  (rename-out [module-begin #%module-begin]))

(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ stx)
     (syntax (#%module-begin stx))]))
