#lang racket

(require
  "../interpreter.rkt"
  (prefix-in m: "../language.rkt"))

(provide
  module)

(define nil
  (m:nil))

(define nil?-fun
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (let ([value (m:lookup closure "value")])
          (m:boolean (m:nil? value)))))))

(define def
  (m:function
    (list "name" "value")
    (m:native-block
      (lambda (closure dynamic)
        (m:extend!
          dynamic
          (m:symbol-name (m:lookup closure "name"))
          (m:lookup closure "value"))
        nil))))

(define print
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (match (m:lookup closure "value")
          [(m:string v) (display v)])
        nil))))

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
                          (m:symbol-name name))
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
          "def"
          (m:closure env def))
        (cons
          "print"
          (m:closure env print))
        (cons
          "require"
          (m:closure env require))
        (cons
          "export"
          (m:closure env export-fun))))))
