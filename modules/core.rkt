#lang racket

(require
  "../environment.rkt"
  "../interpreter.rkt"
  (prefix-in m: "../language.rkt"))

(provide
  core)

(define nil
  (m:nil))

(define nil?-fun
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (let ([value (lookup closure "value")])
          (m:boolean (m:nil? value)))))))

(define def
  (m:function
    (list "name" "value")
    (m:native-block
      (lambda (closure dynamic)
        (mutate
          dynamic
          (m:symbol-name (lookup closure "name"))
          (lookup closure "value"))
        nil))))

(define print
  (m:function
    (list "value")
    (m:native-block
      (lambda (closure dynamic)
        (match (lookup closure "value")
          [(m:string v) (display v)])
        nil))))

(define require
  (m:function
    (list "name")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([name (lookup closure "name")]
               [module-path (m:string-v (lookup dynamic "module-path"))]
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
                        (m:list-forms (lookup closure "names")))]
               [values (map
                         (lambda (e)
                           (lookup dynamic e))
                         names)])
          (map
            (lambda (name value)
              (export
                dynamic
                name
                value))
            names
            values)
          nil)))))

(define core
  (let ([env (make-env)])
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
