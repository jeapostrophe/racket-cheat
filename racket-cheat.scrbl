#lang scribble/manual
@(require "racket-cheat.rkt"
          (for-label racket/base
                     racket/list
                     racket/string
                     racket/format
                     drracket/tool-lib))

@; XXX maybe tag things with a level and produce multiple versions of
@; the cheat for different levels? or at least use it to color things.

@title[#:style cheat-style]{Racket Cheat Sheet}
@author{Jay McCarthy}

@(CSection
  #:which 'left
  "Essentials"
  (CGroup
   #f
   (CRow "Sites"
         @elem{@link["http://racket-lang.org"]{main}
               @link["http://download.racket-lang.org"]{download}
               @link["http://docs.racket-lang.org"]{docs}
               @link["https://github.com/racket"]{git}})
   (CRow "Community"
         @elem{@link["http://pkgs.racket-lang.org"]{packages}
               @link["http://groups.google.com/forum/#!forum/racket-users/"]{users@"@"}
               @link["http://groups.google.com/forum/#!forum/racket-dev/"]{dev@"@"}
               @link["http://pkg-build.racket-lang.org/doc/index.html"]{package docs}})
   (CRow @seclink["running-sa" #:doc '(lib "scribblings/reference/reference.scrbl")]{Running}
         @elem{Put @racket[#,(hash-lang) #,(racketmodname racket) "Hello, world!"] in @exec{hello.rkt} and run @exec{racket hello.rkt}})))

@(CSection
  #:which 'left
  "Primitives"
  (CGroup
   "Numbers"
   (CRow @seclink["parse-number" #:doc '(lib "scribblings/reference/reference.scrbl")]{Literals}
         @elem{integer @code{1} rational @code{ 1/2 } complex @code{1+2i} floating @code{3.14} double @code{6.02e+23} hex @code{#x29} octal @code{#o32} binary @code{#b010101}})
   (CRow "Arithmetic"
         @racket[+ - * / quotient remainder modulo add1 sub1 max min round floor ceiling sqrt expt exp log sin #,MORE atan])
   (CRow "Compare"
         @racket[= < <= > >=])
   (CRow "Bitwise"
         @racket[bitwise-ior bitwise-and bitwise-xor bitwise-not arithmetic-shift integer-length])
   (CRow "Format"
         @racket[number->string string->number real->decimal-string])
   (CRow "Test"
         @racket[number? complex? #,MORE exact-nonnegative-integer? #,MORE zero? positive? negative? even? odd? exact? inexact?])
   (CRow "Misc"
         @racket[random]))
  @; XXX add cool stuff from math
  (CGroup
   "Strings"
   (CRow @seclink["parse-string" #:doc '(lib "scribblings/reference/reference.scrbl")]{Literals}
         @elem{@racket["Racket"] quoting @racket["a \" approaches!"] unicode @racket["λx:(μα.α→α).xx"]})
   (CRow "Create"
         @racket[make-string string string-append build-string string-join])
   (CRow "Observe"
         @racket[string-length string-ref substring string-split])
   (CRow "Modify"
         @racket[string-downcase string-upcase string-trim])
   (CRow "Test"
         @racket[string? string=? string<=? string-ci<=?])
   (CRow @seclink["regexp-syntax" #:doc '(lib "scribblings/reference/reference.scrbl")]{Regexp}
         @racket[#rx"a|b" #rx"^c(a|d)+r$" regexp-quote regexp-match regexp-split regexp-replace regexp-replace*]))
  (CGroup
   "Bytes"
   (CRow @seclink["parse-string" #:doc '(lib "scribblings/reference/reference.scrbl")]{Literals}
         @code{#"rawbytes\0"})
   (CRow "Create"
         @racket[make-bytes bytes])
   (CRow "Numbers"
         @racket[integer->integer-bytes real->floating-point-bytes])
   (CRow "Observe"
         @racket[bytes-length bytes-ref subbytes])
   (CRow "Modify"
         @racket[bytes-set! bytes-copy! bytes-fill!])
   (CRow "Conversion"
         @racket[bytes->string/utf-8 #,LB string->bytes/utf-8])
   (CRow "Test"
         @racket[bytes? bytes=?]))
  (CGroup
   "Other"
   (CRow "Booleans"
         @racket[#t #f not equal?])
   (CRow @seclink["parse-character" #:doc '(lib "scribblings/reference/reference.scrbl")]{Characters}
         @racket[#\a #\tab #\λ char? char->integer integer->char char<=? #,MORE char-alphabetic? #,MORE])
   (CRow @seclink["parse-symbol" #:doc '(lib "scribblings/reference/reference.scrbl")]{Symbols}
         @racket['Racket symbol? eq? string->symbol gensym])
   ))

@(CSection
  #:which 'right
  "Syntax"
  (CGroup
   "Basics"
   @; XXX move these things into a separate group related to "files" and "libraries"
   (CRow "Modules"
         @racket[(module+ _mod-name _body _...) #,LB
                 (require _mod-path)
                 (provide _id)])
   (CRow "S-expressions"
         @racket[quote '(a b c) quasiquote unquote `(1 2 ,(+ 1 2))])
   (CRow "Procedure Applications"
         @elem{@racket[(_fun _arg1 _arg2)] @LB @seclink["parse-keyword" #:doc '(lib "scribblings/reference/reference.scrbl")]{keyword args} @racket[(_fun _arg1 #:key _arg2)] @LB @racket[(apply _fun _arg1 (list _arg2))]})
   (CRow "Procedures"
         @racket[(lambda (x) x) (λ (x) x) #,LB
                 (λ (x [opt 1]) (+ x opt)) #,LB
                 (λ (x #:req key) (+ x key)) #,LB
                 (λ (x #:opt [key 1]) (+ x key))])
   @; XXX robby says don't show let or if
   (CRow "Binding"
         @racket[(let ([x 1] [y 2]) (+ x y)) #,LB
                 (let* ([x 1] [x (+ x 1)]) x)])
   (CRow "Conditionals"
         @racket[(if (zero? x) 0 (/ 1 x)) #,LB
                 (cond [(even? _x) 0] [(odd? _x) 1] #,LB
                 #,(code "     ") [else "impossible!"]) #,LB
                 and or])
   (CRow "Definitions"
         @racket[(define x 1) #,LB
                 (define (f y) (+ x y))])
   (CRow "Iteration"
         @racket[for for/list for*])
   (CRow "Multiple Values"
         @racket[values let-values define-values call-with-values])
   (CRow "Miscellaneous"
         @racket[begin when unless set!])
   (CRow "Require Sub-forms"
         @racket[prefix-in only-in except-in rename-in for-syntax for-label #,MORE])
   (CRow "Provide Sub-forms"
         @racket[all-defined-out all-from-out rename-out #,MORE])))

@(CSection
  #:which 'right
  "Data"
  (CGroup
   "Lists"
   (CRow "Create"
         @racket[empty list list* build-list for/list])
   (CRow "Observe"
         @racket[empty? length list-ref member count argmin argmax])
   (CRow "Use"
         @racket[append reverse map andmap ormap foldr in-list])
   (CRow "Modify"
         @racket[filter remove #,MORE sort take drop split-at partition remove-duplicates shuffle]))
@; XXX
  (CGroup
   "Vector"
   (CRow "Create"
         @racket[build-vector vector make-vector])
   (CRow "Use"
         @racket[vector-ref vector-set!])))

@; XXX
@(CSection
  #:which 'right
  "Syntactic Abstractions"
  (CGroup
   "Basics"
   (CRow "Definition"
         @racket[define-syntax define-syntax-rule begin-for-syntax for-syntax])))

@; XXX
@(CSection
  #:which 'right
  "Input/Output"
  (CGroup
   #f
   (CRow "Formatting"
         @racket[~a ~v ~s ~e ~r])))

@(CSection
  #:which 'right
  "Tools"
  (CGroup
   @; XXX
   "Packages")
  (CGroup
   "Miscellaneous"
   (CRow @seclink["make" #:doc '(lib "scribblings/raco/raco.scrbl")]{Compiling}
         @exec{raco make program.rkt})
   (CRow @seclink["exe" #:doc '(lib "scribblings/raco/raco.scrbl")]{Building Executables}
         @exec{raco exe program.rkt})
   (CRow "Extending DrRacket"
         @racket[drracket:language:simple-module-based-language->module-based-language-mixin])))

@; XXX How to make a language, info files

@(render-cheat-sheet)
