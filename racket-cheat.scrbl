#lang scribble/manual
@(require "racket-cheat.rkt"
          (for-label racket/base
                     racket/list
                     racket/string
                     racket/format
                     racket/syntax
                     racket/port
                     racket/pretty
                     racket/sandbox
                     (only-in ffi/unsafe
                              ffi-lib _uint32 _fun malloc free)
                     slideshow
                     pict/code
                     syntax/parse
                     syntax/parse/define
                     json
                     (only-in xml read-xml write-xml write-xexpr)
                     (only-in parser-tools/lex lexer)
                     (only-in parser-tools/yacc parser)
                     parser-tools/cfg-parser
                     db
                     net/http-client
                     net/url
                     net/smtp
                     net/imap
                     racket/stxparam
                     racket/runtime-path
                     racket/undefined
                     racket/generator
                     racket/generic
                     racket/trait
                     racket/date
                     racket/async-channel
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
         @elem{@link["https://pkgs.racket-lang.org"]{packages}
               @link["http://groups.google.com/forum/#!forum/racket-users/"]{users@"@"}
               @link["http://groups.google.com/forum/#!forum/racket-dev/"]{dev@"@"}
               @link["http://racket-lang.org/irc-chat.html"]{irc}
               @link["http://racket-slack.herokuapp.com"]{slack}
               @link["https://twitter.com/racketlang"]{twitter}})
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
         @racket[random])
   (CRow "Match Pattern"
          @racket[(? number? n) 42]))
  @; XXX add cool stuff from math
  (CGroup
   "Strings"
   (CRow @seclink["parse-string" #:doc '(lib "scribblings/reference/reference.scrbl")]{Literals}
         @elem{@racket["Racket"] quoting @racket["a \" approaches!"] unicode @racket["λx:(μα.α→α).xx"]})
   (CRow "Create"
         @racket[make-string string string-append build-string string-join])
   (CRow "Observe"
         @racket[string-length string-ref substring string-split in-string])
   (CRow "Modify"
         @racket[string-downcase string-upcase string-trim])
   (CRow "Test"
         @racket[string? string=? string<=? string-ci<=?])
   (CRow @seclink["regexp-syntax" #:doc '(lib "scribblings/reference/reference.scrbl")]{Regexp}
         @racket[#rx"a|b" #rx"^c(a|d)+r$" regexp-quote regexp-match regexp-split regexp-replace regexp-replace*])
   (CRow "Match Pattern"
          @racket[(? string? s) "Banana?"]))
  (CGroup
   "Bytes"
   (CRow @seclink["parse-string" #:doc '(lib "scribblings/reference/reference.scrbl")]{Literals}
         @code{#"rawbytes\0"})
   (CRow "Create"
         @racket[make-bytes bytes])
   (CRow "Numbers"
         @racket[integer->integer-bytes real->floating-point-bytes])
   (CRow "Observe"
         @racket[bytes-length bytes-ref subbytes in-bytes])
   (CRow "Modify"
         @racket[bytes-set! bytes-copy! bytes-fill!])
   (CRow "Conversion"
         @racket[bytes->string/utf-8 #,LB string->bytes/utf-8])
   (CRow "Test"
         @racket[bytes? bytes=?])
   (CRow "Match Pattern"
          @racket[(? bytes? b) #"0xDEADBEEF"]))
  (CGroup
   "Other"
   (CRow "Booleans"
         @racket[#t #f not equal?])
   (CRow @seclink["parse-character" #:doc '(lib "scribblings/reference/reference.scrbl")]{Characters}
         @racket[#\a #\tab #\λ char? char->integer integer->char char<=? #,MORE char-alphabetic? #,MORE])
   (CRow @seclink["parse-symbol" #:doc '(lib "scribblings/reference/reference.scrbl")]{Symbols}
         @racket['Racket symbol? eq? string->symbol gensym])
   (CRow "Boxes"
         @racket[box? box unbox set-box! box-cas!])
   (CRow "Procedures"
         @racket[procedure? apply compose compose1 keyword-apply procedure-rename procedure-arity curry arity-includes?])
   (CRow "Void"
         @racket[void? void])
   (CRow "Undefined"
         @racket[undefined])))

@(CSection
  #:which 'right
  "Syntax (Beginner)"
  (CGroup
   "Basics"
   @; XXX move these things into a separate group related to "files" and "libraries"
   (CRow "Modules"
         @racket[(module+ main _body _...) #,LB
                 (module+ test _body _...) #,LB
                 (require _mod-path)
                 (provide _id)])
   (CRow "S-expressions"
         @racket[quote '(a b c) quasiquote unquote `(1 2 ,(+ 1 2))])
   (CRow "Procedure Applications"
         @elem{@racket[(_fn _arg1 _arg2)] @LB @seclink["parse-keyword" #:doc '(lib "scribblings/reference/reference.scrbl")]{keyword args} @racket[(_fn _arg1 #:key _arg2)] @LB @racket[(apply _fn _arg1 (list _arg2))]})
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
   (CRow "Blocks"
         @racket[begin when unless])
   (CRow "Require Sub-forms"
         @racket[prefix-in only-in except-in rename-in for-syntax for-label #,MORE])
   (CRow "Provide Sub-forms"
         @racket[all-defined-out all-from-out rename-out #,MORE contract-out]))

  (CGroup
    "Structures"
    (CRow "Definition"
          @racket[(struct dillo (weight color))])
    (CRow "Create"
          @racket[(define danny (_dillo 17.5 'purple))])
    (CRow "Observe"
          @racket[(_dillo? _danny)
                  (_dillo-weight _danny)
                  (_dillo-color _danny)])
    (CRow "Modify"
          @racket[(struct-copy _dillo _danny ([weight 18.0]))])
    (CRow "Match Pattern"
          @racket[(_dillo w c)]))

  (CGroup
   "Pattern Matching"
   (CRow "Basics"
         @racket[(match _value [_pat _body] _...)])
   (CRow "Definitions"
         @racket[(match-define _pat _value)])
   (CRow "Patterns"
         @racket[(_quote _datum) (list _lvp _...)
                 (_list-no-order _pat _...)
                 (_vector _lvp _...)
                 (_struct-id _pat _...)
                 (_regexp _rx-expr _pat)
                 (_or _pat _...)
                 (_and _pat _...)
                 (_? _expr _pat _...)])))

@(CSection
  #:which 'left
  "Data"
  (CGroup
   "Lists"
   (CRow "Create"
         @racket[empty list list* build-list for/list])
   (CRow "Observe"
         @racket[empty? list? pair? length list-ref member count argmin argmax])
   (CRow "Use"
         @racket[append reverse map andmap ormap foldr in-list])
   (CRow "Modify"
         @racket[filter remove #,MORE sort take drop split-at partition remove-duplicates shuffle])
   (CRow "Match Pattern"
          @racket[(list _a _b _c) (list* _a _b _more) (list _top _more _...)]))

  (CGroup
   "Immutable Hash"
   (CRow "Create"
         @racket[hash hasheq])
   (CRow "Observe"
         @racket[hash? hash-ref hash-has-key? hash-count in-hash in-hash-keys in-hash-values])
   (CRow "Modify"
         @racket[hash-set hash-update hash-remove]))

  (CGroup
   "Vector"
   (CRow "Create"
         @racket[build-vector vector make-vector list->vector])
   (CRow "Observe"
         @racket[vector? vector-length vector-ref in-vector])
   (CRow "Modify"
         @racket[vector-set! vector-fill! vector-copy! vector-map!])
   (CRow "Match Pattern"
          @racket[(vector _x _y _z) (vector _x _y _calabi–yau _...)]))

  (CGroup
   "Streams"
   (CRow "Create"
         @racket[stream stream* empty-stream])
   (CRow "Observe"
         @racket[stream-empty? stream-first stream-rest in-stream]))

  (CGroup
   "Mutable Hash"
   (CRow "Create"
         @racket[make-hash make-hasheq])
   (CRow "Observe"
         @racket[hash? hash-ref hash-has-key? hash-count in-hash in-hash-keys in-hash-values])
   (CRow "Modify"
         @racket[hash-set! hash-ref! hash-update! hash-remove!])))

@(CSection
  #:which 'right
  "Syntax (Intermediate)"
  (CGroup
   "Basics"
   (CRow "Mutation"
         @racket[set!])
   (CRow "Exceptions"
         @racket[error with-handlers raise exit])
   (CRow "Promises"
         @racket[promise? delay force])
   (CRow "Continuations"
         @racket[let/cc let/ec dynamic-wind
                        call-with-continuation-prompt
                        abort-current-continuation
                        call-with-composable-continuation])
   (CRow "Parameters"
         @racket[make-parameter parameterize])
   (CRow "External Files Needed at Runtime"
         @racket[define-runtime-path])
   (CRow "Continuation Marks"
         @racket[continuation-marks with-continuation-mark continuation-mark-set->list])
   (CRow "Multiple Values"
         @racket[values let-values define-values call-with-values]))
  
  (CGroup
   "Contracts"
   (CRow "Basics"
         @racket[any/c or/c and/c false/c integer-in vector/c listof list/c #,MORE])
   (CRow "Functions"
         @racket[-> ->* ->i])
   (CRow "Application"
         @racket[contract-out recontract-out with-contract define/contract]))

  (CGroup
   "Iteration"
   (CRow "Sequences"
         @racket[in-range in-naturals in-list in-vector in-port in-lines in-hash in-hash-keys in-hash-values in-directory in-cycle stop-before stop-after in-stream])
   (CRow "Generators"
         @racket[generator yield in-generator]))
  
  (CGroup
   "Structures"
   (CRow "Sub-structures"
         @racket[(struct 2d (x y)) (struct 3d _2d (z))
                 (_2d-x (_3d 1 2 3))])
   (CRow "Mutation"
         @racket[(struct monster (type [hp #:mutable]))
                 (define healie (_monster 'slime 10))
                 (_set-monster-hp! _healie 0)])
   (CRow "Serialization"
         @racket[(struct txn (who what where) #:prefab)
                 (write (txn "Mustard" "Spatula" "Observatory"))]))

  (CGroup
   "Generics"
   (CRow "Definition"
         @racket[define-generics])
   (CRow "Instantiation"
         @racket[(struct even-set ()
                   #:methods gen:set
                   [(define (set-member? st i)
                      (even? i))])]))

  (CGroup
   "Classes"
   (CRow "Definition"
         @racket[interface class*])
   (CRow "Instantiation"
         @racket[make-object new instantiate])
   (CRow "Methods"
         @racket[send send/apply send/keyword-apply send* send+])
   (CRow "Fields"
         @racket[get-field set-field!])
   (CRow "Mixins"
         @racket[mixin])
   (CRow "Traits"
         @racket[trait trait-sum trait-exclude trait-rename #,MORE])
   (CRow "Contracts"
         @racket[class/c instanceof/c is-a?/c implementation?/c subclass?/c])))

@(CSection
  #:which 'right
  "Syntactic Abstractions"
  (CGroup
   #f
   (CRow "Definition"
         @racket[define-syntax define-simple-macro begin-for-syntax for-syntax])
   (CRow "Templates"
         @racket[syntax syntax/loc with-syntax])
   (CRow "Parsing ()-Syntax"
         @racket[syntax-parse define-syntax-class pattern])
   (CRow "Syntax Objects"
         @racket[syntax-source syntax-line #,MORE syntax->datum datum->syntax generate-temporaries format-id])
   (CRow "Transformers"
         @racket[make-set!-transformer make-rename-transformer local-expand syntax-local-value syntax-local-name syntax-local-lift-expression #,MORE])
   (CRow "Syntax Parameters"
         @racket[define-syntax-parameter syntax-parameterize syntax-parameter-value])
   (CRow "Parsing Raw Syntax"
         @racket[lexer parser cfg-parser])
   ))

@(CSection
  #:which 'left
  "Systems"
  (CGroup
   "Input/Output"
   (CRow "Formatting"
         @racket[~a ~v ~s ~e ~r pretty-format])
   (CRow "Input"
         @racket[read read-bytes peek-byte])
   (CRow "Output"
         @racket[write write-bytes display displayln pretty-print])
   (CRow "Ports and Files"
         @racket[with-input-from-file with-output-to-file flush-output file-position make-pipe with-output-to-string with-input-from-string port->bytes port->lines #,MORE]))
  (CGroup
   "Files"
   (CRow "Paths"
         @racket[build-path bytes->path path->bytes path-replace-suffix #,MORE])
   (CRow "Files"
         @racket[file-exists? rename-file-or-directory copy-directory/files current-directory make-directory delete-directory/files directory-list filesystem-change-evt file->bytes file->lines make-temporary-file]))
  (CGroup
   "Miscellaneous"
   (CRow "Time"
         @; XXX link to gregor
         @racket[current-seconds current-inexact-milliseconds date->string date-display-format])
   (CRow "Command-Line Parsing"
         @racket[command-line])
   (CRow "FFI"
         @racket[ffi-lib _uint32 #,MORE _fun malloc free]))
  (CGroup
   "Networking"
   (CRow "TCP"
         @racket[tcp-listen tcp-connect tcp-accept tcp-close])
   (CRow "HTTP"
         @racket[http-conn http-conn-open! http-conn-send! http-conn-recv! http-conn-sendrecv! http-sendrecv])
   (CRow "URLs"
         @racket[string->url url->string url-query])
   (CRow "Email"
         @racket[smtp-send-message imap-connect #,MORE])
   (CRow "JSON"
         @racket[write-json read-json])
   (CRow "XML"
         @racket[read-xml write-xml write-xexpr])
   (CRow "Databases"
         @racket[postgresql-connect mysql-connect sqlite3-connect query-exec query-rows prepare start-transaction #,MORE]))
  (CGroup
   "Security"
   (CRow "Custodians"
         @racket[make-custodian custodian-shutdown-all current-custodian])
   (CRow "Sandboxes"
         @racket[make-evaluator make-module-evaluator]))
  (CGroup
   "Concurrency"
   (CRow "Threads"
         @racket[thread kill-thread thread-wait make-thread-group])
   (CRow "Events"
         @racket[sync choice-evt wrap-evt handle-evt alarm-evt #,MORE])
   (CRow "Channels"
         @racket[make-channel channel-get channel-put])
   (CRow "Semaphores"
         @racket[make-semaphore semaphore-post semaphore-wait])
   (CRow "Async Channels"
         @racket[make-async-channel async-channel-get async-channel-put]))
  (CGroup
   "Parallelism"
   (CRow "Futures"
         @racket[future touch processor-count make-fsemaphore #,MORE])
   (CRow "Places"
         @racket[dynamic-place place place-wait place-wait place-channel #,MORE])
   (CRow "Processes"
         @racket[subprocess system*])))

@(CSection
  #:which 'right
  "Tools"
  (CGroup
   @seclink["top" #:doc '(lib "pkg/scribblings/pkg.scrbl")]{Packages}
   (CRow "Inspection" @exec{raco pkg show})
   (CRow "Finding" @link["https://pkgs.racket-lang.org"]{pkgs.racket-lang.org})
   (CRow "Installing" @exec{raco pkg install})
   (CRow "Updating" @exec{raco pkg update})
   (CRow "Removing" @exec{raco pkg remove}))
  (CGroup
   "Miscellaneous"
   (CRow @seclink["make" #:doc '(lib "scribblings/raco/raco.scrbl")]{Compiling}
         @exec{raco make program.rkt})
   (CRow @seclink["test" #:doc '(lib "scribblings/raco/raco.scrbl")]{Testing}
         @exec{raco test program.rkt a-directory})
   (CRow @seclink["exe" #:doc '(lib "scribblings/raco/raco.scrbl")]{Building Executables}
         @exec{raco exe program.rkt})
   (CRow "Extending DrRacket"
         @racket[drracket:language:simple-module-based-language->module-based-language-mixin])
   (CRow "Slides"
         @racket[slide standard-fish code])))

@; XXX How to make a language, info files

@; DS cheat sheet: http://stackoverflow.com/questions/27584416/in-racket-what-is-the-advantage-of-lists-over-vectors/27589146#27589146

@(render-cheat-sheet)
