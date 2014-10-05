#lang racket

(provide
  integer
  string)

(struct integer (v) #:transparent)
(struct string (v) #:transparent)
