(load "scheme/j-bob-lang.scm")

;; Reference
;;
;; Charlotte's Web" tells the story of a young pig named Wilbur
;; who is saved from slaughter by a wise spider named Charlotte, who helps him
;; become famous and beloved by the humans on the farm where he lives. The book
;; is notable for its vivid descriptions of farm life, its charming
;; illustrations by Garth Williams, and its timeless messages of love and
;; sacrifice.

;; `dethm` defines a theorem, an expression which is always true.
;; An axiom is an theorem assumed to be true.

;; The Axioms of Cons

(dethm atom/cons (x y)
       (equal (atom (cons x y)) 'nil))

(dethm car/cons (x y)
       (equal (car (cons x y)) x))

(dethm cdr/cons (x y)
       (equal (cdr (cons x y)) y))

;; The Axioms of Equal (initial)
(dethm equal-same (x)
       (equal (equal x x) 't))

(dethm equal-swap (x y)
       (equal (equal x y) (equal y x)))  ;; form in the same length

;; The Law of Dethm (initial)
;; the variables could be replaced by any expressions, the body could be replaced with another
;; body, given equal
