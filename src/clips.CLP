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





(defrule main ""
  =>
  (assert (Interface (show main)
                    (branch start)
                    (state begin)))
)


;;;================================================= Popular Fiction =====================================================

(defrule choose_start_question ""
    (logical (start))
    =>
    (assert (Interface (branch POPULAR-FICTION)
                       (answers yes no)
                       (show popular_fiction)))
)

;;;**************** Thrillers ****************

(defrule popular_fiction_thrillers ""
    (logical (POPULAR-FICTION yes))
    =>
    (assert (Interface (branch THRILLERS)
                       (answers yes no)
                       (show thrillers_q)))
)

(defrule answer_thrillers""
    (logical (THRILLERS yes))
    =>
    (assert (Interface (state end)
                       (show thrillers)
                       (books thr_1 thr_2 thr_3)))
)

;;;*************** Mystery ******************

(defrule popular_fiction_mystery ""
    (logical (THRILLERS no))
    =>
    (assert (Interface (branch MYSTERY)
                       (show mystery_q)
                       (answers yes no)))
)

(defrule answer_mystery ""
    (logical (MYSTERY yes))
    =>
    (assert (Interface (state end)
                       (show mystery)
                       (books mys_1 mys_2)))
)

;;;*************** Family ********************

(defrule popular_fiction_family ""
    (logical (MYSTERY no))
    =>
    (assert (Interface (branch FAMILY)
                       (show family_q)
                       (answers yes no)))
)

(defrule answer_family ""
    (logical (FAMILY yes))
    =>
    (assert (Interface (state end)
                       (show family)
                       (books fam_1 fam_2 fam_3)))
)

;;;*************** Fantasy ********************

(defrule popular_fiction_fantasy ""
    (logical (FAMILY no))
    =>
    (assert (Interface (branch FANTASY)
                       (show fantasy_q)
                       (answers yes no)))
)

(defrule answer_fantasy ""
    (logical (FANTASY yes))
    =>
    (assert (Interface (state end)
                       (show fantasy)
                       (books fan_1)))
)

;;;*************** Romance ********************

(defrule popular_fiction_romance ""
    (logical (FANTASY no))
    =>
    (assert (Interface (branch ROMANCE)
                       (show romance_q)
                       (answers yes no)))
)

(defrule answer_romance ""
    (logical (ROMANCE yes))
    =>
    (assert (Interface (state end)
                       (show romance)
                       (books rom_1 rom_2)))
)

;;;*************** Time Travel ********************

(defrule popular_fiction_time_travel ""
    (logical (ROMANCE no))
    =>
    (assert (Interface (branch TIME_TRAVEL)
                       (show time_travel_q)
                       (answers yes no)))
)

(defrule answer_time_travel ""
    (logical (TIME_TRAVEL yes))
    =>
    (assert (Interface (state end)
                       (show time_travel)
                       (books tt_1 tt_2 )))
)

;;;*************** Suspense ********************

(defrule popular_fiction_suspense ""
    (logical (TIME_TRAVEL no))
    =>
    (assert (Interface (branch SUSPENSE)
                       (show suspense_q)
                       (answers yes)))
)

(defrule answer_suspense ""
    (logical (SUSPENSE yes))
    =>
    (assert (Interface (state end)
                       (show suspense)
                       (books sus_1 sus_2 sus_3)))
)


;;;========================================= Literary Fiction ============================================

(defrule literary_fiction ""
    (logical (POPULAR-FICTION no))
    =>
    (assert (Interface (branch LITERARY_FICTION)
                       (answers yes no)
                       (show literary_fiction)))
)

;;;*************** Dystopia **************

(defrule literary_fiction_dystopia ""
    (logical (LITERARY_FICTION yes))
    =>
    (assert (Interface (branch DYSTOPIA)
                       (show dystopia_q)
                       (answers yes no)))
)

(defrule answer_literary_fiction ""
    (logical (DYSTOPIA yes))
    =>
    (assert (Interface (state end)
                       (show dystopia)
                       (books dys_1 dys_2)))
)

;;;*************** Fantasy ********************

(defrule literary_fiction_fantasy ""
    (logical (DYSTOPIA no))
    =>
    (assert (Interface (branch FANTASY_LF)
                       (show fantasy_lf_q)
                       (answers yes no)))
)

(defrule answer_fantasy_lf ""
    (logical (FANTASY_LF yes))
    =>
    (assert (Interface (state end)
                       (show fantasy_lf)
                       (books fan_lf_1 fan_lf_2)))
)

;;;*************** Identity ********************

(defrule literary_fiction_identity ""
    (logical (FANTASY_LF no))
    =>
    (assert (Interface (branch IDENTITY)
                       (show identity_q)
                       (answers yes no)))
)

(defrule answer_identity ""
    (logical (IDENTITY yes))
    =>
    (assert (Interface (state end)
                       (show identity)
                       (books id_1 id_2 id_3)))
)

;;;*************** Magical Realism ********************

(defrule literary_fiction_magical_realism ""
    (logical (IDENTITY no))
    =>
    (assert (Interface (branch MAGICAL_REALISM)
                       (show magical_realism_q)
                       (answers yes no)))
)

(defrule answer_magical_realism ""
    (logical (MAGICAL_REALISM yes))
    =>
    (assert (Interface (state end)
                       (show magical_realism)
                       (books mr_1 mr_2 mr_3 mr_4)))
)

;;;*************** Cosmic Books ********************

(defrule literary_fiction_cosmic_books ""
    (logical (MAGICAL_REALISM no))
    =>
    (assert (Interface (branch COSMIC_BOOKS)
                       (show cosmic_books_q)
                       (answers yes no)))
)

(defrule answer_cosmic_books ""
    (logical (COSMIC_BOOKS yes))
    =>
    (assert (Interface (state end)
                       (show cosmic_books)
                       (books cb_1)))
)

;;;*************** Crime ********************

(defrule literary_fiction_crime ""
    (logical (COSMIC_BOOKS no))
    =>
    (assert (Interface (branch CRIME_LF)
                       (show crime_lf_q)
                       (answers yes no)))
)

(defrule answer_crime_lf ""
    (logical (CRIME_LF yes))
    =>
    (assert (Interface (state end)
                       (show crime_lf)
                       (books cl_1)))
)

;;;*************** History ********************

(defrule literary_fiction_history ""
    (logical (CRIME_LF no))
    =>
    (assert (Interface (branch HISTORY_LF)
                       (show history_lf_q)
                       (answers yes no)))
)

(defrule answer_history_lf ""
    (logical (HISTORY_LF yes))
    =>
    (assert (Interface (state end)
                       (show history_lf)
                       (books hl_1)))
)

;;;*************** Family ********************

(defrule literary_fiction_family_lf ""
    (logical (HISTORY_LF no))
    =>
    (assert (Interface (branch FAMILY_LF)
                       (show family_lf_q)
                       (answers yes no)))
)

(defrule answer_family_lf ""
    (logical (FAMILY_LF yes))
    =>
    (assert (Interface (state end)
                       (show family_lf)
                       (books fl_1 fl_2)))
)

;;;*************** Mystery ********************

(defrule literary_fiction_mystery_lf_q ""
    (logical (FAMILY_LF no))
    =>
    (assert (Interface (branch MYSTERY_LF)
                       (show mystery_lf_q)
                       (answers yes no)))
)

(defrule literary_fiction_mystery_lf ""
    (logical (MYSTERY_LF yes))
    =>
    (assert (Interface (branch MYSTERY_LF_YES)
                       (show mystery_lf_q)
                       (answers mys_lf_literary_q mys_lf_suspense_q)))
)

;....................... literary

(defrule answer_mystery_lf_lit ""
    (logical (MYSTERY_LF_YES mys_lf_literary_q))
    =>
    (assert (Interface (state end)
                       (show mys_lf_literary)
                       (books ml_lit_1)))
)

;........................ suspense

(defrule answer_mystery_lf_sus ""
    (logical (MYSTERY_LF_YES mys_lf_suspense_q))
    =>
    (assert (Interface (state end)
                       (show mys_lf_suspense)
                       (books ml_sus_1 ml_sus_2 ml_sus_3 ml_sus_4 ml_sus_5)))
)

;;;*************** Baseball ********************

(defrule literary_fiction_baseball ""
    (logical (MYSTERY_LF no))
    =>
    (assert (Interface (branch BASEBALL_LF)
                       (show baseball_lf_q)
                       (answers yes no)))
)

(defrule answer_baseball_lf ""
    (logical (BASEBALL_LF yes))
    =>
    (assert (Interface (state end)
                       (show baseball_lf)
                       (books bl_1)))
)

;;;*************** New Culture ********************

(defrule literary_fiction_new_culture ""
    (logical (BASEBALL_LF no))
    =>
    (assert (Interface (branch NEW_CULTURE_LF)
                       (show new_culture_lf_q)
                       (answers yes no)))
)

(defrule answer_new_culture_lf ""
    (logical (NEW_CULTURE_LF yes))
    =>
    (assert (Interface (branch NEW_CULTURE_LF_YES)
                       (show new_culture_lf_q)
                       (answers nc_lf_civ_rig_q nc_lf_rom_q nc_lf_war_q nc_lf_epist_q nc_lf_hist_q nc_lf_jap_q)))
)

;...................Civil Rights

(defrule literary_fiction_new_culture_civ_rig ""
    (logical (NEW_CULTURE_LF_YES nc_lf_civ_rig_q))
    =>
    (assert (Interface (state end)
                       (show nc_lf_civ_rig)
                       (books ncl_cr_1 ncl_cr_2)))
)

;...................Romance

(defrule literary_fiction_new_culture_rom ""
    (logical (NEW_CULTURE_LF_YES nc_lf_rom_q))
    =>
    (assert (Interface (state end)
                       (show nc_lf_rom)
                       (books ncl_rom_1)))
)

;...................war

(defrule literary_fiction_new_culture_war ""
    (logical (NEW_CULTURE_LF_YES nc_lf_war_q))
    =>
    (assert (Interface (state end)
                       (show nc_lf_war)
                       (books ncl_war_1)))
)

;...................Epistolary

(defrule literary_fiction_new_culture_epist ""
    (logical (NEW_CULTURE_LF_YES nc_lf_epist_q))
    =>
    (assert (Interface (state end)
                       (show nc_lf_epist)
                       (books ncl_epist_1)))
)

;...................Historical

(defrule literary_fiction_new_culture_hist ""
    (logical (NEW_CULTURE_LF_YES nc_lf_hist_q))
    =>
    (assert (Interface (state end)
                       (show nc_lf_hist)
                       (books ncl_hist_1 ncl_hist_2)))
)

;...................Japan

(defrule literary_fiction_new_culture_jap ""
    (logical (NEW_CULTURE_LF_YES nc_lf_jap_q))
    =>
    (assert (Interface (state end)
                       (show nc_lf_jap)
                       (books ncl_jap_1)))
)

;;;*************** Good Fantasy (within Literary Fiction) ********************

(defrule literary_fiction_fantasy_lf_2 ""
    (logical (NEW_CULTURE_LF no))
    =>
    (assert (Interface (branch FANTASY_LF_2)
                       (show fantasy_lf_2_q)
                       (answers yes)))
)

(defrule answer_fantasy_lf_lf ""
    (logical (FANTASY_LF_2 yes))
    =>
    (assert (Interface (branch FANTASY_LF_2_YES)
                       (show fantasy_lf_2_q)
                       (answers fan_lf_epic_q fan_lf_vd_q fan_lf_vamp_q fan_lf_hist_q fan_lf_mgc_q fan_lf_lit_q fan_lf_rom_q)))
)

;...................Epic

(defrule literary_fiction_fantasy_lf_2_epic ""
    (logical (FANTASY_LF_2_YES fan_lf_epic_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_epic)
                       (books fan_lf_epic_1)))
)

;...................Video games

(defrule literary_fiction_fantasy_lf_2_vd ""
    (logical (FANTASY_LF_2_YES fan_lf_vd_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_vd)
                       (books fan_lf_vd_1)))
)

;...................Vampires

(defrule literary_fiction_fantasy_lf_2_vamp ""
    (logical (FANTASY_LF_2_YES fan_lf_vamp_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_vamp)
                       (books fan_lf_vamp_1)))
)

;...................Historical

(defrule literary_fiction_fantasy_lf_2_hist ""
    (logical (FANTASY_LF_2_YES fan_lf_hist_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_hist)
                       (books fan_lf_hist_1)))
)

;...................magic

(defrule literary_fiction_fantasy_lf_2_mgc ""
    (logical (FANTASY_LF_2_YES fan_lf_mgc_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_mgc)
                       (books fan_lf_mgc_1 fan_lf_mgc_2)))
)

;...................Literary

(defrule literary_fiction_fantasy_lf_2_lit ""
    (logical (FANTASY_LF_2_YES fan_lf_lit_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_lit)
                       (books fan_lf_lit_1)))
)

;...................Romance

(defrule literary_fiction_fantasy_lf_2_rom ""
    (logical (FANTASY_LF_2_YES fan_lf_rom_q))
    =>
    (assert (Interface (state end)
                       (show fan_lf_rom)
                       (books fan_lf_rom_1)))
)


;;;========================================= Fiction for Kids ==============================

(defrule fiction_for_kids ""
    (logical (LITERARY_FICTION no))
    =>
    (assert (Interface (branch FICTION_FOR_KIDS)
                       (answers yes no)
                       (show fiction_for_kids)))
)

;;;*************** Young Adults ********************

(defrule fiction_for_kids_yes ""
    (logical (FICTION_FOR_KIDS yes))
    =>
    (assert (Interface (branch YOUNG_ADULTS)
                       (show young_adults_q)
                       (answers yes no)))
)

(defrule young_adults ""
    (logical (YOUNG_ADULTS yes))
    =>
    (assert (Interface (branch YOUNG_ADULTS_yes)
                       (show young_adults_q)
                       (answers YA_historical_q YA_humor_q)))
)

;;;...........historical

(defrule answer_young_adults_historical ""
    (logical (YOUNG_ADULTS_yes YA_historical_q))
    =>
    (assert (Interface (state end)
                       (show YA_historical)
                       (books YA_historical_1)))
)

;;;............humor

(defrule answer_young_adults_humor ""
    (logical (YOUNG_ADULTS_yes YA_humor_q))
    =>
    (assert (Interface (state end)
                       (show YA_humor)
                       (books YA_humor_1)))
)

;;;*************** Children's Literature ********************

(defrule children_literature ""
    (logical (YOUNG_ADULTS no))
    =>
    (assert (Interface (branch CHILDREN_LITERATURE)
                       (show children_literature_q)
                       (answers yes no)))
)

(defrule children_literature_ ""
    (logical (CHILDREN_LITERATURE yes))
    =>
    (assert (Interface (branch CHILDREN_LITERATURE_yes)
                       (show children_literature_q)
                       (answers CL_coming_of_age_q CL_thriller_q CL_peril_q CL_fantasy_q)))
)

;...............Coming of Age

(defrule answer_children_literature_coming_of_age ""
    (logical (CHILDREN_LITERATURE_yes CL_coming_of_age_q))
    =>
    (assert (Interface (state end)
                       (show CL_coming_of_age)
                       (books CL_coming_of_age_1)))
)

;...............Thriller

(defrule answer_children_literature_thriller ""
    (logical (CHILDREN_LITERATURE_yes CL_thriller_q))
    =>
    (assert (Interface (state end)
                       (show CL_thriller)
                       (books CL_thriller_1)))
)

;...............Peril

(defrule answer_children_literature_peril ""
    (logical (CHILDREN_LITERATURE_yes CL_peril_q))
    =>
    (assert (Interface (state end)
                       (show CL_peril)
                       (books CL_peril_1)))
)

;...............Fantasy

(defrule answer_children_literature_fantasy ""
    (logical (CHILDREN_LITERATURE_yes CL_fantasy_q))
    =>
    (assert (Interface (state end)
                       (show CL_fantasy)
                       (books CL_fantasy_1 CL_fantasy_2 CL_fantasy_3)))
)

;;;*************** Teen Literature ********************

(defrule teen_literature ""
    (logical (CHILDREN_LITERATURE no))
    =>
    (assert (Interface (branch TEEN_LITERATURE)
                       (show teen_literature_q)
                       (answers yes)))
)

(defrule teen_literature_ ""
    (logical (TEEN_LITERATURE yes))
    =>
    (assert (Interface (branch TEEN_LITERATURE_yes)
                       (show teen_literature_q)
                       (answers TL_historical_q TL_thriller_q TL_fantasy_q TL_relationships_q TL_vampires_q)))
)

;;;.......................historical

(defrule answer_teen_literature_historical ""
    (logical (TEEN_LITERATURE_yes TL_historical_q))
    =>
    (assert (Interface (state end)
                       (show TL_historical)
                       (books TL_historical_1)))
)

;;;.......................thriller

(defrule answer_teen_literature_thriller ""
    (logical (TEEN_LITERATURE_yes TL_thriller_q))
    =>
    (assert (Interface (state end)
                       (show TL_thriller)
                       (books TL_thriller_1)))
)

;;;.......................fantasy

(defrule answer_teen_literature_fantasy ""
    (logical (TEEN_LITERATURE_yes TL_fantasy_q))
    =>
    (assert (Interface (state end)
                       (show TL_fantasy)
                       (books TL_fantasy_1 TL_fantasy_2 TL_fantasy_3)))
)

;;;.......................relationship

(defrule answer_teen_literature_relationship ""
    (logical (TEEN_LITERATURE_yes TL_relationships_q))
    =>
    (assert (Interface (state end)
                       (show TL_relationships)
                       (books TL_relationships_1 TL_relationships_2)))
)

;;;.......................vampires

(defrule answer_teen_literature_vampires ""
    (logical (TEEN_LITERATURE_yes TL_vampires_q))
    =>
    (assert (Interface (state end)
                       (show TL_vampires)
                       (books TL_vampires_1 TL_vampires_2)))
)


;;;========================================= Nonfiction ========================================

(defrule nonfiction ""
    (logical (FICTION_FOR_KIDS no))
    =>
    (assert (Interface (branch NONFICTION)
                       (show nonfiction)
                       (answers yes no)))
)

;;;*************** Memories ********************

(defrule non ""
    (logical (NONFICTION yes))
    =>
    (assert (Interface (branch MEMORIES)
                       (show NF_memories_q)
                       (answers yes no)))
)

(defrule memories ""
    (logical (MEMORIES yes))
    =>
    (assert (Interface (branch MEMORIES_yes)
                       (show NF_memories_q)
                       (answers M_family_q M_humor_q M_medical_q M_current_events_q M_self_fulfilment_q)))
)

;......................family

(defrule answer_memories_family ""
    (logical (MEMORIES_yes M_family_q))
    =>
    (assert (Interface (state end)
                       (show MEMORIES_FAMILY)
                       (books M_family_1 M_family_2)))
)

;......................humor

(defrule answer_memories_humor ""
    (logical (MEMORIES_yes M_humor_q))
    =>
    (assert (Interface (state end)
                       (show MEMORIES_HUMOR)
                       (books M_humor_1 M_humor_2)))
)

;......................medical

(defrule answer_memories_medical ""
    (logical (MEMORIES_yes M_medical_q))
    =>
    (assert (Interface (state end)
                       (show MEMORIES_MEDICAL)
                       (books M_medical_1)))
)

;......................Current events

(defrule answer_memories_current_events ""
    (logical (MEMORIES_yes M_current_events_q))
    =>
    (assert (Interface (state end)
                       (show MEMORIES_CURRENT_EVENTS)
                       (books M_current_events_1)))
)

;......................Self-fulfillment

(defrule answer_memories_self_fulfilment ""
    (logical (MEMORIES_yes M_self_fulfilment_q))
    =>
    (assert (Interface (state end)
                       (show MEMORIES_SELF_FULFILMENT)
                       (books M_self_fulfilment_1)))
)

;;;*************** Food ********************

(defrule food ""
    (logical (MEMORIES no))
    =>
    (assert (Interface (branch NF_FOOD)
                       (show NF_food_q)
                       (answers yes no)))
)

(defrule ans_food ""
    (logical (NF_FOOD yes))
    =>
    (assert (Interface (state end)
                       (show food)
                       (books NF_FOOD_1)))
)

;;;*************** Business ********************

(defrule business ""
    (logical (NF_FOOD no))
    =>
    (assert (Interface (branch NF_BUSINESS)
                       (show NF_business_q)
                       (answers yes no)))
)

(defrule ans_business ""
    (logical (NF_BUSINESS yes))
    =>
    (assert (Interface (state end)
                       (show business)
                       (books NF_BUSINESS_1 NF_BUSINESS_2 NF_BUSINESS_3)))
)

;;;*************** Biography ********************

(defrule biography ""
    (logical (NF_BUSINESS no))
    =>
    (assert (Interface (branch NF_BIOGRAPHY)
                       (show NF_biography_q)
                       (answers yes no)))
)

(defrule ans_biography ""
    (logical (NF_BIOGRAPHY yes))
    =>
    (assert (Interface (state end)
                       (show NF_biography)
                       (books NF_BIOGRAPHY_1 NF_BIOGRAPHY_2)))
)

;;;*************** Grammar ********************

(defrule grammar ""
    (logical (NF_BIOGRAPHY no))
    =>
    (assert (Interface (branch NF_GRAMMAR)
                       (show NF_grammar_q)
                       (answers yes no)))
)

(defrule ans_grammar ""
    (logical (NF_GRAMMAR yes))
    =>
    (assert (Interface (state end)
                       (show NF_grammar)
                       (books NF_GRAMMAR_1)))
)

;;;*************** History ********************

(defrule history ""
    (logical (NF_GRAMMAR no))
    =>
    (assert (Interface (branch NF_HISTORY)
                       (show NF_history_q)
                       (answers yes no)))
)

(defrule ans_history ""
    (logical (NF_HISTORY yes))
    =>
    (assert (Interface (state end)
                       (show NF_history)
                       (books NF_HISTORY_1)))
)

;;;*************** Humor ********************

(defrule humor ""
    (logical (NF_HISTORY no))
    =>
    (assert (Interface (branch NF_HUMOR)
                       (show NF_humor_q)
                       (answers yes no)))
)

(defrule ans_humor ""
    (logical (NF_HUMOR yes))
    =>
    (assert (Interface (state end)
                       (show NF_humor)
                       (books NF_HUMOR_1)))
)

;;;*************** Inspiration ********************

(defrule inspiration ""
    (logical (NF_HUMOR no))
    =>
    (assert (Interface (branch NF_INSPIRATION)
                       (show NF_inspiration_q)
                       (answers yes no)))
)

(defrule ans_inspiration ""
    (logical (NF_INSPIRATION yes))
    =>
    (assert (Interface (state end)
                       (show NF_inspiration)
                       (books NF_INSPIRATION_1)))
)

;;;*************** U.S. Government ********************

(defrule us ""
    (logical (NF_INSPIRATION no))
    =>
    (assert (Interface (branch NF_US)
                       (show NF_us_government_q)
                       (answers yes no)))
)

(defrule ans_us ""
    (logical (NF_US yes))
    =>
    (assert (Interface (state end)
                       (show NF_us_government)
                       (books NF_USGOV_1)))
)

;;;*************** Nutrition ********************

(defrule nutrition ""
    (logical (NF_US no))
    =>
    (assert (Interface (branch NF_NUTRITION)
                       (show NF_nutrition_q)
                       (answers yes)))
)

(defrule ans_nutrition ""
    (logical (NF_NUTRITION yes))
    =>
    (assert (Interface (state end)
                       (show NF_nutrition)
                       (books NF_NUTR_1)))
)


;;;========================================= Self-Help Fiction ========================================

(defrule self_help_fiction ""
    (logical (NONFICTION no))
    =>
    (assert (Interface (branch SELF_HELP_FICTION)
                       (show self_help_fiction)
                       (answers yes)))
)

;;;*************** Relationships ********************

(defrule relationships_shf ""
    (logical (SELF_HELP_FICTION yes))
    =>
    (assert (Interface (branch SH_RELAT)
                       (show relationships_q)
                       (answers yes no)))
)

(defrule ans_relationships_shf ""
    (logical (SH_RELAT yes))
    =>
    (assert (Interface (state end)
                       (show relationships)
                       (books SHF_relationships_1)))
)

;;;*************** Inspirational ********************

(defrule inspirational_shf ""
    (logical (SH_RELAT no))
    =>
    (assert (Interface (branch SH_INSP)
                       (show inspirational_q)
                       (answers yes no)))
)

(defrule ans_inspirational_shf ""
    (logical (SH_INSP yes))
    =>
    (assert (Interface (state end)
                       (show inspirational)
                       (books SHF_inspirational_1 SHF_inspirational_2)))
)

;;;*************** Business ********************

(defrule business_shf ""
    (logical (SH_INSP no))
    =>
    (assert (Interface (branch SH_BUSS)
                       (show business_q)
                       (answers yes)))
)

(defrule ans_business_shf ""
    (logical (SH_BUSS yes))
    =>
    (assert (Interface (state end)
                       (show BUSINESS)
                       (books B_1 B_2 B_3 B_4 B_5)))
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

(defrule handle-previous
   (declare (salience 10))
   ?f1 <- (previous ?slot)
   ?f2 <- (state-list (sequence $?b ?slot ?p $?e))
   =>
   (retract ?f1)
   (modify ?f2 (current ?p))
   (halt))
