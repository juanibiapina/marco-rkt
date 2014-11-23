#lang racket/base

(require
  "nil.rkt"
  "boolean.rkt"
  "symbol.rkt"
  "list.rkt"
  "environment.rkt")

(provide
  (all-defined-out)
  (all-from-out "nil.rkt")
  (all-from-out "list.rkt")
  (all-from-out "boolean.rkt")
  (all-from-out "symbol.rkt")
  (all-from-out "environment.rkt"))

(struct program (exprs) #:transparent)
(struct integer (v) #:transparent)
(struct string (v) #:transparent)
(struct application (forms) #:transparent)
(struct name (v) #:transparent)
(struct nested-name (names) #:transparent)
(struct function (formal body) #:transparent)
(struct block (forms) #:transparent)
(struct native-block (l) #:transparent)
(struct closure (env function) #:transparent)
(struct module (env exports))
(struct port (value) #:transparent)

(define (make-module env)
  (module env (get-exports env)))
