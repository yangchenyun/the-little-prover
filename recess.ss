(load "scheme/j-bob-lang.scm")
(load "scheme/j-bob.scm")

;; J Moore and Bob Boyer are known for their work on automated theorem proving
;; and the development of the Boyer-Moore theorem prover.
;;
;; The Boyer-Moore prover used a technique known as backward chaining, which
;; involves starting with the conclusion of a theorem and working backward to
;; find a set of premises that would lead to that conclusion.

;; 1st argument: list of definitinos
;; 2nd argument: quoted expression to rewrite
;; 3nd argument: list of steps
(J-Bob/step (prelude)
  '(car (cons 'ham '(cheese)))
  '())

(J-Bob/step (prelude)
  '(car (cons 'ham '(cheese)))
  ;; In each step, the 1st argument is focus; the 2nd argument is an axiom
  '((() (car/cons 'ham '(cheese)))))

(J-Bob/step (prelude)
  '(equal 'flapjack (atom (cons a b)))
  '(((2) (atom/cons a b)) ;; the path to a component in expression
    (() (equal 'flapjack 'nil))))

(J-Bob/step (prelude)
            '(atom (cdr (cons (car (cons p q)) '())))
            '(((1 1 1) (car/cons p q))
              ((1) (cdr/cons p '()))
              (() (atom '()))))

;; if axioms
(J-Bob/step (prelude)
            '(if a c c)
            '())

(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))))

(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (()
               (if-same
                (if (equal a 't)
                    (if (equal 'nil 'nil) a b)
                    (equal 'or (cons 'black '(coffee))))
                c))))

;; Use symbol Q, E to map in if clause
(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (()
               (if-same
                (if (equal a 't)
                    (if (equal 'nil 'nil) a b)
                    (equal 'or (cons 'black '(coffee))))
                c))
              ;; Q, E represents positional arguments of if-clause
              ((Q E 2) (cons 'black '(coffee)))))

(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (()
               (if-same
                (if (equal a 't)
                    (if (equal 'nil 'nil) a b)
                    (equal 'or (cons 'black '(coffee))))
                c))
              ;; Q, E represents positional arguments of if-clause
              ((Q E 2) (cons 'black '(coffee)))
              ((Q A Q) (equal-same 'nil))))

(J-Bob/step (prelude)
            '(if a c c)
            '((() (if-same a c))
              (()
               (if-same
                (if (equal a 't)
                    (if (equal 'nil 'nil) a b)
                    (equal 'or (cons 'black '(coffee))))
                c))
              ;; Q, E represents positional arguments of if-clause
              ((Q E 2) (cons 'black '(coffee)))
              ((Q A Q) (equal-same 'nil))
              ((Q A) (if-true a b))))
