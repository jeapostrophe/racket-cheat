#lang scribble/manual
@(require "racket-cheat.rkt"
          (for-label racket/base
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
   (CRow @exec{hello.rkt}
         @racket[#,(hash-lang) #,(racketmodname racket) "Hello, world!"])
   (CRow @seclink["running-sa" #:doc '(lib "scribblings/reference/reference.scrbl")]{Running}
         @exec{racket hello.rkt})))

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
         @racket[string? string=? string<=? string-ci<=?]))
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
         @racket[bytes->string/utf-8 string->bytes/utf-8])
   (CRow "Test"
         @racket[bytes? bytes=?]))
  (CGroup
   "Other"
   (CRow "Booleans"
         @racket[#t #f not equal? eq?])
   (CRow @seclink["parse-character" #:doc '(lib "scribblings/reference/reference.scrbl")]{Characters}
         @racket[#\a #\tab char? char->integer integer->char char<=? #,MORE char-alphabetic? #,MORE])
   (CRow @seclink["parse-symbol" #:doc '(lib "scribblings/reference/reference.scrbl")]{Symbols}
         @racket['Racket symbol? string->symbol gensym])))

@(CSection
  #:which 'right
  "Collections"
  (CGroup
   "Lists"
   (CRow "Create"
         @racket[cons list list*])
   (CRow "Use"
         @racket[map for-each first second]))
  (CGroup
   "Vector"
   (CRow "Create"
         @racket[build-vector vector make-vector])
   (CRow "Use"
         @racket[vector-ref vector-set!])))

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

@(render-cheat-sheet)
