#lang racket/base

(require
  "nil.rkt"
  "pair.rkt")

(provide
  head
  tail
  list->racket-list
  racket-list->list)

(define (head list)
  (pair-first list))

(define (tail list)
  (pair-second list))

(define (list->racket-list l)
  (if (nil? l)
    null
    (cons (head l) (list->racket-list (tail l)))))

(define (racket-list->list l)
  (if (null? l)
    (nil)
    (pair (car l) (racket-list->list (cdr l)))))

