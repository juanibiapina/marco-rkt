#lang racket

(require
  "../interpreter.rkt"
  (prefix-in m: "../language/main.rkt"))

(provide
  module)

(define not-fun
  (m:function
    (list "v")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v (m:boolean-e (m:lookup closure "v"))])
          (m:boolean (not v)))))))

(define =-fun
  (m:function
    (list "v1" "v2")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v1 (m:integer-v (m:lookup closure "v1"))]
              [v2 (m:integer-v (m:lookup closure "v2"))])
          (m:boolean (= v1 v2)))))))

(define +-fun
  (m:function
    (list "v1" "v2")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v1 (m:integer-v (m:lookup closure "v1"))]
              [v2 (m:integer-v (m:lookup closure "v2"))])
          (m:integer (+ v1 v2)))))))

(define --fun
  (m:function
    (list "v1" "v2")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v1 (m:integer-v (m:lookup closure "v1"))]
              [v2 (m:integer-v (m:lookup closure "v2"))])
          (m:integer (- v1 v2)))))))

(define /-fun
  (m:function
    (list "v1" "v2")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v1 (m:integer-v (m:lookup closure "v1"))]
              [v2 (m:integer-v (m:lookup closure "v2"))])
          (m:integer (quotient v1 v2)))))))

(define %-fun
  (m:function
    (list "v1" "v2")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v1 (m:integer-v (m:lookup closure "v1"))]
              [v2 (m:integer-v (m:lookup closure "v2"))])
          (m:integer (modulo v1 v2)))))))

(define <-fun
  (m:function
    (list "v1" "v2")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v1 (m:integer-v (m:lookup closure "v1"))]
              [v2 (m:integer-v (m:lookup closure "v2"))])
          (m:boolean (< v1 v2)))))))

(define nil
  (m:nil))

(define nil?-fun
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (let ([value (m:lookup closure "value")])
          (m:boolean (m:nil? value)))))))

(define cons-fun
  (m:function
    (list "h" "t")
    (m:native-block
      (lambda (closure dynamic)
        (let ([h (m:lookup closure "h")]
              [t (m:lookup closure "t")])
          (m:racket-list->list (cons h (m:list->racket-list t))))))))

(define head-fun
  (m:function
    (list "list")
    (m:native-block
      (lambda (closure dynamic)
        (let ([l (m:lookup closure "list")])
          (car (m:list->racket-list l)))))))

(define tail-fun
  (m:function
    (list "list")
    (m:native-block
      (lambda (closure dynamic)
        (let ([l (m:lookup closure "list")])
          (m:racket-list->list (cdr (m:list->racket-list l))))))))

(define def
  (m:function
    (list "name" "value")
    (m:native-block
      (lambda (closure dynamic)
        (m:extend!
          dynamic
          (m:symbol-e (m:lookup closure "name"))
          (m:lookup closure "value"))
        nil))))

(define if-fun
  (m:function
    (list "value" "then-clause" "else-clause")
    (m:native-block
      (lambda (closure dynamic)
        (let ([v (m:boolean-e (m:lookup closure "value"))]
              [then-clause (m:lookup closure "then-clause")]
              [else-clause (m:lookup closure "else-clause")])
          (if v (invoke then-clause dynamic null) (invoke else-clause dynamic null)))))))


(define function-fun
  (m:function
    (list "args" "body")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([args (m:lookup closure "args")]
               [body (m:lookup closure "body")])
          (m:closure
            dynamic
            (m:function
              (m:list->racket-list args)
              body)))))))

(define print
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (match (m:lookup closure "value")
          [(m:string v) (display v)]
          [(m:integer v) (display v)])
        nil))))

(define pair-fun
  (m:function
    (list "first" "second")
    (m:native-block
      (lambda (closure dynamic)
        (let ([first (m:lookup closure "first")]
              [second (m:lookup closure "second")])
          (m:pair first second))))))

(define first-fun
  (m:function
    (list "pair")
    (m:native-block
      (lambda (closure dynamic)
        (let ([pair (m:lookup closure "pair")])
          (m:pair-first pair))))))

(define second-fun
  (m:function
    (list "pair")
    (m:native-block
      (lambda (closure dynamic)
        (let ([pair (m:lookup closure "pair")])
          (m:pair-second pair))))))

(define require
  (m:function
    (list "name")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([name (m:lookup closure "name")]
               [module-path (m:string-v (m:lookup dynamic "module-path"))]
               [path (string-append module-path "/" (m:string-v name) ".rkt")])
          (dynamic-require
            (string->path path)
            'module))))))

(define export-fun
  (m:function
    (list "names")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([names (map
                        (lambda (name)
                          (m:symbol-e name))
                        (m:list-forms (m:lookup closure "names")))]
               [values (map
                         (lambda (e)
                           (m:lookup dynamic e))
                         names)])
          (map
            (lambda (name value)
              (m:export
                dynamic
                name
                value))
            names
            values)
          nil)))))

(define module
  (let ([env (m:make-env)])
    (m:module
      env
      (list
        (cons
          "nil"
          nil)
        (cons
          "nil?"
          (m:closure env nil?-fun))
        (cons
          "true"
          (m:boolean #t))
        (cons
          "false"
          (m:boolean #f))
        (cons
          "not"
          (m:closure env not-fun))
        (cons
          "cons"
          (m:closure env cons-fun))
        (cons
          "head"
          (m:closure env head-fun))
        (cons
          "tail"
          (m:closure env tail-fun))
        (cons
          "def"
          (m:closure env def))
        (cons
          "if"
          (m:closure env if-fun))
        (cons
          "function"
          (m:closure env function-fun))
        (cons
          "print"
          (m:closure env print))
        (cons
          "="
          (m:closure env =-fun))
        (cons
          "+"
          (m:closure env +-fun))
        (cons
          "-"
          (m:closure env --fun))
        (cons
          "/"
          (m:closure env /-fun))
        (cons
          "%"
          (m:closure env %-fun))
        (cons
          "<"
          (m:closure env <-fun))
        (cons
          "pair"
          (m:closure env pair-fun))
        (cons
          "first"
          (m:closure env first-fun))
        (cons
          "second"
          (m:closure env second-fun))
        (cons
          "require"
          (m:closure env require))
        (cons
          "export"
          (m:closure env export-fun))))))
