#lang racket/base

(provide
  (all-defined-out))

(struct program (exprs) #:transparent)
(struct integer (v) #:transparent)
(struct string (v) #:transparent)
(struct application (forms) #:transparent)
(struct name (v) #:transparent)
(struct function (formal body) #:transparent)
(struct native-block (l) #:transparent)
(struct closure (env function) #:transparent)
(struct nil () #:transparent)
(struct symbol (name) #:transparent)
(struct module (env exports))
