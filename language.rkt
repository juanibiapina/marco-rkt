#lang racket/base

(provide
  (all-defined-out))

(struct program (exprs) #:transparent)
(struct integer (v) #:transparent)
(struct string (v) #:transparent)
(struct application (forms) #:transparent)
(struct name (v) #:transparent)
