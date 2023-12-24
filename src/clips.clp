;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate Interface
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot answer_1)
   (slot answer_2)
   (slot answer_3)
   (slot answer_4)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deffacts startup
   (state-list))


;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>

  (assert (Interface (display main)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))






;;;***************
;;;* QUERY RULES *
;;;***************

(defrule choose_start_question ""
    (logical (start))
    =>
    (assert (Interface (display first_question)
                      (relation-asserted start_Q)
                      (valid-answers yes no)))
)

(defrule popular_fiction_thrillers ""
    (logical (start_Q yes))
    =>
    (assert (Interface (display q_thrillers)
                      (relation-asserted q_thrillers)
                      (valid-answers yes no)))
)

(defrule answer_thrillers""
    (logical (q_thrillers yes))
    =>
    (assert (Interface (display first_answer)
                      (answer_1 ans_1)
                      (answer_2 ans_2)
                      (answer_3 ans_3)
                      (state final)))
)

(defrule popular_fiction_mystery ""
    (logical (q_thrillers no))
    =>
    (assert (Interface (display q_mystery)
                      (relation-asserted q_mystery)
                      (valid-answers yes no)))
)

(defrule answer_mystery ""
    (logical (q_mystery yes))
    =>
    (assert (Interface (display second_answer)
                      (answer_1 ans_mys_1)
                      (answer_2 ans_mys_2)
                      (state final)))
)

(defrule popular_fiction_family ""
    (logical (q_mystery no))
    =>
    (assert (Interface (display q_family)
                      (relation-asserted q_family)
                      (valid-answers yes no)))
)

(defrule answer_family ""
    (logical (q_family yes))
    =>
    (assert (Interface (display answer_family)
                      (state final)))
)

(defrule popular_fiction_fantasy ""
    (logical (q_family no))
    =>
    (assert (Interface (display q_fantasy)
                      (relation-asserted q_fantasy)
                      (valid-answers yes no)))
)

(defrule answer_fantasy ""
    (logical (q_fantasy yes))
    =>
    (assert (Interface (display answer_fantasy)
                      (state final)))
)

(defrule popular_fiction_romance ""
    (logical (q_fantasy no))
    =>
    (assert (Interface (display q_romance)
                      (relation-asserted q_romance)
                      (valid-answers yes no)))
)

(defrule answer_romance ""
    (logical (q_romance yes))
    =>
    (assert (Interface (display answer_romance)
                      (state final)))
)

(defrule popular_fiction_timeTravel ""
    (logical (q_romance no))
    =>
    (assert (Interface (display q_timeTravel)
                      (relation-asserted q_timeTravel)
                      (valid-answers yes no)))
)

(defrule answer_timeTravel ""
    (logical (q_timeTravel yes))
    =>
    (assert (Interface (display answer_timeTravel)
                      (state final)))
)

(defrule answer_timeTravel ""
    (logical (q_timeTravel yes))
    =>
    (assert (Interface (display answer_timeTravel)
                      (state final)))
)

(defrule answer_suspense ""
    (logical (q_timeTravel no))
    =>
    (assert (Interface (display answer_suspense)
                      (state final)))
)



;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))

   (Interface (id ?id))

   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))

   =>

   (modify ?f (current ?id)
              (sequence ?id ?s))

   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))

   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))

   =>

   (retract ?f1)

   (modify ?f2 (current ?nid))

   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))

   ?f <- (next ?id)

   (state-list (sequence ?id $?))

   (Interface (id ?id)
             (relation-asserted ?relation))

   =>

   (retract ?f)

   (assert (add-response ?id)))

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))

   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))

   (Interface (id ?id) (response ?response))

   =>

   (retract ?f1)

   (modify ?f2 (current ?nid))

   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))

   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))

   (Interface (id ?id) (response ~?response))

   ?f2 <- (Interface (id ?nid))

   =>

   (modify ?f1 (sequence ?b ?id ?e))

   (retract ?f2))

(defrule handle-next-response-end-of-chain

   (declare (salience 10))

   ?f1 <- (next ?id ?response)

   (state-list (sequence ?id $?))

   ?f2 <- (Interface (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))

   =>

   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))

   (assert (add-response ?id ?response)))

(defrule handle-add-response

   (declare (salience 10))

   (logical (Interface (id ?id)
                      (relation-asserted ?relation)))

   ?f1 <- (add-response ?id ?response)

   =>

   (str-assert (str-cat "(" ?relation " " ?response ")"))

   (retract ?f1))

(defrule handle-add-response-none

   (declare (salience 10))

   (logical (Interface (id ?id)
                      (relation-asserted ?relation)))

   ?f1 <- (add-response ?id)

   =>

   (str-assert (str-cat "(" ?relation ")"))

   (retract ?f1))

(defrule handle-prev

   (declare (salience 10))

   ?f1 <- (prev ?id)

   ?f2 <- (state-list (sequence $?b ?id ?p $?e))

   =>

   (retract ?f1)

   (modify ?f2 (current ?p))

   (halt))
