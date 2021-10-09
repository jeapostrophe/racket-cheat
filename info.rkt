#lang info
(define collection "racket-cheat")
(define deps '("base"
               "scribble-lib"
               ))
(define build-deps '("db-doc"
                     "db-lib"
                     "drracket"
                     "net-doc"
                     "net-lib"
                     "parser-tools-doc"
                     "parser-tools-lib"
                     "pict-doc"
                     "pict-lib"
                     "racket-doc"
                     "sandbox-lib"
                     "slideshow-doc"
                     "slideshow-lib"
                     ))
(define scribblings '(("racket-cheat.scrbl" () (getting-started))))
(define pkg-desc "a cheat sheet for Racket")
(define pkg-authors '(jay))

(define license
  '(Apache-2.0 OR MIT))
