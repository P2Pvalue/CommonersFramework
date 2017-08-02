; Developed by Dr Peter Barbrook-Johnson and Antonio Tenorio-Fornés

; Comments welcome - emails: p.barbrook-johnson@psi.org.uk, antoniotenorio@ucm.es

extensions [ nw ]
globals [

  initial-products ;; number of initial products
  contrib-distrib ;; Sorted list of contributions per commoner
  dead-commoners-contribs ;; Sorted list of contributions per dead commoner
  ticks-without-projects ;; ticks without projects in the model; used for a stop condition
  gini-index-reserve ;; gini-index

]

breed [commoners commoner] ;; The agents representing individuals interacting (consuming/producing) in the community
breed [products product] ;; The common goods being produced and used in the community
breed [projects project] ;; The main organization of production work in the community (contains tasks)
breed [t4sks t4sk] ;; Individual units of productive work done in the projects of the community

undirected-link-breed [projecttasklinks projecttasklink] ;; represents the project-task relationships; each task belongs to a project
directed-link-breed [commonertasklinks commonertasklink] ;; represents that a task is known by a commoner; its recent-weight (a link parameter) represents the memory of recent contribution of the commoner to that task
undirected-link-breed [commonerprojectlinks commonerprojectlink] ;; represents that an commoner is aware of a project; recent-weight (a link parameter) represents the memory of recent contributions to that project;
undirected-link-breed [friendlinks friendlink] ;; represents relationships among agents that have worked in the same tasks and become "friends".
directed-link-breed [consumerlinks consumerlink] ;; represents a consumption relationhip between a commoner and a product
undirected-link-breed [projectproductlinks projectproductlink] ;; represents to which product the efforts in a project goes.

turtles-own [
  repulsion ;; all agents are naturally pulled away from the center (while they are pushed towards the center when they are active) to represent the natural atrophy of a community. This parameter is used to tune the speed of this process.
]

links-own [

  total-weight ;; TODO use it in the model
  recent-weight ;; the memory of recent activity from between two entities (e.g. Contributions between a commoner and a task or recent frecuency of collaboration between two friends)
  max-recent-weight ;; A parameter used to cap the recent weight of links.

  forget-recent-weight-prob ;; The chances a unit of recent weight is forgotten
  forget-link-prob ;; The chances a link will die due to lack of recent activity. A link can only die if the recen contribution is 0.

  ;; ATRACTION: activities such as production and consumption brings agents towards the center of the model.
  ;; For instance, contributing to a task will make the task (and its project) become closer to the center
  ;; but also will bring the contributing commoner towards the center. The strength of this pulls is set by
  ;; the following parameters
  target-attraction ;; attraction strength of the target node (e.g. how much a task attracts its contributing agents)
  origin-attraction ;; attraction strength of the origin node (e.g. how much a commoner attracts the tasks it is contributing to)

]

commoners-own [
  skills ;; The skills a commoner have. Tasks also have a skill attribute representing the skills needed to contribute to it. TODO Use it beyond setup
  interest ;; a broad representation of the topic/area the commoner is interested in. It affects its vertical position, thus making it easier to find products and projects with similar interests.
  total-contribs ;; the total number of finished contributions
]

projects-own [
  interest ;; a broad representation of the topic/area the project is about. It affects its vertical position,
]

t4sks-own [
  skill ;; The skills needed to contribute to this task. TODO think if keeping it in the basic model
  time-required ;; How many contributions the task needs to be finished
]

products-own [
  interest ;; a broad representation of the topic/area the product is about. It affects its vertical position,
]

to setup
  clear-all

   ;; colour lines to mark projects and products spaces
   ask patches with [pxcor = 0] [set pcolor white]

   create-existing-products
   create-existing-projects
   create-existing-commoners

   set ticks-without-projects 0

   set contrib-distrib [total-contribs] of commoners
   set contrib-distrib sort-by > contrib-distrib

   ;; list of contributions by dead agents
   set dead-commoners-contribs (list)

   update-gini

   reset-ticks
end


to create-existing-products
  ;; create products; set their position and defeault parameters

  if number-of-products = "one" [ set initial-products 1 ]
  if number-of-products = "few" [ set initial-products random 5 + 2 ]
  if number-of-products = "many" [ set initial-products random 100  + 5]

  create-products initial-products [
    set interest random num-interest-categories
    set xcor -25 + random 25
    set ycor -25 + interest
    set-product-parameters
]

end

to set-product-parameters
  ;; Style
  set size 2
  set color orange
  set shape "box"
  ;;

  set repulsion product-repulsion-prob

end

to create-existing-projects
  ;; create projects; set their position and defeault parameters
  create-projects initial-projects [

    set interest random num-interest-categories

    set-project-parameters

    ;; create a project to product link to the nearest product
    ;; only half of the projects have a product, the others will create a new product once they have finished.

    if random-float 1 < 0.5  [
      let my-product min-one-of products [ distance myself ]
      create-projectproductlink-with my-product [ set-projectproductlink-parameters ]
    ]
  ]
end

to set-project-parameters

    ;; Style
    set size 2.5
    set color green - 2
    set shape "target"
    ;;

    set xcor -1 * (random 20) - 5
    set ycor -25 + interest


    set repulsion project-repulsion-prob

    let num-tasks random 10 + 2

    hatch-t4sks num-tasks [
      set-task-parameters
    ]

end

to set-task-parameters

  ;; style
  set size 0.7
  set color green
  set shape "circle"
  ;;

  ;; position
  set ycor [ycor] of myself
  set heading random 360
  fd 1
  ;;

  ;; link to its project
  create-projecttasklink-with myself [tie]

  t4sk-set-skill

  ;; Number of contribution actions needed to finish the task
  set time-required random-normal mean-time-required ( mean-time-required / 4 )

end

to t4sk-set-skill

  ; new tasks set their skill type
  ; if there are no other task in the project
  ; or with probability 50%
  ifelse (not any? [ projecttasklink-neighbors ] of myself) or (random-float 1 < 0.5) [

    ; set a random skill
    set skill random (num-skills - 1)

  ] [

    ; else, set the task skill equal to one of its project tasks
    set skill [ skill ] of one-of [ projecttasklink-neighbors ] of myself

  ]
end

to create-existing-commoners

  ;; commoners hava a preferential attachement like structure
  nw:generate-preferential-attachment commoners friendlinks commoners-num

  ;; the majority of the community has not contributed and therefore have no firends in the model
  ask commoners with [count my-friendlinks = 1] [
    ask one-of my-friendlinks [
      die
    ]
  ]

  ask commoners [
    set-commoner-parameters
  ]

  ask friendlinks [
    set-friendlink-parameters
  ]

  ;; The number of friends is considered as a proxy of the commoner contribution activity, thus setting its horizontal position;
  ask commoners [
    let friends count my-friendlinks
    ;; commoners without friends are at the edge of the model (xcor = 25), each extra friend up to 4 brings it 5 units towards the center
    set xcor 5 * ( 5 - min (list 4 friends) )
  ]

end

to set-commonertasklink-parameters
  set color green
  set hidden? hide-commonertasklinks?
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / contrib-recent-forg
  set forget-link-prob 1 / contrib-long-forg
  set origin-attraction task-commoner-attraction-prob
  set target-attraction commoner-task-attraction-prob
end

to set-consumerlink-parameters
  set color orange
  set hidden? hide-consumerlinks?
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / consume-recent-forg
  set forget-link-prob 1 / consume-long-forg
  set origin-attraction product-commoner-attraction-prob
  set target-attraction commoner-product-attraction-prob
end

to set-commonerprojectlink-parameters
  set color green + 3
  set hidden? hide-commonerprojectlinks?
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / project-recent-forg
  set forget-link-prob 1 / project-long-forg
end

to set-friendlink-parameters
  set color yellow + 3
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / friends-recent-forg
  set forget-link-prob 1 / friends-long-forg
end

to set-projectproductlink-parameters
 set color red
end

to set-commoner-parameters

  ;; style
  set size 1.5
  set color blue


  ;;position and interest
  set interest random num-interest-categories
  set xcor random 25 + 1
  set ycor -25 + interest

  set repulsion commoner-repulsion-prob

  ;; commoners consume a community product
  create-consumerlink-to min-one-of products [ distance myself ] [set-consumerlink-parameters]

  ;; 3 random skills per commoner
  set skills (n-of 3 (n-values num-skills [?]))

  ;; An initial project per commoner
  ;; commoners chose projects that contribute to the products they consume
  ;; if there is no projct that contributes to the commoners products, then choose the closest one
  let product-projects turtle-set [ projectproductlink-neighbors ] of out-consumerlink-neighbors
  ifelse any? product-projects [
    create-commonerprojectlink-with one-of product-projects [set-commonerprojectlink-parameters]
  ] [
    if any? projects [
      create-commonerprojectlink-with min-one-of projects [ distance myself ] [set-commonerprojectlink-parameters]
    ]
  ]

  let num-friends count my-friendlinks
  ;; commoners without friends do not contribute at setup
  if num-friends = 0 [
    ask my-out-commonertasklinks [die]
    ask my-commonerprojectlinks [die]
  ]

  ;; Create links with tasks of my projects with my skills...
  let skilled-tasks (turtle-set [ projecttasklink-neighbors ] of commonerprojectlink-neighbors) with
    [ member? skill [ skills ] of myself ]

  ;; Make commoner-task connections with an upper bound of the number of friends.
  create-commonertasklinks-to n-of min (list count skilled-tasks num-friends) skilled-tasks [
    set-commonertasklink-parameters
    set recent-weight random min (list 4 num-friends) + random 1
  ]

  set total-contribs sum [recent-weight] of my-out-commonertasklinks * random 10

end

to go

  ask commoners [

    ;; contribution
    find-project
    find-task
    contribute

    ;; friendship
    find-friends

    ;; consumption
    find-product
    consume

    ;; bring friends
    recommend

    ;; create project
    propose-project

    ;; leave community
    leave

  ]

  product-death

  project-death

  links-decay

  update-positions

  update-contrib-distrib

  ;; Stop conditions
  ;; ... if there are no commoner
  if not any? commoners [ stop ]

  ;; ... if there are no products
    if not any? products [ stop ]

  ;; ... if there is no project for 30 ticks
  ifelse not any? projects [
    set ticks-without-projects ticks-without-projects + 1
  ] [
    set ticks-without-projects 0
  ]

  if ticks-without-projects > 30 [ stop ]

  ;; Gini coefficient calc.
  update-gini

  tick

end

to update-contrib-distrib
  set contrib-distrib sentence [total-contribs] of commoners dead-commoners-contribs
  set contrib-distrib sort-by > contrib-distrib
end

to update-positions

  ;; each tick, agents update their positions depending on:
  ;;  1) the attraction affecting them from their active links: consumer/commonertask/commonerproject
  attraction-movements
  ;;  2) the repulsion towards the edges of the model representing natural decay of activity/interest
  repulsion-movements

end

to attraction-movements
  ;; Movements of agents toward center
  ;; For each link breed, weighted by number of links and their recent weights
  ask turtles [

    let linkbreeds (list)

    ;; Target attraction movements
    while [any? my-in-links with [ not member? breed linkbreeds ]] [
      ask one-of my-in-links with [ not member? breed linkbreeds ] [
        set linkbreeds lput breed linkbreeds
      ]

      let b last linkbreeds

      if any? my-in-links with [ breed = b and target-attraction > 0] [
        ask one-of my-in-links with [ breed = b and target-attraction > 0] [
          if random-float 1 < count [ my-in-links with [breed = b and recent-weight > 0] ] of myself * recent-weight * target-attraction [
            move-towards-center myself
          ]
        ]
      ]
    ]

    ;; Origin attraction movements
    while [any? my-out-links with [ not member? breed linkbreeds ]] [
      ask one-of my-out-links with [ not member? breed linkbreeds ] [
        set linkbreeds lput breed linkbreeds
      ]

      let b last linkbreeds

      if any? my-out-links with [ breed = b and origin-attraction > 0] [
        ask one-of my-out-links with [ breed = b and origin-attraction > 0] [
          if random-float 1 < count [ my-out-links with [breed = b and recent-weight > 0] ] of myself * recent-weight * origin-attraction [
            move-towards-center myself
          ]
        ]
      ]
    ]
  ]

end

to repulsion-movements
  ;; Movement toward edges of the model.
  ;; Repulsion strength depends on distance to center.
  ask turtles with [random-float 1 < ((25 - abs xcor) / 2.5 * repulsion)] [
    move-towards-edges self
  ]
end

to links-decay
  ask links with [ recent-weight > 0 and random-float 1 < forget-recent-weight-prob ] [
    decrease-weight
  ]

  ask links with [ recent-weight = 0 and random-float 1 < forget-link-prob ] [
    die
  ]
end

to move-towards-edges [ agent ]
  ask agent [
    if xcor < 0 and xcor > -25 [
      ;; 'carefully' needed to prevent tied agents to move outside the model
      ;; for instance, tasks tied to projects
      carefully [ set xcor xcor - 1 ] []
    ]
    if xcor > 0 and xcor < 25 [
      carefully [ set xcor xcor + 1 ] []
    ]
  ]
end

to move-towards-center [ agent ]
  ask agent [
    if xcor < -1 [
      if not any? my-links with [tie-mode = "fixed" and [ xcor ] of other-end >= -1 ] [
        set xcor xcor + 1
      ]
    ]
    if xcor > 1 [
      if not any? my-links with [tie-mode = "fixed" and [ xcor ] of other-end <= 1 ] [
        set xcor xcor - 1
      ]
    ]
  ]
end

;; Link method to increase current weight
to increase-weight

  set total-weight total-weight + 1
  set recent-weight min (list max-recent-weight (recent-weight + 1 ))

  ;; make active links visible
  if hidden? [
     if (breed = commonertasklinks and not hide-commonertasklinks?) [
       set hidden? false
     ]
     if (breed = consumerlinks and not hide-consumerlinks?) [
       set hidden? false
     ]
     if (breed = commonerprojectlinks and not hide-commonerprojectlinks?) [
       set hidden? false
     ]
     if (breed != commonertasklinks and breed != consumerlinks and breed != commonerprojectlinks) [
       set hidden? false
     ]
  ]

end

;; Link method to decrease current weight
to decrease-weight

  set recent-weight max (list 0 (recent-weight - 1 ))
    ;; hide
    if recent-weight = 0 [
      set hidden? true
    ]
end

to-report project-friends
  let me myself
  report count commonerprojectlink-neighbors with [friendlink-neighbor? me]
end

to-report find-project-prob
  let friends-effect project-friends * find-project-friends-mult
  report (min (list max-find-level ((1 + friends-effect) / (1 + distance myself * find-project-dist-mult))))
end

to find-project
  if any? projects with [not member? self commonerprojectlink-neighbors] [
    ask one-of projects with [not member? self commonerprojectlink-neighbors] [
      if random-float 1 < find-project-prob [
        create-commonerprojectlink-with myself [set-commonerprojectlink-parameters]
      ]
    ]
  ]
end

;;
to-report task-friends
  let me myself
  report in-commonertasklink-neighbors with [friendlink-neighbor? me]
end

to-report find-task-prob
  let friends-effect count task-friends * find-task-friends-mult
  report (min (list max-find-level ((1 + friends-effect) / (( 1 + distance myself * find-task-dist-mult)))))
end


to find-task
  let task-of-my-projects
    turtle-set [ projecttasklink-neighbors ] of commonerprojectlink-neighbors

  if any? task-of-my-projects [
    ask one-of task-of-my-projects [
      if random-float 1 < find-task-prob [
        create-commonertasklink-from myself [ set-commonertasklink-parameters ]
      ]
    ]
  ]
end

to-report contrib-prob
  ;; returns the probability of the contribution, depending on total contributions, number of friends, recent contribution
  let tasklinks [ my-out-commonertasklinks ] of myself


  let total-contrib-effect 1 + ln (1 + [total-contribs] of myself) * contrib-total-weight-mult
  let recent-contrib-effect 1 + ln (1 + sum [recent-weight] of [my-out-commonertasklinks] of myself) * contrib-recent-weight-mult
  let friend-task-effect 1 + ln (1 + count task-friends) * contrib-friend-task-effect
  let total-contrib-to-task-effect 1 + ln ( 1 + [total-weight] of in-commonertasklink-from myself)


  let prob total-contrib-effect  * recent-contrib-effect * friend-task-effect * total-contrib-to-task-effect / (1 + distance myself * 40 )

  ;; Maxium contribution prob is 0.8
  report min (list 0.8 prob)
end

to-report contrib-size
  report 1
end

;; TODO skills affect probability of contribution
to contribute
  ;; A comoner may contribute to one of its tasks depending on distance, friends, recent contributions and total contribution
  if any? out-commonertasklink-neighbors [
    ask out-commonertasklink-neighbors [
      if random-float 1 < contrib-prob [

        ;; Representing a contribution happend
        ask in-commonertasklink-from myself [
          increase-weight
        ]

        ask projecttasklink-neighbors [
          if not commonerprojectlink-neighbor? myself [
            create-commonerprojectlink-with myself [ set-commonerprojectlink-parameters ]
          ]
          ask commonerprojectlink-with myself [
            increase-weight
          ]
        ]
        ask myself [
          set total-contribs total-contribs + 1
        ]

        ;; decreasing the ammount of work to be done in the task
        set time-required time-required - contrib-size
        if time-required < 0 [

          ;; with some probability, a task generates other task when finished
          if random-float 1 < task-hatch-task-prob [
            ;; create another task in the same project
            ask projecttasklink-neighbors [
              hatch-t4sks 1 [
                set-task-parameters
              ]
            ]
          ]

          ;; if the project does not have more tasks, it dies and improve its product by changing its x coordinates
          ask projecttasklink-neighbors [

            if count my-projecttasklinks = 1 [
              ;; improve product if exists
              ifelse any? projectproductlink-neighbors [
                ask projectproductlink-neighbors [
                  ;; improve
                  set xcor min(list -1 (xcor + random 25))
                ]
              ]
              ;; if the project is not linked to a product, it creates a new one
              [
                hatch-products 1 [
                  set interest [interest] of myself
                  set xcor -25 + random 25
                  set ycor -25 + interest
                  set-product-parameters
                ]
              ]
              die ;; project dying
            ]
          ]
          die ;;task dying
        ]
      ]
    ]
  ]
end

to-report find-product-prob
  report min (list max-find-level (1 / (1 + distance myself * find-product-dist-mult)))
end

to find-product
  ;; find product probability based on distance to the product
  ask one-of products with [not member? self out-consumerlink-neighbors] [
    if random-float 1 < find-product-prob [
      create-consumerlink-from myself [set-consumerlink-parameters]
    ]
  ]
end

to-report find-friend-prob
  ;; the probability of finding a friend depends on the ammount of recent contribution done to the task
  report find-friend-mult * recent-weight
end

to find-friends
  ;; With some probability set in the parameters,
  ;; create a friendship relationships with other commoners contributing to the same task

  let me self

  ;; contribs are the active task links
  let contribs my-out-commonertasklinks with [ recent-weight > 0 ]

  if count contribs > 0 [
    ;; pick a random active task link
    ask one-of contribs [
      if random-float 1 < min (list max-find-level find-friend-prob) [
        ;; ask the task
        ask other-end [
          ;; pick other contributor with recent contributions
          if any? my-in-commonertasklinks with [recent-weight > 0 and other-end != me] [
            ask one-of my-in-commonertasklinks with [recent-weight > 0 and other-end != me] [
              ;; ask the other contributor to become my friend
              ask other-end [
                ;; If not a friend, create aa frienship
                ifelse not friendlink-neighbor? me [
                  create-friendlink-with me [set-friendlink-parameters]
                ]
                ;; If already friends, increase friendship weight
                [
                  ask friendlink-with me [
                    increase-weight
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
end

to-report consume-prob
  ;; probability of consuming a product, depends on the recent conspumtion of any product and the distance to the product
  let current-consumption count my-out-consumerlinks * [recent-weight] of in-consumerlink-from myself

  report min (list 0.8 ((1 + current-consumption) / ( 1 + distance myself * consume-dist-mult) ))
end

to consume
  if any? out-consumerlink-neighbors [
    ask one-of out-consumerlink-neighbors [
      if random-float 1 < consume-prob [
        ask in-consumerlink-from myself [
          increase-weight
        ]
      ]
    ]
  ]
end

to recommend
  ;; This is the way we include commoners in the model
  ;; a commoner recommends a product to a new commoner
  ;; with a probability that depends on the recent consumption activity of that product by that commoner
  ;; and the distance of the product to the center of the model

  if any? my-out-consumerlinks [
    ask one-of my-out-consumerlinks [
      let product other-end
      ;; distance of the product to the center of the model
      let dist 25 + [ xcor ] of product
      if random-float 1 < min (list max-find-level (recent-weight / ( (1 + dist) * recommend-dist-mult))) [
        ask myself [
          hatch-commoners 1 [
            ;;create-friendlink-with myself [set-friendlink-parameters]
            set-commoner-parameters
            ;; commoners appear at the edge of the model
            set xcor 25
            ;; kill the default link to the closest product that the commoner creates
            ask my-out-consumerlinks [ die ]
            ;; create a link to the recommended product
            create-consumerlink-to product [set-consumerlink-parameters]
          ]
        ]
      ]
    ]
  ]
end

to-report propose-project-prob
  ;; The probability of a commoner proposing a new project depends on its recent contribution history and total contribution history
  let total-contrib-effect 1 + ln (1 + [total-contribs] of myself)  * prop-project-total-contrib-mult
  let recent-contrib-effect 1 + ln (1 + sum [recent-weight] of [my-out-commonertasklinks] of myself) * prop-project-recent-contrib-mult

  report 0.00001 * total-contrib-effect * recent-contrib-effect

end

to propose-project
  ;; a commoner may hatch a project
  if any? my-out-commonertasklinks [
    ask one-of my-out-commonertasklinks [
      if random-float 1 < min (list max-find-level  propose-project-prob) [
        ask myself [
          hatch-projects 1 [
            set xcor -1 * (random 20) - 5
            set ycor -25 + interest
            carefully [set ycor ycor + random 10 - 5][]
            set-project-parameters

            let my-product one-of [ projectproductlink-neighbors ] of myself

            ;; Half of the new projects are related to an existing product, the other half will create a new product when finished
            if my-product != nobody and random-float 1 < 0.5 [
              create-projectproductlink-with my-product [ set color red ]
            ]
          ]
        ]
      ]
    ]
  ]
end

to leave

  ;; a commoner leaves the community if it has no recent consumption or contributing activity with a small chance
  if not any? my-out-consumerlinks and not any? my-out-commonertasklinks [
    if random-float 1 < 0.01 [
      set dead-commoners-contribs lput total-contribs dead-commoners-contribs
      die
    ]
  ]


  ;; Thre is a small chance for all commoners to leave even if they are currently active
  if random-float 1 < leave-prob [
    die
  ]

end

to product-death
  ask products with [ not any? my-in-consumerlinks ][
     if random-float 1 < (1 / consume-long-forg) [
       die
     ]
  ]
end

to project-death
    ask projects with [ not any? my-commonerprojectlinks ][
     if random-float 1 < (1 / project-long-forg) [
       ask projecttasklink-neighbors [
         die
       ]
       die
     ]
  ]
end


;; Based on update-lorenz-and-gini method from Wilensky, U. (1998). NetLogo Wealth Distribution model. http://ccl.northwestern.edu/netlogo/models/WealthDistribution. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.
to update-gini
  let sum-contribs sum contrib-distrib
  let contrib-sum-so-far 0
  set gini-index-reserve 0
  let num-people length contrib-distrib
  let index num-people - 1

  ;; (see the Info tab for a description of the curve and measure)
  repeat num-people [
    set contrib-sum-so-far (contrib-sum-so-far + item index contrib-distrib)
    set index (index - 1)
    set gini-index-reserve
    gini-index-reserve +
    (index / num-people) -
    (contrib-sum-so-far / sum-contribs)
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
205
15
651
482
25
25
8.55
1
10
1
1
1
0
0
0
1
-25
25
-25
25
0
0
1
ticks
30.0

BUTTON
20
20
93
53
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
20
160
187
205
number-of-products
number-of-products
"one" "few" "many"
1

SLIDER
20
250
185
283
num-interest-categories
num-interest-categories
0
50
50
1
1
NIL
HORIZONTAL

SLIDER
20
210
187
243
initial-projects
initial-projects
0
100
7
1
1
NIL
HORIZONTAL

SLIDER
20
330
185
363
mean-time-required
mean-time-required
0
100
19
1
1
NIL
HORIZONTAL

SLIDER
20
290
185
323
num-skills
num-skills
0
100
25
1
1
NIL
HORIZONTAL

SLIDER
20
120
187
153
commoners-num
commoners-num
0
500
250
1
1
NIL
HORIZONTAL

BUTTON
100
60
177
93
go once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
100
20
175
53
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
1115
405
1208
438
commoner-task-attraction-prob
commoner-task-attraction-prob
0
1
0.9
0.02
1
NIL
HORIZONTAL

SLIDER
760
325
852
358
commoner-repulsion-prob
commoner-repulsion-prob
0
0.2
0.06
0.01
1
NIL
HORIZONTAL

SLIDER
1115
365
1208
398
commoner-product-attraction-prob
commoner-product-attraction-prob
0
1
0.9
0.02
1
NIL
HORIZONTAL

SLIDER
760
365
853
398
product-repulsion-prob
product-repulsion-prob
0
0.2
0.1
0.005
1
NIL
HORIZONTAL

SLIDER
760
405
853
438
project-repulsion-prob
project-repulsion-prob
0
0.1
0.01
0.01
1
NIL
HORIZONTAL

SLIDER
1019
405
1112
438
task-commoner-attraction-prob
task-commoner-attraction-prob
0
1
0.59
0.01
1
NIL
HORIZONTAL

PLOT
635
485
935
605
Activity
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"contribution" 1.0 0 -10899396 true "" "plot sum [recent-weight] of commonertasklinks"
"consumption" 1.0 0 -955883 true "" "plot sum [recent-weight] of consumerlinks"

PLOT
1250
485
1545
605
Agent count
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"tasks" 1.0 0 -10899396 true "" "plot count t4sks"
"project" 1.0 0 -14333415 true "" "plot count projects"
"commoners" 1.0 0 -13345367 true "" "plot count commoners"
"products" 1.0 0 -955883 true "" "plot count products"

PLOT
935
485
1250
605
Links count
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"project-links" 1.0 0 -14333415 true "" "plot count commonerprojectlinks"
"consume-links" 1.0 0 -955883 true "" "plot count consumerlinks"
"friend-links" 1.0 0 -1184463 true "" "plot count friendlinks"
"task-links" 1.0 0 -10899396 true "" "plot count commonertasklinks"

SLIDER
1020
365
1113
398
product-commoner-attraction-prob
product-commoner-attraction-prob
0
1
0.3
0.02
1
NIL
HORIZONTAL

SLIDER
1240
70
1332
103
find-project-dist-mult
find-project-dist-mult
0
20
6.5
0.1
1
NIL
HORIZONTAL

SLIDER
1145
70
1237
103
find-product-dist-mult
find-product-dist-mult
0
5
0.5
0.1
1
NIL
HORIZONTAL

SLIDER
1240
185
1332
218
find-project-friends-mult
find-project-friends-mult
0
10
10
0.2
1
NIL
HORIZONTAL

SLIDER
1335
185
1427
218
find-task-friends-mult
find-task-friends-mult
0
10
10
0.1
1
NIL
HORIZONTAL

SLIDER
1335
70
1427
103
find-task-dist-mult
find-task-dist-mult
0
5
1
0.1
1
NIL
HORIZONTAL

SLIDER
860
145
952
178
contrib-recent-weight-mult
contrib-recent-weight-mult
1
10
4.5
0.1
1
NIL
HORIZONTAL

SLIDER
20
410
185
443
max-find-level
max-find-level
0
1
0.2
0.05
1
NIL
HORIZONTAL

SLIDER
1430
145
1523
178
find-friend-mult
find-friend-mult
0
1
0.7
0.05
1
NIL
HORIZONTAL

SLIDER
860
105
952
138
contrib-total-weight-mult
contrib-total-weight-mult
1
10
4.5
0.1
1
NIL
HORIZONTAL

SLIDER
860
185
952
218
contrib-friend-task-effect
contrib-friend-task-effect
1
10
4.5
0.1
1
NIL
HORIZONTAL

SLIDER
955
70
1047
103
recommend-dist-mult
recommend-dist-mult
0
10
2.9
0.1
1
NIL
HORIZONTAL

SLIDER
20
370
185
403
task-hatch-task-prob
task-hatch-task-prob
0
1
0.8
0.1
1
NIL
HORIZONTAL

SLIDER
765
70
857
103
consume-dist-mult
consume-dist-mult
0
10
0.4
0.1
1
NIL
HORIZONTAL

SLIDER
1050
105
1142
138
prop-project-total-contrib-mult
prop-project-total-contrib-mult
1
10
10
0.1
1
NIL
HORIZONTAL

SLIDER
1050
145
1142
178
prop-project-recent-contrib-mult
prop-project-recent-contrib-mult
1
10
10
0.1
1
NIL
HORIZONTAL

PLOT
205
485
405
605
Contrib Distribution
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -10899396 true "" "plot-pen-reset\nforeach contrib-distrib plot"

SWITCH
15
510
195
543
hide-consumerlinks?
hide-consumerlinks?
0
1
-1000

SWITCH
15
545
195
578
hide-commonertasklinks?
hide-commonertasklinks?
1
1
-1000

SLIDER
20
445
185
478
leave-prob
leave-prob
0
0.005
1.0E-4
0.00001
1
NIL
HORIZONTAL

TEXTBOX
765
45
825
63
consume
12
0.0
1

TEXTBOX
860
45
935
71
contribute
12
0.0
1

TEXTBOX
660
80
735
98
Distance
12
0.0
1

TEXTBOX
660
160
810
178
recent contrib
12
0.0
1

TEXTBOX
660
115
810
133
total-contrib\n
12
0.0
1

TEXTBOX
660
200
810
218
friends
12
0.0
1

TEXTBOX
1145
45
1225
63
find-product
12
0.0
1

TEXTBOX
1240
45
1390
63
find-project\n
12
0.0
1

TEXTBOX
1335
45
1440
63
find-task
12
0.0
1

TEXTBOX
955
45
1105
63
recommend
12
0.0
1

TEXTBOX
1055
45
1205
71
project prop.
12
0.0
1

TEXTBOX
665
280
815
298
-- MOVEMENT --
12
0.0
1

TEXTBOX
665
305
860
323
-------- Repulsion: ----------------
12
0.0
1

TEXTBOX
670
330
745
348
Commoners
12
0.0
1

TEXTBOX
671
414
731
437
Projects
12
0.0
1

TEXTBOX
672
375
737
398
Products
12
0.0
1

TEXTBOX
660
215
1535
234
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
12
0.0
1

TEXTBOX
889
370
983
393
consume links
12
0.0
1

TEXTBOX
893
414
1081
437
contrib links
12
0.0
1

TEXTBOX
1018
337
1091
360
commoner
12
0.0
1

TEXTBOX
1115
335
1303
358
product/project
12
0.0
1

TEXTBOX
894
305
1201
325
-------- Attraction: --------------------------------------
12
0.0
1

TEXTBOX
660
13
848
36
-- ACTIVITIES --
12
0.0
1

TEXTBOX
1434
43
1622
66
find-friend
12
0.0
1

TEXTBOX
660
95
1550
113
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------\n
12
0.0
1

TEXTBOX
660
135
1525
153
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
12
0.0
1

TEXTBOX
660
175
1545
193
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
12
0.0
1

TEXTBOX
20
485
215
526
Hide links:
12
0.0
1

PLOT
405
485
635
605
Gini
NIL
NIL
0.0
10.0
0.0
1.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot (gini-index-reserve / length contrib-distrib) / 0.5"

SLIDER
1330
325
1422
358
friends-recent-forg
friends-recent-forg
0
30
14
1
1
NIL
HORIZONTAL

SLIDER
1425
325
1517
358
friends-long-forg
friends-long-forg
0
100
100
1
1
NIL
HORIZONTAL

SLIDER
1330
365
1422
398
consume-recent-forg
consume-recent-forg
0
30
7
1
1
NIL
HORIZONTAL

SLIDER
1425
365
1517
398
consume-long-forg
consume-long-forg
0
100
30
1
1
NIL
HORIZONTAL

SLIDER
1330
405
1422
438
contrib-recent-forg
contrib-recent-forg
0
30
7
1
1
NIL
HORIZONTAL

SLIDER
1425
405
1517
438
contrib-long-forg
contrib-long-forg
0
100
30
1
1
NIL
HORIZONTAL

SLIDER
1330
445
1422
478
project-recent-forg
project-recent-forg
0
30
7
1
1
NIL
HORIZONTAL

SLIDER
1425
445
1517
478
project-long-forg
project-long-forg
0
100
30
1
1
NIL
HORIZONTAL

SWITCH
15
580
195
613
hide-commonerprojectlinks?
hide-commonerprojectlinks?
1
1
-1000

@#$#@#$#@
Developed by Dr Peter Barbrook-Johnson and Antonio Tenorio-Fornés 2017.

## INTRODUCTION

This model is an implementation of a novel conceptual framework - the ‘Commoners Framework’ - to be used when conceptualising and modelling the behaviour of commons-based peer production (CBPP) communities.

The most up to date version of the model can be accessed at https://github.com/P2Pvalue/CommonersFramework.

**Purpose and development**

The Commoners Framework, and by extension, this model, can be used to represent the behaviour and operation of a wide-range of CBPP communities, and similar organisations (such as those that make use of volunteers). It represents the processes behind individuals’ decisions to contribute to, enter or exit, or make ‘friends’ in, communities. Through this representation of individuals’ behaviour, the framework aims to account for patterns of behaviour observed at the community level. For example, the distribution of participation rates among individuals, which often follows a power law distribution, also known as the ‘1-9-90 rule’; where 1% of the community – the core members – perform most of the work, 9% of the community – the contributors – occasionally contribute and 90% of the community – the users or consumers - use the commons without directly contributing to produce it. The framework was developed based on recent empirical findings on behaviour in a wide variety of communities and was refined using the structural rigour imposed when building an agent-based model (ABM).

**Logic of model**

The focus of the model is Commoners. Commoners is the name given to individuals in a community – both those that contribute, and those that consume the product(s) of a community. The core productive activity of any Commoner is to find tasks in the community, and contribute to them. Their ability to, and likelihood of, contributing will depend on their time available (a resource Commoners have), interests (a Commoner and task parameter which should match), and skill types (a Commoner and task parameter which should match). Commoners may stay in a community, only consuming but not contributing, if no tasks meet their interest or skills. Commoners may make ‘friends’ with others contributing to the same tasks. Having friends increases the chance of finding tasks and contributing. Friends may be lost over time with a certain probability. Commoners’ probability of leaving a community decreases as they make more contributions and have more friends. Contributions improve the quality, or number, of products in the community. More consumption of products increases the probability of existing consumers of these products continuing to consume them, and new Commoners entering the community.


## DETAILS

**Products and Projects**

On the left hand side of the model, goods produced by the community, called "Products", and the projects to produce or improve them, called "Projects" are displayed. Products are the 'box' icons, and Projects are the 'target' icons. Consumption activity (i.e. others consuming a Product) makes Products more appealing to Commoners - this is represented by bringing the Product towards the center of the model. Production activity (i.e. contributions by Commoners) in the "Tasks" of a Project also makes the Project more appealing to contributors, this behaviour is also represented by bringing the Project towards the center. Note, contributions to Projects is made via the multiple Tasks within them (displayed by the green dots inside the target icon).

**Commoners**

Commoners are positioned in the right hand side of the model. The chances of discovering any elements on the left hand side of the model (i.e. Products/Projects/Tasks) depends on the distance between those elements and the Commoner. Not only does consumption and production activity make the Products and Projects more appealing (thus bringing them towards the center) but it also makes the Commoners more likely to engage in the community, thus these activities attracts the Commoners towards the center of the model.

Commoners' recent history of consumption and contribution also affects the chances of current contribution or consumption. Consumption of contrbutions are represented by links, and each consumption/prodution link has a recent weight that accounts for the recent activity, if the weight is 0, the link will be forgoten with some likelihood.

Friendship among Commoners is created when Commoners work in the same task. Having friends increases the likelihood of finding Tasks and contributing to them (if friends are working on them).

**Decay**

The model also include forces that bring the elements towards the edges of the model, thus decreasing their chances to be found or active (i.e. representing some natural decay in engagement over time). This forces are stronger near the center, where elements have to be considerably active to remain.


## THE INTERFACE

*Please note, it is expected only those with at least a basic familiarty of NetLogo will use this model.*

In the upper left corner of the interface, the buttons setup and go will setup and run the model respectively.

Sliders at the left of the model control the number of each of the elements of the model at the start the simulation.

Vertical sliders at the right of the world view set up parameters for the 'find operations' (i.e. find Products, Projects, Tasks and friends) and how much having friends affects these activities. They also set up how much distance is taken into account for the creation of new Products or the arrival of new Commoners.

Horizontal sliders below set the attraction and repulsion of the elements towards the center (e.g. how much contributing to a Task makes a Commoner move towards the center).

Finally, three horizontal sliders at the bottom set how much having friends, having an active recent contribution history, or how many tasks the commoner has found, affects the likelihood of the Commoner contributing.


## PLAYING WITH THE MODEL

The model tries to represent the behaviour in collaborative communities, where contributions and participation often follow a power law distribution where 1% of the community does most of the work, 9% contributes occasionally and the rest only consumes.

Try setting the repulsion, attraction and find probabilities in the model to represent this behaviour. Too much attraction or too little repulsion will make all the elements come towards the center. Few chances of finding tasks and contributing will make the Commoners leave the model, due to their small involvement.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.3
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="first" repetitions="10" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="product-commoner-attraction-prob">
      <value value="0.2"/>
      <value value="0.3"/>
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recommend-dist-mult">
      <value value="1.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-skills">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-total-weight-mult">
      <value value="6.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-dist-mult">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-commonertasklinks?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-recent-weight-mult">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-project-recent-contrib-mult">
      <value value="8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-project-friends-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-repulsion-prob">
      <value value="0.006"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-friend-task-effect">
      <value value="5.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-task-friends-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="task-commoner-attraction-prob">
      <value value="0.91"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-time-required">
      <value value="19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-task-dist-mult">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-project-dist-mult">
      <value value="5.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="leave-prob">
      <value value="1.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-of-products">
      <value value="&quot;few&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-friend-mult">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-consumerlinks?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-projects">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="product-repulsion-prob">
      <value value="0.03"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoners-num">
      <value value="365"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="friends-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-product-dist-mult">
      <value value="0.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="task-hatch-task-prob">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-repulsion-prob">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="friends-long-forg">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-interest-categories">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-find-level">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-long-forg">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-project-total-contrib-mult">
      <value value="8.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-recent-forg">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-task-attraction-prob">
      <value value="0.08"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-product-attraction-prob">
      <value value="0.6"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensit-product-commoner-attraction-prob" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>sum sentence contrib-distrib dead-commoners-contribs</metric>
    <metric>(gini-index-reserve / length contrib-distrib) / 0.5</metric>
    <metric>sum [recent-weight] of consumerlinks</metric>
    <metric>sum [recent-weight] of commonertasklinks</metric>
    <metric>count commoners</metric>
    <metric>count projects</metric>
    <metric>count t4sks</metric>
    <metric>count products</metric>
    <metric>count commonerprojectlinks</metric>
    <metric>count commonertasklinks</metric>
    <metric>count consumerlinks</metric>
    <metric>count friendlinks</metric>
    <enumeratedValueSet variable="product-commoner-attraction-prob">
      <value value="0.1"/>
      <value value="0.3"/>
      <value value="0.5"/>
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recommend-dist-mult">
      <value value="2.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-skills">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-total-weight-mult">
      <value value="4.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-dist-mult">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-commonertasklinks?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-recent-weight-mult">
      <value value="4.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-project-recent-contrib-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-project-friends-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-repulsion-prob">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-friend-task-effect">
      <value value="4.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-task-friends-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="task-commoner-attraction-prob">
      <value value="0.59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-time-required">
      <value value="19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-task-dist-mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-project-dist-mult">
      <value value="6.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="leave-prob">
      <value value="1.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-of-products">
      <value value="&quot;few&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-friend-mult">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-consumerlinks?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-projects">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="product-repulsion-prob">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoners-num">
      <value value="250"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="friends-recent-forg">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-product-dist-mult">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="task-hatch-task-prob">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-repulsion-prob">
      <value value="0.06"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="friends-long-forg">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-interest-categories">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-find-level">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-project-total-contrib-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-task-attraction-prob">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-product-attraction-prob">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensit-commoner-product-attraction-prob" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>sum sentence contrib-distrib dead-commoners-contribs</metric>
    <metric>(gini-index-reserve / length contrib-distrib) / 0.5</metric>
    <metric>sum [recent-weight] of consumerlinks</metric>
    <metric>sum [recent-weight] of commonertasklinks</metric>
    <metric>count commoners</metric>
    <metric>count projects</metric>
    <metric>count t4sks</metric>
    <metric>count products</metric>
    <metric>count commonerprojectlinks</metric>
    <metric>count commonertasklinks</metric>
    <metric>count consumerlinks</metric>
    <metric>count friendlinks</metric>
    <enumeratedValueSet variable="product-commoner-attraction-prob">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="recommend-dist-mult">
      <value value="2.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-skills">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-total-weight-mult">
      <value value="4.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-dist-mult">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-commonertasklinks?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-recent-weight-mult">
      <value value="4.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-project-recent-contrib-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-project-friends-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-repulsion-prob">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-friend-task-effect">
      <value value="4.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-task-friends-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="task-commoner-attraction-prob">
      <value value="0.59"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mean-time-required">
      <value value="19"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-task-dist-mult">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-project-dist-mult">
      <value value="6.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="leave-prob">
      <value value="1.0E-4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="number-of-products">
      <value value="&quot;few&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-friend-mult">
      <value value="0.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hide-consumerlinks?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-projects">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="contrib-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="product-repulsion-prob">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoners-num">
      <value value="250"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="friends-recent-forg">
      <value value="14"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="find-product-dist-mult">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="task-hatch-task-prob">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-repulsion-prob">
      <value value="0.06"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="friends-long-forg">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-interest-categories">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-find-level">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-long-forg">
      <value value="30"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-project-total-contrib-mult">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="consume-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="project-recent-forg">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-task-attraction-prob">
      <value value="0.68"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="commoner-product-attraction-prob">
      <value value="0.1"/>
      <value value="0.3"/>
      <value value="0.5"/>
      <value value="0.9"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="sensit-commoner-task-attraction-prob" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1000"/>
    <metric>sum sentence contrib-distrib dead-commoners-contribs</metric>
    <metric>(gini-index-reserve / length contrib-distrib) / 0.5</metric>
    <metric>sum [recent-weight] of consumerlinks</metric>
    <metric>sum [recent-weight] of commonertasklinks</metric>
    <metric>count commoners</metric>
    <metric>count projects</metric>
    <metric>count t4sks</metric>
    <metric>count products</metric>
    <metric>count commonerprojectlinks</metric>
    <metric>count commonertasklinks</metric>
    <metric>count consumerlinks</metric>
    <metric>count friendlinks</metric>
    <enumeratedValueSet variable="commoner-task-attraction-prob">
      <value value="0.1"/>
      <value value="0.3"/>
      <value value="0.5"/>
      <value value="0.9"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
1
@#$#@#$#@
