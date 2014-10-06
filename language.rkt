#lang racket/base

(provide
  integer
  string
  application)

(struct integer (v) #:transparent)
(struct string (v) #:transparent)
(struct application (forms) #:transparent)
