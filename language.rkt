#lang racket/base

(require
  "environment.rkt")

(provide
  (all-defined-out)
  (all-from-out "environment.rkt"))

(struct program (exprs) #:transparent)
(struct integer (v) #:transparent)
(struct string (v) #:transparent)
(struct application (forms) #:transparent)
(struct name (v) #:transparent)
(struct nested-name (names) #:transparent)
(struct function (formal body) #:transparent)
(struct native-block (l) #:transparent)
(struct closure (env function) #:transparent)
(struct nil () #:transparent)
(struct symbol (name) #:transparent)
(struct module (env exports))
(struct list (forms) #:transparent)

(define (make-module env)
  (module env (get-exports env)))
