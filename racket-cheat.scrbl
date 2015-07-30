#lang scribble/manual
@(require "racket-cheat.rkt")

@title{Racket Cheat Sheet}
@author{Jay McCarthy}

@(CSection
  "Primitives"
  (CGroup
   "Numbers"
   (CRow "Literals"
         @racket[7 #x29 #o32 #b010101])
   (CRow "Arithmetic"
         @racket[+ - * / modulo]))
  (CGroup
   "Strings"
   (CRow "Create"
         @elem{Put things between @litchar{""}})
   (CRow "Trim"
         @racket[string-trim])))

@(CSection
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

@(render-cheat-sheet)
