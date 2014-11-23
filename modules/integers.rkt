#lang racket

(require
  (prefix-in m: "../language/main.rkt"))

(provide
  module)

(define range-fun
  (m:function
    (list "start" "end")
    (m:native-block
      (lambda (closure dynamic)
        (let* ([start (m:integer-v (m:lookup closure "start"))]
               [end (m:integer-v (m:lookup closure "end"))])
          (m:list (map
                    (lambda (e)
                      (m:integer e))
                    (stream->list (in-range start end)))))))))

(define module
  (let ([env (m:make-env)])
    (m:module
      env
      (list
        (cons
          "range"
          (m:closure env range-fun))))))
