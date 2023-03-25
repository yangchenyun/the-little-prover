(load "scheme/j-bob-lang.scm")
(load "scheme/j-bob.scm")

;; The Axioms of If (initial)
(dethm if-true (x y) (equal (if 't x y) x))
(dethm if-false (x y) (equal (if 'nil x y) y))
(dethm if-same (c y) (equal (if c y y) y))

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

;; A new equal axiom based to rewrite
;;
;; (if (if (equal a 't)
;;         a
;;         (equal 'or '(black coffee))) c c)

;; One more axiom for equal
(dethm equal-if (x y)
       (if (equal x y) (equal x y) 't))

;; The Law of Dethm (final) For any theorem (dethm name (x1 ... xn ) body_x),
;; the variables x1 ... xn in body_x can be replaced with cosponding expressions
;; e1 ... en.
;;
;; The result, body_e, can be used to rewrite a focus as follows:
;;
;; 1. body_e must contain the conclusion (equal p q) or (equal q p),
;; 2. the conclusion must not be found in the question of any if or in the
;; argument of any function application.
;; 3. and if the conclusion can be found in an if answer (respectively else),
;; then the focus must be found in an if answer (respectively else) with the
;; same question.
;;
;;
;; Notes: the idea is to use the information in the if question to substitute
;; forms. After subsituting a dethm, ensure the premise for the conclusion is met
;; in the original expression.
;;
;; rule 1 and 2 selects an conclusion form for potential replacement
;; rule 3, For every premise of the conclusion, check whether focus appears
;; in the same question, in order to determine its value.

;; (if (if (equal a 't)
;;         a
;;         (equal 'or '(black coffee))) c c)
;;
;; x = a,
;; y = t'
;; focus: (equal a 't)
;; body_e: (if (equal a 't) (equal a 't) 't), used for rewriting
;; conclusion: (equal a 't), cannot be in question, or any function argument
;; check: it appears in an answer, so check whether the form could be found in
;; an question.

(J-Bob/step (prelude)
            '(if (if (equal a 't) a (equal 'or '(black coffee))) c c)
            '(((Q A) (equal-if a 't))))

;; Definition: A premise is an if question such that a focus can be found in
;; either the if answer or the if else.

;; Reference
;;
;; "Jabberwocky" was written by Lewis Carroll. It is a nonsense poem that uses
;; invented words and imaginary creatures to create a dreamlike, fantastical
;; atmosphere.
;;
;; Lewis Carroll was the pen name of the English writer and mathematician
;; Charles Lutwidge Dodgson. He was born in 1832 in Daresbury, Cheshire,
;; England, and is best known for his classic children's books "Alice's
;; Adventures in Wonderland" and "Through the Looking-Glass, and What Alice
;; Found There."

(dethm jabberwocky (x)
       (if (brillig x)
           (if (slithy x)
               (equal (mimsy x) 'borogove)
               (equal (mome x) 'rath))
           (if (uffish x)
               (equal (frumious x) 'bandersnatch)
               (equal (frabjous x) 'beamish))))

(J-Bob/step (prelude)
            '(cons 'gyre
                   (if (uffish '(callooh callay))
                       (cons 'gimble
                             (if (brillig '(callooh callay))
                                 (cons 'borogove '(outgrabe))
                                 (cons 'bandersnatch '(wabe))))
                       (cons (frabjous '(callooh callay)) '(vorpal))))
            '(((2 A 2 E) (jabberwocky '(callooh callay)))))


;; The Axioms of Cons (final)
(dethm cons/car+cdr (x)
       (if (atom x) 't (equal (cons (car x) (cdr x)) x)))

(J-Bob/step (prelude)
            '(if (atom (car a))
                 (if (equal (car a) (cdr a))
                     'hominy
                     'grits)
                 (if (equal (cdr (car a)) '(hash browns))
                     (cons 'ketchup (car a))
                     (cons 'mustard (car a))))
            '(((E A 2) (cons/car+cdr (car a)))
              ((E A 2 2) (equal-if (cdr (car a)) '(hash browns)))))

;; The Axioms of If (final)
(dethm if-nest-A (x y z)
       (if x (equal (if x y z) y) 't))
(dethm if-nest-E (x y z)
       (if x 't (equal (if x y z))))

;; if-same (c y)
(J-Bob/step (prelude)
            '(cons
              'statement
              (cons
               (if (equal a 'question)
                   (cons n '(answer)) (cons n '(else)))
               (if (equal a 'question)
                   (cons n '(other answer)) (cons n '(other else)))))
            '(((2) (if-same (equal a 'question)
                            (cons
                             (if (equal a 'question)
                                 (cons n '(answer)) (cons n '(else)))
                             (if (equal a 'question)
                                 (cons n '(other answer)) (cons n '(other else))))))
              ((2 A 1)
               (if-nest-A (equal a 'question) (cons n '(answer)) (cons n '(else))))
              ((2 A 2)
               (if-nest-A (equal a 'question) (cons n '(other answer)) (cons n '(other else))))
              ((2 E 1)
               (if-nest-E (equal a 'question) (cons n '(answer)) (cons n '(else))))
              ((2 E 2)
               (if-nest-E (equal a 'question) (cons n '(other answer)) (cons n '(other else))))))
