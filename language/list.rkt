#lang racket/base

(require
  "nil.rkt")

(provide
  (struct-out list)
  racket-list->list
  list->racket-list)

(struct list (forms) #:transparent)

(define (list->racket-list l)
  (if (nil? l)
    null
    (list-forms l)))

(define (racket-list->list l)
  (if (null? l)
    (nil)
    (list l)))
