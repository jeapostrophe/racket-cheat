#lang racket/base
(require racket/list
         racket/match
         racket/runtime-path
         scribble/core
         scribble/base
         scribble/html-properties)

(struct *section (label groups))
(struct *group (label rows))
(struct *row (label content))

(define how-many-sections (box 0))
(define rsections (box empty))

(define (CSection label . groups)
  (set-box! rsections
            (cons (*section label groups)
                  (unbox rsections)))
  (set-box! how-many-sections
            (add1 (unbox how-many-sections))))
(define (CGroup label . rows)
  (*group label rows))
(define (CRow label content)
  (*row label content))

(define-runtime-path racket-cheat.css-path "racket-cheat.css")

(define (render-cheat-sheet)
  (define left-col '())
  (define right-col '())
  ;; Ensure that the first thing is in the left column
  ;;     l
  ;;   r l
  ;; l r l
  (for ([s (in-list (unbox rsections))]
        [i (in-naturals
            (if (even? (unbox how-many-sections))
                1
                0))])
    (if (even? i)
        (set! left-col (cons s left-col))
        (set! right-col (cons s right-col))))

  (element
   (style #f (list (alt-tag "div")
                   (attributes '([class . "Csheet"]))
                   (css-addition racket-cheat.css-path)))
   (list
    (render-column left-col)
    (render-column right-col))))

(define (render-column secs)
  (element (style #f (list (alt-tag "div")
                           (attributes '([class . "Ccolumn"]))))
           (list (map render-section secs))))

(define (render-section s)
  (match-define (*section label gs) s)
  (element (style #f (list (alt-tag "div")
                           (attributes '([class . "Csection"]))))
           (cons
            (element (style #f (list (alt-tag "h1"))) label)
            (map render-group gs))))

(define (render-group g)
  (match-define (*group label rs) g)
  (element (style #f (list (alt-tag "div")
                           (attributes '([class . "Cgroup"]))))
           (list
            (element (style #f (list (alt-tag "h2"))) label)
            (element (style #f (list (alt-tag "table")))
                     (map render-row rs)))))

(define (render-row r)
  (match-define (*row label content) r)
  (element (style #f (list (alt-tag "tr")))
           (list (element (style #f (list (alt-tag "td")))
                          (list label))
                 (element (style #f (list (alt-tag "td")))
                          content))))

(provide CSection CGroup CRow render-cheat-sheet)
