; Developed by Dr Peter Barbrook-Johnson and Antonio Tenorio-Fornés

; Comments welcome - emails: p.barbrook-johnson@psi.org.uk, antoniotenorio@ucm.es

extensions [network nw]
globals [

  initial-products ;; number of initial products
]

breed [commoners commoner]
breed [products product]
breed [projects project]
breed [t4sks t4sk]

undirected-link-breed [projecttasklinks projecttasklink]
directed-link-breed [commonertasklinks commonertasklink]
undirected-link-breed [commonerprojectlinks commonerprojectlink]
undirected-link-breed [friendlinks friendlink]
;; commoner to product link
directed-link-breed [consumerlinks consumerlink]
undirected-link-breed [projectproductlinks projectproductlink]

turtles-own [
  repulsion
  age
]

links-own [

  total-weight

  recent-weight
  max-recent-weight
  forget-recent-weight-prob ;; TODO call it forgetfulness?
  forget-link-prob

  in-attraction
  out-attraction

  link-age
]

commoners-own [
  time
  skills
  interest
]

projects-own [
  interest
]

t4sks-own [
  skill
  time-required
]

products-own [
  interest
]

to setup
  clear-all
  reset-ticks

   ;; colour lines to mark projects and products spaces
   ask patches with [pxcor = 0] [set pcolor white]

   create-existing-products
   create-existing-projects
   create-existing-commoners

end


to create-existing-products

  if number-of-products = "one" [ set initial-products 1 ]
  if number-of-products = "few" [ set initial-products random 5 + 2 ]
  if number-of-products = "many" [ set initial-products random 100  + 5]

  create-products initial-products [
    set interest random num-interest-categories
    set xcor -25 + random 25
    set ycor -25 + interest
    create-product
]

end

to create-product
  ;; Style
  set size 2
  set color orange
  set shape "box"
  ;;

  set repulsion product-repulsion-prob

end

to create-existing-projects
  create-projects initial-projects [

    set interest random num-interest-categories

    create-project

    let my-product min-one-of products [ distance myself ]
    create-projectproductlink-with my-product [ set color red ]
  ]
end

to create-project

    ;; Style
    set size 2.5
    set color green - 2
    set shape "target"
    ;;

    set xcor -1 * (random 20) - 5
    set ycor -25 + interest


    set repulsion project-repulsion-prob

    let num-tasks random 10 + 2 ;; TODO take it to configuration and normal distribution for num-tasks
    set age 0

    hatch-t4sks num-tasks [
      create-task
    ]

end

to create-task

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

  ;; link
  create-projecttasklink-with myself [tie]

  t4sk-set-skill

  set age 0
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

  ask commoners with [count my-friendlinks = 1] [
    ask one-of my-friendlinks [
      die
    ]
  ]

  ask commoners [
    create-commoner
  ]

  ask friendlinks [
    create-friendlink
  ]

  ask commoners [
    let friends count my-friendlinks
    set xcor 5 * ( 5 - min (list 4 friends) )
  ]

end

to create-commonertasklink
  set color green
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / 7 ;; TODO 7 as a param
  set forget-link-prob 1 / 120 ;; TODO 120 as a param
  set out-attraction commoner-task-attraction-prob
  set in-attraction task-commoner-attraction-prob
end

to create-consumerlink
  set color orange
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / 7 ;; TODO 7 as a param
  set forget-link-prob 1 / 30 ;; TODO 30 as a param
  set in-attraction product-commoner-attraction-prob
  set out-attraction commoner-product-attraction-prob
end

to create-commonerprojectlink
  set color green + 3
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / 7 ;; TODO 7 as a param
  set forget-link-prob 1 / 30 ;; TODO 30 as a param
end

to create-friendlink
  set color yellow + 3
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / 7 ;; TODO 30 as a param
  set forget-link-prob 1 / 120 ;; TODO 120 as a param
end

to create-commoner
  set interest random num-interest-categories
  set xcor random 25 + 1
  set ycor -25 + interest
  set size 1.5
  set color blue
  set repulsion commoner-repulsion-prob
  ;; commoners consume a community product
  create-consumerlink-to min-one-of products [ distance myself ] [create-consumerlink]

  ;; 3 random skills per commoner
  set skills (n-of 3 (n-values num-skills [?]))

  ;; An initial project per commoner
  let product-projects turtle-set [ projectproductlink-neighbors ] of out-consumerlink-neighbors
  ifelse any? product-projects [
    create-commonerprojectlink-with one-of product-projects [create-commonerprojectlink]
  ] [
    create-commonerprojectlink-with min-one-of projects [ distance myself ] [create-commonerprojectlink]
  ]

  let num-friends count my-friendlinks
  ;; 90's do not contribute
  if num-friends = 0 [
    ask my-out-commonertasklinks [die]
    ask my-commonerprojectlinks [die]
  ]

  ;; Create links with tasks of my projects with my skills...
  let skilled-tasks (turtle-set [ projecttasklink-neighbors ] of commonerprojectlink-neighbors) with
    [ member? skill [ skills ] of myself ]

  create-commonertasklinks-to n-of min (list count skilled-tasks num-friends) skilled-tasks [
    create-commonertasklink
    set recent-weight random min (list 4 num-friends) + random 1
  ]

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
    recomend

    ;; create project
    propose-project

    ;; leave community
    leave

  ]

  ask links with [ recent-weight > 0 and random-float 1 < forget-recent-weight-prob ] [
    decrease-weight
  ]

  ask links with [ recent-weight = 0 and random-float 1 < forget-link-prob ] [
     die ;; TODO maybe record total history of this links that died not to lose important information
  ]

  ask products [
    let current-value sum [recent-weight] of my-in-consumerlinks
    set label current-value
  ]

  ;; Movements of agents toward center
  ;; For each link breed, weighted by number of links and their recent weights
  ask turtles [

    let linkbreeds (list)

    while [any? my-in-links with [ not member? breed linkbreeds ]] [
      ask one-of my-in-links with [ not member? breed linkbreeds ] [
        set linkbreeds lput breed linkbreeds
      ]

      let b last linkbreeds

      if any? my-in-links with [ breed = b and in-attraction > 0] [
        ask one-of my-in-links with [ breed = b and in-attraction > 0] [
          if random-float 1 < count [ my-in-links with [breed = b and recent-weight > 0] ] of myself * recent-weight * in-attraction [
            move-towards-center myself
          ]
        ]
      ]
    ]

    while [any? my-out-links with [ not member? breed linkbreeds ]] [
      ask one-of my-out-links with [ not member? breed linkbreeds ] [
        set linkbreeds lput breed linkbreeds
      ]

      let b last linkbreeds

      if any? my-out-links with [ breed = b and out-attraction > 0] [
        ask one-of my-out-links with [ breed = b and out-attraction > 0] [
          if random-float 1 < count [ my-out-links with [breed = b and recent-weight > 0] ] of myself * recent-weight * out-attraction [
            move-towards-center myself
          ]
        ]
      ]
    ]
  ]

  ;; Movement toward edges of the model.
  ;; Repulsion strength depends on distance to center.
  ask turtles with [random-float 1 < ((25 - abs xcor) / 2.5 * repulsion)] [
    move-towards-edges self
  ]

  tick
end

;; Link method to increase current weight
to increase-weight

  set total-weight total-weight + 1
  set recent-weight min (list max-recent-weight (recent-weight + 1 ))

end

;; Link method to decrease current weight
to decrease-weight

  set recent-weight max (list 0 (recent-weight - 1 ))

end

to-report project-friends
  let me myself
  report commonerprojectlink-neighbors with [friendlink-neighbor? me]
end

to-report find-project-prob
  let friends-effect count project-friends * find-project-friends-mult
  report (min (list max-find-level ((1 + friends-effect) / (distance myself * find-project-dist-mult))))
end

to find-project
  ask one-of projects with [not member? self commonerprojectlink-neighbors] [
    if random-float 1 < find-project-prob [
      create-commonerprojectlink-with myself [create-commonerprojectlink]
    ]
  ]
end

;;
to-report task-friends
  let me myself
  report in-commonertasklink-neighbors with [friendlink-neighbor? me]
end

;; TODO skills and previous contributions
to-report find-task-prob
  let friends-effect count task-friends * find-task-friends-mult
  report (min (list max-find-level ((1 + friends-effect) / (distance myself * find-task-dist-mult))))
end


to find-task
  let task-of-my-projects
    turtle-set [ projecttasklink-neighbors ] of commonerprojectlink-neighbors

  if any? task-of-my-projects [
    ask one-of task-of-my-projects [
      if random-float 1 < find-task-prob [
        create-commonertasklink-from myself [ create-commonertasklink ]
      ]
    ]
  ]
end

to-report contrib-prob
  let tasklinks [ my-out-commonertasklinks ] of myself
  let num-tasks count tasklinks

  let num-tasks-effect 1 + ln (num-tasks) * contrib-num-task-mult
  let recent-contrib-effect 1 + ln (1 + sum ([recent-weight] of tasklinks)) * contrib-recent-weight-mult
  let friend-task-effect 1 + ln (1 + count task-friends) * contrib-friend-task-effect

  ifelse num-tasks = 0 [
    report 0
  ] [
    let prob 0.01 * num-tasks-effect * recent-contrib-effect * friend-task-effect
    report min (list 0.8 prob)
  ]
end

to-report contrib-size
  report 1
end

to contribute
  if any? out-commonertasklink-neighbors [
    ask one-of out-commonertasklink-neighbors [
      if random-float 1 < contrib-prob [

        if sum ([recent-weight] of ([ my-out-commonertasklinks ] of myself)) > 5 [ask myself [set color red]]

        ask myself [
          if color != red [set color pink]
        ]

        ask in-commonertasklink-from myself [
          increase-weight
        ]
        set time-required time-required - contrib-size
        if time-required < 0 [

          ;; with some probability, a task generates other task when finished
          if random-float 1 < task-hatch-task-prob [
            ;; create another task in the same project
            ask projecttasklink-neighbors [
              hatch-t4sks 1 [
                create-task
              ]
            ]
          ]

          ;; if the project does not have more tasks, it dies and improve its product
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
                  create-product
                ]
              ]
              die
            ]
          ]
          die
        ]
      ]
    ]
  ]
end

to-report find-product-prob
  report min (list max-find-level (1 / (distance myself * find-product-dist-mult)))
end

to find-product
  ask one-of products with [not member? self out-consumerlink-neighbors] [
    if random-float 1 < find-product-prob [
      create-consumerlink-from myself [create-consumerlink]
    ]
  ]
end

to find-friends
  let me self
  let contribs my-out-commonertasklinks with [ recent-weight > 0 ]
  if count contribs > 0 [
    ask one-of contribs [
      if random-float 1 < min ( list max-find-level (count contribs * find-friend-prob * recent-weight)) [
        ask other-end [
          if any? my-in-commonertasklinks with [recent-weight > 0 and other-end != me] [
            ask one-of my-in-commonertasklinks with [recent-weight > 0 and other-end != me] [
              ask other-end [
                ifelse not friendlink-neighbor? me [
                  create-friendlink-with me [create-friendlink]
                ] [
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

  let num-prods count my-out-consumerlinks

  ifelse num-prods = 0 [
    report 0
  ] [
    report 0.1 * (1 + sum [recent-weight] of my-out-consumerlinks) ;; TODO constants to params
  ]
end

to consume
  if count out-consumerlink-neighbors > 0 and random-float 1 < consume-prob [
    ask one-of out-consumerlink-neighbors [
      ask in-consumerlink-from myself [
        increase-weight
      ]
    ]
  ]
end

to recomend
  if any? my-out-consumerlinks [
    ask one-of my-out-consumerlinks [
      let product other-end
      let dist 25 - [ xcor ] of product
      if random-float 1 < min (list max-find-level (recent-weight / (dist * recommend-dist-mult))) [
        ask myself [
          hatch-commoners 1 [
            create-friendlink-with myself
            create-commoner
            ask my-out-consumerlinks [ die ]
            create-consumerlink-to product [create-consumerlink]
            set xcor 25
          ]
        ]
      ]
    ]
  ]
end

to propose-project
  if any? my-out-commonertasklinks [
    ask one-of my-out-commonertasklinks [
      if random-float 1 < min (list max-find-level (recent-weight / (link-length  * prop-project-dist-mult))) [
        ask myself [
          hatch-projects 1 [
            set xcor -1 * (random 20) - 5
            set ycor -25 + interest
            create-project

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
  if not any? my-out-consumerlinks and not any? my-out-commonertasklinks [
    if random-float 1 < 0.01 [
      die
    ]
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
@#$#@#$#@
GRAPHICS-WINDOW
210
15
656
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
270
185
303
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
6
1
1
NIL
HORIZONTAL

SLIDER
20
350
185
383
mean-time-required
mean-time-required
0
100
17
1
1
NIL
HORIZONTAL

SLIDER
20
310
185
343
num-skills
num-skills
0
100
30
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
50
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
675
220
997
253
commoner-task-attraction-prob
commoner-task-attraction-prob
0
1
0.98
0.02
1
NIL
HORIZONTAL

SLIDER
675
185
998
218
commoner-repulsion-prob
commoner-repulsion-prob
0
0.2
0.02
0.005
1
NIL
HORIZONTAL

SLIDER
675
255
997
288
commoner-product-attraction-prob
commoner-product-attraction-prob
0
1
0.04
0.02
1
NIL
HORIZONTAL

SLIDER
675
300
996
333
product-repulsion-prob
product-repulsion-prob
0
0.2
0.065
0.005
1
NIL
HORIZONTAL

SLIDER
675
385
996
418
project-repulsion-prob
project-repulsion-prob
0
0.04
0.0040
0.001
1
NIL
HORIZONTAL

SLIDER
675
420
995
453
task-commoner-attraction-prob
task-commoner-attraction-prob
0
1
1
0.01
1
NIL
HORIZONTAL

PLOT
1065
250
1295
370
# Friend Links
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
"default" 1.0 0 -16777216 true "" "plot count friendlinks"

PLOT
1065
370
1295
490
Contribution Activity
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
"default" 1.0 0 -16777216 true "" "plot sum [recent-weight] of commonertasklinks"

PLOT
1065
490
1295
610
# Tasks
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
"default" 1.0 0 -16777216 true "" "plot count t4sks"

PLOT
1065
10
1295
130
# Commoner - Project Links
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
"default" 1.0 0 -16777216 true "" "plot count commonerprojectlinks"

PLOT
1065
130
1295
250
# Commoner Task Links
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
"default" 1.0 0 -16777216 true "" "plot count commonertasklinks"

SLIDER
675
335
995
368
product-commoner-attraction-prob
product-commoner-attraction-prob
0
1
0.06
0.02
1
NIL
HORIZONTAL

SLIDER
730
15
763
168
find-project-dist-mult
find-project-dist-mult
0
5
1.9
0.1
1
NIL
VERTICAL

SLIDER
674
15
707
168
find-product-dist-mult
find-product-dist-mult
0
5
2.45
0.05
1
NIL
VERTICAL

SLIDER
766
15
799
168
find-project-friends-mult
find-project-friends-mult
0
5
5
0.2
1
NIL
VERTICAL

SLIDER
859
15
892
168
find-task-friends-mult
find-task-friends-mult
0
5
5
0.1
1
NIL
VERTICAL

SLIDER
822
15
855
168
find-task-dist-mult
find-task-dist-mult
0
5
3
0.1
1
NIL
VERTICAL

SLIDER
675
505
890
538
contrib-recent-weight-mult
contrib-recent-weight-mult
1
3
3
0.1
1
NIL
HORIZONTAL

SLIDER
1010
175
1043
325
max-find-level
max-find-level
0
1
0.15
0.05
1
NIL
VERTICAL

SLIDER
918
15
951
165
find-friend-prob
find-friend-prob
0
0.2
0.14
0.02
1
NIL
VERTICAL

SLIDER
675
470
890
503
contrib-num-task-mult
contrib-num-task-mult
1
3
3
0.1
1
NIL
HORIZONTAL

SLIDER
675
540
889
573
contrib-friend-task-effect
contrib-friend-task-effect
1
3
3
0.1
1
NIL
HORIZONTAL

SLIDER
969
15
1002
166
recommend-dist-mult
recommend-dist-mult
0
100
98
0.2
1
NIL
VERTICAL

SLIDER
20
390
185
423
task-hatch-task-prob
task-hatch-task-prob
0
1
0.7
0.1
1
NIL
HORIZONTAL

SLIDER
1012
15
1045
166
prop-project-dist-mult
prop-project-dist-mult
0
100
100
1
1
NIL
VERTICAL

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
NetLogo 5.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
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
