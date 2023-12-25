(deftemplate Interface
   (slot slot (default-dynamic (gensym*)))
   (slot show)
   (multislot books)
   (slot branch (default none))
   (slot response (default none))
   (multislot answers)
   (slot state (default middle)))

(deftemplate state-list
   (slot current)
   (multislot sequence))

(deffacts startup
   (state-list))





(defrule system-banner ""
  =>
  (assert (Interface (show main)
                    (branch start)
                    (state begin)))
)

(defrule choose_start_question ""
    (logical (start))
    =>
    (assert (Interface (show first_question)
                      (branch start_Q)
                      (answers yes no)))
)

(defrule popular_fiction_thrillers ""
    (logical (start_Q yes))
    =>
    (assert (Interface (show q_thrillers)
                      (branch q_thrillers)
                      (answers yes no)))
)

(defrule answer_thrillers""
    (logical (q_thrillers yes))
    =>
    (assert (Interface (show first_answer)
                      (books ans_1 ans_2 ans_3)
                      (state end)))
)

(defrule popular_fiction_mystery ""
    (logical (q_thrillers no))
    =>
    (assert (Interface (show q_mystery)
                      (branch q_mystery)
                      (answers yes no)))
)

(defrule answer_mystery ""
    (logical (q_mystery yes))
    =>
    (assert (Interface (show second_answer)
                      (state end)))
)

(defrule popular_fiction_family ""
    (logical (q_mystery no))
    =>
    (assert (Interface (show q_family)
                      (branch q_family)
                      (answers yes no)))
)

(defrule answer_family ""
    (logical (q_family yes))
    =>
    (assert (Interface (show answer_family)
                      (state end)))
)

(defrule popular_fiction_fantasy ""
    (logical (q_family no))
    =>
    (assert (Interface (show q_fantasy)
                      (branch q_fantasy)
                      (answers yes no)))
)

(defrule answer_fantasy ""
    (logical (q_fantasy yes))
    =>
    (assert (Interface (show answer_fantasy)
                      (state end)))
)

(defrule popular_fiction_romance ""
    (logical (q_fantasy no))
    =>
    (assert (Interface (show q_romance)
                      (branch q_romance)
                      (answers yes no)))
)

(defrule answer_romance ""
    (logical (q_romance yes))
    =>
    (assert (Interface (show answer_romance)
                      (state end)))
)

(defrule popular_fiction_timeTravel ""
    (logical (q_romance no))
    =>
    (assert (Interface (show q_timeTravel)
                      (branch q_timeTravel)
                      (answers yes no)))
)

(defrule answer_timeTravel ""
    (logical (q_timeTravel yes))
    =>
    (assert (Interface (show answer_timeTravel)
                      (state end)))
)

(defrule answer_timeTravel ""
    (logical (q_timeTravel yes))
    =>
    (assert (Interface (show answer_timeTravel)
                      (state end)))
)

(defrule answer_suspense ""
    (logical (q_timeTravel no))
    =>
    (assert (Interface (show answer_suspense)
                      (state end)))
)









(defrule ask-question
   (declare (salience 5))
   (Interface (slot ?slot))
   ?f <- (state-list (sequence $?s&:(not (member$ ?slot ?s))))
   =>
   (modify ?f (current ?slot) (sequence ?slot ?s))
   (halt))

(defrule handle-next-no-change-none-middle-of-chain
   (declare (salience 10))
   ?f1 <- (next ?slot)
   ?f2 <- (state-list (current ?slot) (sequence $? ?nid ?slot $?))
   =>
   (retract ?f1)
   (modify ?f2 (current ?nid))
   (halt))

(defrule handle-next-response-none-end-of-chain
   (declare (salience 10))
   ?f <- (next ?slot)
   (state-list (sequence ?slot $?))
   (Interface (slot ?slot) (branch ?branch))
   =>
   (retract ?f)
   (assert (add-response ?slot)))

(defrule handle-next-no-change-middle-of-chain
   (declare (salience 10))
   ?f1 <- (next ?slot ?response)
   ?f2 <- (state-list (current ?slot) (sequence $? ?nid ?slot $?))
   (Interface (slot ?slot) (response ?response))
   =>
   (retract ?f1)
   (modify ?f2 (current ?nid))
   (halt))

(defrule handle-next-change-middle-of-chain
   (declare (salience 10))
   (next ?slot ?response)
   ?f1 <- (state-list (current ?slot) (sequence ?nid $?b ?slot $?e))
   (Interface (slot ?slot) (response ~?response))
   ?f2 <- (Interface (slot ?nid))
   =>
   (modify ?f1 (sequence ?b ?slot ?e))
   (retract ?f2))

(defrule handle-next-response-end-of-chain
   (declare (salience 10))
   ?f1 <- (next ?slot ?response)
   (state-list (sequence ?slot $?))
   ?f2 <- (Interface (slot ?slot)
                     (response ?expected)
                     (branch ?branch))
   =>
   (retract ?f1)
   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
   (assert (add-response ?slot ?response)))

(defrule handle-add-response
   (declare (salience 10))
   (logical (Interface (slot ?slot) (branch ?branch)))
   ?f1 <- (add-response ?slot ?response)
   =>
   (str-assert (str-cat "(" ?branch " " ?response ")"))
   (retract ?f1))

(defrule handle-add-response-none
   (declare (salience 10))
   (logical (Interface (slot ?slot) (branch ?branch)))
   ?f1 <- (add-response ?slot)
   =>
   (str-assert (str-cat "(" ?branch ")"))
   (retract ?f1))

(defrule handle-prev
   (declare (salience 10))
   ?f1 <- (prev ?slot)
   ?f2 <- (state-list (sequence $?b ?slot ?p $?e))
   =>
   (retract ?f1)
   (modify ?f2 (current ?p))
   (halt))
