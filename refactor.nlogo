; Developed by Dr Peter Barbrook-Johnson and Antonio Tenorio-Fornés 2015 2016 as part of the P2Pvalue EU project

; Comments welcome - emails: p.barbrook-johnson@surrey.ac.uk, antoniotenorio@ucm.es

extensions [network nw]
globals [

  initial-products

  community-prod-activity-ls            ; list of the history of community production activity

  community-con-activity-ls             ; list of the history of community consumption activity

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

friendlinks-own [
  times-worked-together
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
  if number-of-products = "many" [ set initial-products random 100 ]

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

    set xcor -5
    set ycor -25 + interest

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
  ifelse (any? [ projecttasklink-neighbors ] of myself) or (random-float 1 < 0.5) [

    ; set a random skill
    set skill random (num-skills - 1)

  ] [

    ; else, set the task skill equal to one of its project tasks
    set skill [ skill ] of one-of [ projecttasklink-neighbors ] of myself

  ]
end

to create-existing-commoners

  ;; commoners hava a preferential attachement like structure
  nw:generate-preferential-attachment commoners friendlinks commoners-num [
    create-commoner
  ]

  ask commoners with [count my-friendlinks = 1] [
    ask one-of my-friendlinks [
      die
    ]
  ]

  ask friendlinks [
    set color yellow
  ]

end

to create-commonertasklink
  set color green
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / 7 ;; TODO 7 as a param
  set forget-link-prob 1 / 30 ;; TODO 30 as a param
  set recent-weight 0
  set out-attraction commoner-task-attraction-prob
  set in-attraction task-commoner-attraction-prob
end

to create-consumerlink
  set color orange
  set max-recent-weight 3
  set forget-recent-weight-prob 1 / 7 ;; TODO 7 as a param
  set forget-link-prob 1 / 30 ;; TODO 30 as a param
  set in-attraction 0.02 ;; TODO as param
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
  set forget-recent-weight-prob 1 / 7 ;; TODO 7 as a param
  set forget-link-prob 1 / 30 ;; TODO 30 as a param
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
  if any? product-projects [
    create-commonerprojectlink-with one-of product-projects [create-commonerprojectlink]
  ]

  ;; Create links with tasks of my projects with my skills
  create-commonertasklinks-to
   (turtle-set [ projecttasklink-neighbors ] of commonerprojectlink-neighbors) with
      [ member? skill [ skills ] of myself ]
    [ create-commonertasklink ]

  ;; 90's do not contribute
  ask commoners with [count my-friendlinks = 0] [
    ask out-commonertasklink-neighbors [die]
  ]

end

to go

  ask commoners [

    ;; contribution
    find-project
    find-task
    contribute

    ;; friendship
    ;; find-friends
    ;; drop-friends

    ;; consumption
    find-product
    consume

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


to-report find-project-prob
  report  0.1 * 1 / distance myself ;; TODO use param instead of 0.1
end

to find-project
  ask one-of projects with [not member? self commonerprojectlink-neighbors] [
    if random-float 1 < find-project-prob [
      create-commonerprojectlink-with myself [create-commonerprojectlink]
    ]
  ]
end

;; skills and friends and previous contributions
to-report find-task-prob
  report 0.1 * 1 / distance myself
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
    let num-tasks count out-commonertasklink-neighbors

  ifelse num-tasks = 0 [
    report 0
  ] [
    report 0.1 * (1 + sum [recent-weight] of my-out-consumerlinks) ;; TODO constants to params
  ]
end

to-report contrib-size
  report 1
end

;; TODO find project and tasks (and initialize with more commoner-task link neighbors)
;; TODO? contribute to those tasks that a commoner have already contributed to that task
to contribute
  if count out-commonertasklink-neighbors > 0 and random-float 1 < contrib-prob [
    ask one-of out-commonertasklink-neighbors [
      ask in-commonertasklink-from myself [
        increase-weight
      ]
      set time-required time-required - contrib-size
      if time-required < 0 [
        die
      ]
    ]
  ]
end

to-report find-product-prob
  report  0.1 * 1 / distance myself ;; TODO use param instead of 0.1
end

to find-product
  ask one-of products with [not member? self out-consumerlink-neighbors] [
    if random-float 1 < find-product-prob [
      create-consumerlink-from myself [create-consumerlink]
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
243
10
689
477
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
22
65
95
98
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
14
177
181
222
number-of-products
number-of-products
"one" "few" "many"
2

SLIDER
13
253
244
286
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
15
314
187
347
initial-projects
initial-projects
0
100
20
1
1
NIL
HORIZONTAL

SLIDER
19
412
217
445
mean-time-required
mean-time-required
0
100
40
1
1
NIL
HORIZONTAL

SLIDER
18
371
190
404
num-skills
num-skills
0
100
17
1
1
NIL
HORIZONTAL

SLIDER
15
128
192
161
commoners-num
commoners-num
0
500
200
1
1
NIL
HORIZONTAL

BUTTON
109
70
172
103
go
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
105
32
168
65
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
700
207
1022
240
commoner-task-attraction-prob
commoner-task-attraction-prob
0
1
0.06
0.02
1
NIL
HORIZONTAL

SLIDER
700
173
1023
206
commoner-repulsion-prob
commoner-repulsion-prob
0
0.04
0.026
0.001
1
NIL
HORIZONTAL

SLIDER
700
240
1022
273
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
700
316
1021
349
product-repulsion-prob
product-repulsion-prob
0
0.04
0.038
0.001
1
NIL
HORIZONTAL

SLIDER
703
398
1024
431
project-repulsion-prob
project-repulsion-prob
0
0.04
0.008
0.001
1
NIL
HORIZONTAL

SLIDER
701
367
983
400
task-commoner-attraction-prob
task-commoner-attraction-prob
0
1
0.41
0.01
1
NIL
HORIZONTAL

PLOT
702
10
1036
137
plot 1
NIL
NIL
0.0
1000.0
0.0
100.0
true
true
"set-histogram-num-bars 10.0" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram sort-by > [sum [total-weight] of my-out-consumerlinks] of commoners"

PLOT
1073
266
1273
416
plot 2
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
"default" 1.0 0 -16777216 true "" "plot count turtles"

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
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
0
@#$#@#$#@
