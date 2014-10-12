#lang racket/base

(require
  parser-tools/yacc
  syntax/readerr
  "tokens.rkt"
  (prefix-in m: "../language.rkt"))

(provide parse)

(define (on-error tok-ok? name stx)
  (if (not tok-ok?)
    (raise-read-error (format "parse error near ~a" name)
                      (syntax-source stx)
                      (syntax-line stx)
                      (syntax-column stx)
                      (syntax-position stx)
                      (syntax-span stx))
    (raise-read-error (format "unexpected token ~a" name)
                      #f #f #f #f #f)))

(define parse
  (parser
    (tokens valued-tokens empty-tokens)
    (error on-error)
    (start <program>)
    (end <eof>)
    (grammar
      (<program>
        [() (m:program #f)]
        [(<form> <form-tail>) (m:program (cons $1 $2))]
        [(<form>) (m:program (list $1))])
      (<form>
        [(<integer>) (m:integer $1)]
        [(<string>) (m:string $1)]
        [(<symbol>) (m:symbol $1)]
        [(<nested-name>) (m:nested-name $1)]
        [(<name>) (m:name $1)]
        [(<list>) (m:list $1)]
        [(<application>) $1])
      (<list>
        [(<lbracket> <form-tail> <rbracket>) $2])
      (<application>
        [(<lparem> <form-tail> <rparem>) (m:application $2)])
      (<form-tail>
        [(<form> <form-tail>) (cons $1 $2)]
        [(<form>) (list $1)]))))
