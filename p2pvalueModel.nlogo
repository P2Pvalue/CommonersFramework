; Developed by Dr Peter G Johnson 2015 as part of the p2pvalue EU project

; Comments welcome - email: peter.johnson@surrey.ac.uk




; GENERAL TO DOS / COMMENTS / also check word doc



; pull out hidden parameters (i.e., hard coded numbers) and remove dead sliders from interface

; make sure all differences in behaviour by scenarios (tool on and off, type of community, different thanks mechanism) are represented

; tidy code - check for unused variables etc






; MAIN UPDATES



; how is points and thanks used? currently only thanks in burnout...should it be added to other exits? and likelihood of contributions?

; add in when 1/9/90 created - are they on platform or not - 

; for each relevant go procedure - have a rule for when not on platform - i.e, ask X on platform - do this, ask X not on platform do that
; for those not on platform - have an offline and online version of rules when not using platform - speak to antonio about this?

; predictability of reward influences choice of task/project?

; higher value if thanks from 1...

; thanks creates friendhsip?

; size of comm may effect rules? - e.g., size of community will differentiate change in breed - ie., in small comms, you may bevome a 1 just by starting a project.
; others?



; DEBUGGING


; double check transfer of agent variables when change breed and new agent appears - do they make sense (ie., should not just forget friends or projects)


; can only drop one project at a time - can i make it more?


; error on drop projects sometimes - contributors with my-tasks = 0 - not set in change breeds?

; 1 and 9 never drop a task because it is lonely... is this ok - probably. 9 drop when they have no tasks in it, and 1 drop when they are in overtime

; when 1 product - can never get new 90s - no new products (why?) and so consumption can never go up




; calibration check - 1% need to make most contributions.







; data

; 2 + case studies - some initial conditions, type of community, and some patterns over time


; from madrid book - 68% of newcomers are never seen after first post, those that particapte in past are much more likley to return. those that dont post are like 99% dont return - p205 kraut et al building successful online comms 


;; from http://link.springer.com/chapter/10.1007/978-3-319-19003-7_4

;We, first, analyze the general structure of the social networks, e.g., graph distances and the degree distribution of the social networks. 
;Our social network structure analysis confirms a power-law degree distribution and small-world characteristics. However, the degree mixing 
;pattern shows that high degree nodes tend to connect more with low degree nodes suggesting a collaboration between experts and newbie developers. 
;We further conduct the same analysis on affiliation networks and find that contributors tend to participate in projects of similar team sizes. 
;Second, we study the correlation between various social factors (e.g., closeness and betweenness centrality, clustering coefficient and 
;tie strength) and the productivity of the contributors in terms of the amount of contribution and commitment to OSS projects. 

; power law degree distribution
; small world characteristics
; high degree and low degree do mix
; contrubutors tend to find all projects of siilar team sizes

; use for initialisation, and for validation







; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters
; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters
; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters


globals [
  
  ; platform-features                  ; chooser for current platform features turned on/off
  
  ; proportion-using-platform
  
  ; initial-number-#1s                 ; initial numbers of these agents
  ; initial-number-#9s
  ; initial-number-#90s
  ; initial-projects
  ; initial-tasks
  ; initial-products
  
  ; num-interest-categories             ; number of discrete 'interest' categories
  
  ; prop-of-projects-reward-subjective  ; proportion of tasks that have their reward decided subjectively - ie., variation / not as predictable
  
  ; prop-consumed-each-time             ; proportion of a product that is consumed by each #90 on each timestep
                                        ; currently just used to measure level of consumption by 90 - not depletion of product - ie., assume non-rivalrous
  
  #1s-left
  #9s-left                              ; count of #9 who have left communuity
  #90s-left                             ; count of #90s who have left community
  
  #90s-left-no-product
  
  new-#9s-total                         ; count of new #9 entered the community
  new-#90s-total                        ; count of new #90s entered the community
  
  new-members-stayed                    ; count of members who stayed beyond a certain time
  
  new-#1-count                          ; count of new #1s
  
  products-consumed                     ; count products consumed
  tasks-completed                       ; count tasks completed
  
  new-tasks-count                       ; count of new tasks created 
  new-products-count                    ; count of new products created
  
  #9-to-#1-count                        ; count of #9 turned into #1
  #1-to-#9-count                        ; count of #1s turned to #9
  #90-to-#9-count
  
  num-skills                            ; number of skill types for projects or contributors
  
  ; reward-mechanism                    ; chooser specifying which reward mechanism is currently being used
  
  ; chance-of-finding-new-task          ; chance per tick working on a task idenitfies a new task
  
  #9-left-no-interest                   ; recording why #9 leave comm
  #9-left-#9-here

  #9-left-drop-cons
  
  #1-left-burnout                       ; USED THIS???? recording why #1 left
  #9-left-burnout
  
  time-with-no-#1s                      ; recording ticks with no agents
  time-with-no-#9
  time-with-no-#90s
  time-with-no-products
  time-with-no-tasks
  
  new-#9-attracted-by-#90s
    
  projects-died                         ; count of projects 'died'
  projects-finished
  
  count-new-projects                    ; count new projects
  
  product-had-no-consumer-so-left       ; count of reasons why product 'died'
  
  contributions-made-by-1s                    ; count of indiviudal contributions made
  time-contributed-by-1s                     ; count of hours contributed
  contributions-made-by-9s                    ; count of indiviudal contributions made
  time-contributed-by-9s                     ; count of hours contributed
  
  #1-dropped-a-task
  #9-dropped-a-task
  
  #1-dropped-a-project
  #9-dropped-a-project
  
  community-prod-activity-t-10          ; history of community production activity
  community-prod-activity-t-9 
  community-prod-activity-t-8 
  community-prod-activity-t-7 
  community-prod-activity-t-6 
  community-prod-activity-t-5 
  community-prod-activity-t-4 
  community-prod-activity-t-3 
  community-prod-activity-t-2 
  community-prod-activity-t-1 
  community-prod-activity-t 
  
  community-con-activity-t-10           ; history of community consumption activity
  community-con-activity-t-9
  community-con-activity-t-8
  community-con-activity-t-7
  community-con-activity-t-6
  community-con-activity-t-5
  community-con-activity-t-4
  community-con-activity-t-3
  community-con-activity-t-2
  community-con-activity-t-1
  community-con-activity-t
  
]


; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types
; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types
; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types; Agent types

breed [#1s #1]
breed [#9s #9]
breed [#90s #90]
breed [projects project]
breed [t4sks t4sk]
breed [products product]
undirected-link-breed [tasklinks tasklink]
undirected-link-breed [friendlinks friendlink]
undirected-link-breed [consumerlinks consumerlink]
undirected-link-breed [projectproductlinks projectproductlink]

; Agent parameters by type; Agent parameters by type; Agent parameters by type; Agent parameters by type
; Agent parameters by type; Agent parameters by type; Agent parameters by type; Agent parameters by type
; Agent parameters by type; Agent parameters by type; Agent parameters by type; Agent parameters by type

#1s-own [
  my-projects-1s               ; list (actual list) of projects 1 attached to
  my-tasks-1s                  ; list (agentset) of tasks currently contributing to
  my-friends-1s                ; list (agentset) of other 9s currently friends with
  my-projects                  ; 
  my-tasks                     ; these 3 used when changing breeds
  my-friends                   ; 
  my-time                      ; static time availability for community - random 40
  time                         ; current spare time available (not being used on tasks already)
  skill                        ; skill score - random 100
  interest                     ; interest score - random num-interest-categories
  typ3-preference              ; type of tasks preferred - prod, mngt, or both 
  using-platform?              ; yes/no - is the #1 using the platform?
  points                       ; count quant reward/point received by agent
  thanks                       ; on or off have they received any thanks
  time-in-community            ; count ticks/weeks spent in community
  contribution-history-1s      ; list with contribution in previous N ticks
  contribution-history-9s      ; used when changing breed
  my-total-contribution-1s     ; count of previous contributions
]

#9s-own [
  my-projects                  ; list (actual list) of projects 9 attached to
  my-tasks                     ; list (agentset) of tasks currently contributing to
  my-friends                   ; list (agentset) of other 9s currently friends with
  my-projects-1s               ; 
  my-tasks-1s                  ; used when changing breeds
  my-friends-1s                ; 
  my-time                      ; static time availability for community - random 40
  time                         ; current spare time available (not being used on tasks already)
  skill                        ; skill score - random 100
  interest                     ; interest score - random num-interest-categories
  typ3-preference              ; prod, mngt, or both
  using-platform?              ; yes/no - is the #9 using the platform?
  points                       ; count reward received by agent
  thanks
  time-in-community            ; count ticks/weeks spent in community
  time-with-no-links           ; count ticks #9 has had no tasks
  contribution-history-9s      ; list with contribution in previous N ticks
  contribution-history-1s      ; used when changing breeds
  my-total-contribution-9s     ; count of previous contributions
]

#90s-own [
  interest                     ; interest score - random num-interest-categories
  consumption                  ; count level of volume consumed from products
  time-in-community            ; count ticks/weeks spent in community      
  time-without-products        ; count ticks with no product to consume
]

projects-own [
  inter3st                     ; interest score - random num-interest-categories
  num-tasks                    ; number of tasks currently in project
  time-project-with-no-tasks   ; count ticks with no current tasks
  my-tasks-projects            ; the tasks of this project
  production-activity          ; score - count of current contributors to project's tasks weighted by distance
  production-history           ; 10 tick history of production-activity
  time-project-with-no-contributors ; count ticks with no contributors to any of project's tasks
  age                          ; time task has been in community
  my-product
  likes                        ; used in position in list
  likes-history
  reward-type                  ; obj or subj - how reward to each contributor is decided
  reward-level                 ; amount of reward random 100
  current-contributors
]

t4sks-own [
  my-project                   ; project task is within
  typ3                         ; mngt/prod - type of task, management or actual product - only prod tasks produce a product for #90s
  inter3st                     ; interest score - random num-interest-categories
  time-required                ; time required to complete tasks random 1000
  skill-required               ; minimum skill required to contribute to task - random 100
  modularity                   ; contribution required by task per tick
  age                          ; time task has been in community
  time-only-one-contributor    ; ticks with only one contributors
]

products-own [
  inter3st                     ; interest score - random num-interest-categories
  volume                       ; volume of consumable value product has
  consumption-activity         ; count of number of current consumers of this product
  age                          ; time product has been in community
  mon-project                  ; project product is associated with
  time-with-no-consumers       ; count ticks with no consumers
  consumption-history          ; list of recent consumerlinks per tick
]

patches-own [
]

tasklinks-own [ ageL ]         ; all links have an age parameter
friendlinks-own [ ageL ]
consumerlinks-own [ ageL ]
projectproductlinks-own [ ageL ]

; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go
; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go
; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go; Setup & Go

to setup
  clear-all
  
  if platform-features = TRUE
   [ ;; colour lines to mark projects and products spaces
     ask patches with [pxcor = 17 OR pxcor = -5 OR pxcor = -14  OR pxcor = -4] [set pcolor white]
     ;; set some globals to zero / reset-ticks
     setup-globals
     ;; create agents
     if number-of-products = "one" [ set initial-products 1 ]
     if number-of-products = "a few" [ set initial-products random 5 + 2 ]  
     if number-of-products = "many" [ set initial-products random 100 ] 
     create-existing-product
     create-existing-projects     
     create-#1
     create-#9
     create-#90                           
     reset-ticks
   ]
  
  if platform-features = TRUE and community-type = "online closed" []
  if platform-features = TRUE and community-type = "offline" []
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
 
end

to go
  find-projects                   ;; contributors find projects
  find-tasks                      ;; contributors find tasks
  contribute-to-tasks             ;; contributors regulate the number of tasks they have, and contribute
  drop-projects
  make-and-lose-friends           ;; friendships formed and broken
  finish-tasks
  give-out-reward                 ;; tasks give out reward depending on reward mechanism
  finished-projects               ;; completed tasks become products or improve existing ones - SHOULD THIS BE PROJECTS?
  tasks-identified                ;; creates new tasks from existing tasks, ie., find new ones by doing others
  projects-die                    ;; projects 'die' if no contributors or tasks
  calc-recent-activity            ;; projects calculate recent-activity
  update-project-position         ;; projects get closer or further from 9s depending on recent activity
  new-projects                    ;; if projects have high activity they might produce another project
                                  ;; 1 and 9 can also propose projects
  consume-products                ;; 90s find product, consume. products calc consumption-activity, 
                                  ;; small chance of dying, small chance connection with consumer lost
  update-product-position         ;; product moves closer or further from 90s depening on popularity of it, 
                                  ;; and its associated project
  update-90s-and-9s-and-1s-positions  ;; 9s move closer to their friendship group, 90s move closer to consumers of same products
  products-die                    ;; products 'die' if no consumers
  entry                           ;; various rules for diff agents entry to community
  exit                            ;; various rules for diff agents exit from community
  change-breed                    ;; rules for agents changing breed - TO BE DONE
  all-age                         ;; all agents tick on their age/time in comm variable                  
  update-community-activity       ;; calc history of prod and cons activity       
  
  ;; some backstop stop conditions for model
  if count #1s = 0 [  set time-with-no-#1s time-with-no-#1s + 1  ]
  if count #9s = 0 [ set time-with-no-#9 time-with-no-#9 + 1 ]
  if count #90s = 0 [ set time-with-no-#90s time-with-no-#90s + 1 ]
  if count products = 0 [ set time-with-no-products time-with-no-products + 1 ]
  if count t4sks = 0 [ set time-with-no-tasks time-with-no-tasks + 1 ]
  if ( time-with-no-#90s = 26 ) [ print "stop no #90s" print ticks stop ]
  if ( time-with-no-#1s = 5 ) [ print "stop no #1s" print ticks stop ]
  if ( time-with-no-#9 = 12 ) [ print "stop no #9" print ticks stop ]
  if ( time-with-no-products = 26 ) [ print "stop no products" print ticks stop ]
  if ( time-with-no-tasks = 26 ) [ print "stop no tasks" print ticks stop ]
  
  tick
end

;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures
;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures
;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures;Setup Procedures

to create-existing-projects
  if platform-features = TRUE [ 
    create-projects initial-projects [ 
      set num-tasks random 10 + 2
      set inter3st random num-interest-categories
      set production-history []
      set reward-level random 100
      ifelse random-float 1 < prop-of-projects-reward-subjective [ set reward-type "subjective" ] 
                                                                 [ set reward-type "objective" ]
      hatch-t4sks num-tasks [ 
                             set size 0.7
                             set color green
                             set shape "circle" 
                             set inter3st [inter3st] of myself
                             
                             set time-required random 1000
                             set skill-required random 100
                             set modularity random 20 + 1 
                             set age 0   
                             set my-project myself 
                             t4sk-set-typ3
                             
                          
                            ]
    
    set my-tasks-projects t4sks with [ my-project = myself ]
    set xcor 5
    set ycor -25 + inter3st
    set size 2.5
    set color green - 2
    set shape "target" 
    set age 0 
    set likes-history []
    ask t4sks with [my-project = myself ] [ set xcor [xcor] of myself
                                            set ycor [ycor] of myself
                                            set heading random 360
                                            fd 1
                                           ]
    set my-product min-one-of products [distance myself]
    create-projectproductlink-with my-product [set color red] 
    ask projectproductlink-neighbors [ set mon-project (list (projectproductlink-neighbors))] 
    
    ask products with [ mon-project = 0 ] [ set mon-project [] ] 
    
    ] ]
end

to create-existing-product
  create-products initial-products [
    set inter3st random num-interest-categories 
    set xcor -10
    set ycor -25 + inter3st
    set size 2
    set color orange
    set shape "box"
    set volume random 100
    set age 0
    ;set mon-project (list (projectproductlink-neighbors))
    set consumption-history []
  ]
end

to create-#1
    if platform-features = TRUE [ 
      create-#1s initial-number-1s [ set interest random num-interest-categories
                                     set xcor 18
                                     set ycor -25 + interest 
                                     set size 1.5
                                     set color red 
                                     set my-time 1 + random 40 
                                     set time my-time
                                     set skill (n-of 3 (n-values num-skills [?]))
                                     set interest random num-interest-categories
                                     set using-platform? "true"
                                     let pref-prob random-float 1
                                     if pref-prob < 0.33 [ set typ3-preference "prod" ]
                                     if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
                                     if pref-prob >= 0.66 [ set typ3-preference "both" ]  
                                     set points 0 
                                     set thanks "not received"
                                     set my-projects-1s (list (min-one-of projects [ distance myself ]))
                                     let my-projects-tasks t4sks with [ member? ( [ my-project ] of self ) ( [my-projects-1s] of myself ) ] 
                                     if any? my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ] [
                                     let new-task$ my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ]
                                     create-tasklinks-with new-task$ [set color 3] ]
                                     set my-tasks-1s tasklink-neighbors
                                     set time my-time - sum [ modularity ] of tasklink-neighbors
                                     set contribution-history-1s (n-values 10 [ round random-exponential 0.7 ] )
                                     set my-total-contribution-1s count my-tasklinks
                                     let new-friends other turtle-set [ tasklink-neighbors ] of my-tasks-1s
                                     create-friendlinks-with n-of round ( count new-friends / 2 ) new-friends [set color red] 
                                     set my-friends-1s friendlink-neighbors
                                    ]
                                  ]
end

to create-#9
  if platform-features = TRUE [ 
    create-#9s initial-number-9s [ set interest random num-interest-categories
                                   set xcor ( random 6 ) + 19
                                   set ycor -25 + interest 
                                   set size 1
                                   set color blue
                                   set my-time 1 + random 20
                                   set time my-time
                                   set skill (n-of 3 (n-values num-skills [?]))
                                   let pref-prob random-float 1
                                   if pref-prob < 0.33 [ set typ3-preference "prod" ]
                                   if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
                                   if pref-prob >= 0.66 [ set typ3-preference "both" ]
                                   set using-platform? "true"
                                   set points 0 
                                   set thanks "not received"
                                   set my-projects (list (min-one-of projects [ distance myself ]))
                                   let my-projects-tasks t4sks with [ member? ( [ my-project ] of self ) ( [my-projects] of myself ) ] 
                                   if any? my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ] [
                                   let new-task$ my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ]
                                   create-tasklinks-with new-task$ [set color 3] ]
                                   set my-tasks tasklink-neighbors
                                   set time my-time - sum [ modularity ] of tasklink-neighbors
                                   set contribution-history-9s (n-values 10 [ round random-exponential 0.6 ] )
                                   set my-total-contribution-9s count my-tasklinks
                                   let new-friends other turtle-set [ tasklink-neighbors ] of my-tasks
                                   create-friendlinks-with n-of round ( count new-friends / 2 ) new-friends [set color blue] 
                                   set my-friends friendlink-neighbors
                                  ]
                                ]
end

to create-#90
  create-#90s initial-number-90s [
    ifelse number-of-products = "one" [ set interest [ inter3st ] of one-of products + random 20 - 10
                                        if interest > 50 [ set interest 50 ]
                                        if interest < 0  [ set interest 0  ] ]
                                      [ set interest random num-interest-categories ]
    set xcor random 8 - 22
    set ycor -25 + interest
    set size 1
    set color yellow
    set consumption 0
    
    create-consumerlink-with min-one-of products [ distance myself ]
    
  ]
end

to setup-globals
  set #9s-left 0
  set #90s-left 0
  set new-#9s-total 0
  set new-#90s-total 0
  set new-members-stayed 0
  set #9s-left 0
  set #90s-left 0
  set new-#9s-total 0
  set new-#90s-total 0
  set new-members-stayed 0
  set new-#1-count 0
  set products-consumed 0
  set tasks-completed 0
  set new-tasks-count 0
  set new-products-count 0
  set #9-to-#1-count 0
  set #1-to-#9-count 0
  set #9-left-no-interest 0
  set #9-left-#9-here 0
  set #1-left-burnout 0
  set time-with-no-#1s 0
  set time-with-no-#9 0
  set time-with-no-#90s 0

  set new-#9-attracted-by-#90s 0
  set projects-died  0
  set count-new-projects 0
  set product-had-no-consumer-so-left 0
  set community-prod-activity-t-10 0
  set community-prod-activity-t-9 0
  set community-prod-activity-t-8 0
  set community-prod-activity-t-7 0
  set community-prod-activity-t-6 0
  set community-prod-activity-t-5 0
  set community-prod-activity-t-4 0
  set community-prod-activity-t-3 0
  set community-prod-activity-t-2 0
  set community-prod-activity-t-1 0
  set community-prod-activity-t 0
  set community-con-activity-t-10 0           
  set community-con-activity-t-9 0
  set community-con-activity-t-8 0
  set community-con-activity-t-7 0
  set community-con-activity-t-6 0
  set community-con-activity-t-5 0
  set community-con-activity-t-4 0
  set community-con-activity-t-3 0
  set community-con-activity-t-2 0
  set community-con-activity-t-1 0
  set community-con-activity-t 0
  
  set num-skills 10
end

;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures
;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures
;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures
;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures
;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures
;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures;Go Procedures

to find-projects
  
  if platform-features = TRUE [
  
  ; 1s find projects - the 1 closest to them, if they have time...
  
  ask #1s [ if time > 0 [ let other-projects projects with [ not member? self [ my-projects-1s ] of myself ]
                          let new-project min-one-of other-projects [ distance myself ] 
                          if other-projects != nobody [ set my-projects-1s lput new-project my-projects-1s ] ] ]
                        
  ; 9s find projects that are nearer the 'top of the list' but still close to them - ie., interest is nearby, and more to right
  ; and add them to a list
  
  ask #9s [ if time > 0 [ let other-projects projects with [ not member? self [ my-projects ] of myself ]
                          let new-project min-one-of other-projects [ distance myself ] 
                          if other-projects != nobody and new-project != nobody [ 
                                                         if random-float 1 < 
                                                            ( 0.2 / 
                                                              ( ( [ distance myself ] of new-project ) / 
                                                               ( [ distance myself ] of max-one-of projects [ distance myself ] ) 
                                                              )
                                                            )
                                                               
                                                                [ set my-projects lput new-project my-projects ] ] ] ]
                        ] 
  
  if platform-features = FALSE and community-type = "online " []

  if platform-features = FALSE and community-type = "offline" []
  
end

to find-tasks
  
  ; add friends working on a task increase chance of contributing to it
  
  if platform-features = TRUE [
    
  
  ; 1s find tasks that are in the projects they have found, they are more tolerant of different interest; 
  ; ie., if they have found a project far from them they wont actually contribute to tasks
  
  ask #1s [ if time > 0 [ 
                          let my-projects-tasks t4sks with [ member? ( [ my-project ] of self ) ( [my-projects-1s] of myself ) ] 


                          if any? my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ]
                            
                          [ let new-task$ my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ]
                            create-tasklinks-with new-task$ [set color 3] ]
                            
                          if ( not any? my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ])
                            
                          [ 
                          let new-task$-2 one-of my-projects-tasks  
                          if new-task$-2 != nobody [                              
                          create-tasklink-with new-task$-2 [set color 3] ] ] 
                          
                          set my-tasks-1s tasklink-neighbors
                       ]
            ]
        
  
  
  ; 9s find tasks that are in the projects they have found, but have an interest close to them; 
  ; ie., if they have found a project far from them they wont actually contribute to tasks
  
  ask #9s [ if time > 0 [ 
                          let my-projects-tasks t4sks with [ member? ( [ my-project ] of self ) ( [my-projects] of myself ) ] 
                          
                          if any? my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ]
                            
                          [ let new-task$ my-projects-tasks with [ member? ( [ typ3 ] of self ) ( [ skill ] of myself ) ]
                            ; this increases chance of contribution with previous contributions - could make more sophisticated to weight more recent contributions
                            
                            ; if friends are on tasks I favour them and have high chance of contributing, if no friends i just pick randomly

                           let contributors-to-new-task turtle-set [ tasklink-neighbors ] of new-task$
                           
                           let contributors-to-new-tasks-that-are-my-friend contributors-to-new-task with [ member? myself friendlink-neighbors ]

                           ifelse any? contributors-to-new-tasks-that-are-my-friend 
                            
                              [   
                                if ( random-float 1 < ( 0.1 + ( 0.01 * sum contribution-history-9s ) ) ) 
                               [ create-tasklink-with one-of turtle-set [ tasklink-neighbors ] of contributors-to-new-tasks-that-are-my-friend [set color 3] ] ]
                              
                              [ if ( random-float 1 < ( 0.05 + ( 0.01 * sum contribution-history-9s ) ) ) 
                               [ create-tasklink-with one-of new-task$ [set color 3] ] ]
                            ; one-of used here to represent occasional contribution - you dont contribute/connect to all tasks that you could
                     
                            set my-tasks tasklink-neighbors
                       ]
            ]
        ] ]
  
  
  if platform-features = FALSE and community-type = "online " []

  if platform-features = FALSE and community-type = "offline" []
  
end

to contribute-to-tasks
  
  if platform-features = TRUE [
  
  ; update time availability, if no time left, drop tasks
 
   ask #1s [ set time my-time - sum [ modularity ] of tasklink-neighbors
             if time < 0 and count my-tasklinks > 1  [ 
                let chance random-float 1
                if chance < 0.33 [ ask link-with ( min-one-of tasklink-neighbors [ xcor ] ) [die] ]
                if chance >= 0.33 and chance < 0.66 [ ask link-with ( max-one-of tasklink-neighbors [ time-required ] ) [die] ]
                if chance >= 0.66 [ ask link-with ( min-one-of tasklink-neighbors [ count tasklink-neighbors with [ one-of friendlink-neighbors = [ myself ] of myself  ] ] ) [die] ]
                set #1-dropped-a-task #1-dropped-a-task + 1
                                                       ]        
             if count my-tasklinks > 0 [
             set my-tasks-1s tasklink-neighbors
             
             set contributions-made-by-1s contributions-made-by-1s + count tasklink-neighbors
             set time-contributed-by-1s time-contributed-by-1s + ( my-time - time ) ]
             
             set contribution-history-1s lput count my-tasklinks contribution-history-1s 
             if length contribution-history-1s > 10 [ set contribution-history-1s but-first contribution-history-1s ]
             
             set my-total-contribution-1s my-total-contribution-1s + count my-tasklinks
   ]
  
   ask #9s [ set time my-time - sum [ modularity ] of tasklink-neighbors
             if time < 0 and count my-tasklinks > 1  [ 
                let chance random-float 1
                if chance < 0.33 [ ask link-with ( min-one-of tasklink-neighbors [ xcor ] ) [die] ]
                if chance >= 0.33 and chance < 0.66 [ ask link-with ( max-one-of tasklink-neighbors [ time-required ] ) [die] ]
                if chance >= 0.66 [ ask link-with ( min-one-of tasklink-neighbors [ count tasklink-neighbors with [ one-of friendlink-neighbors = [ myself ] of myself  ] ] ) [die] ] 
                set #9-dropped-a-task #9-dropped-a-task + 1                                     ]        
             
             if count my-tasklinks > 0 [
                set my-tasks tasklink-neighbors
    
                set contributions-made-by-9s contributions-made-by-9s + count tasklink-neighbors
                set time-contributed-by-9s time-contributed-by-9s + ( my-time - time ) ] 
             

             set contribution-history-9s lput count my-tasklinks contribution-history-9s 
             if length contribution-history-9s > 10 [ set contribution-history-9s but-first contribution-history-9s ]
             
             set my-total-contribution-9s my-total-contribution-9s + count my-tasklinks
             
    
            ]
             
  ; contribute - task reduce their time by their contriubutors * modularity 
  
  ; NEEDS TO REFLECT NOT ALL LINK NEIGHBOURS WILL CONTRIBUTE!!!
  
  ask t4sks [ set time-required time-required - (modularity * count tasklink-neighbors) 
            ]
  
  ; what about tasks that dont finish???
  
  
  
  
  ask projects [ set my-tasks-projects t4sks with [ my-project = myself ]
                 set current-contributors turtle-set [ tasklink-neighbors ] of my-tasks-projects ]
]
  
  if platform-features = FALSE and community-type = "online " []

  if platform-features = FALSE and community-type = "offline" []
  
end

to drop-projects
  
  
  ; 1s drop a project and its tasks if it is lonely and unpopular
  
  ask #1s [ 
    if any? ( turtle-set my-projects-1s ) with [ all? my-tasks-projects [ ( turtle-set tasklink-neighbors = turtle-set myself ) OR ( turtle-set tasklink-neighbors = nobody )  ]] and random-float 1 < 0.01 [
      
      let lonely-projects ( turtle-set my-projects-1s ) with [ all? my-tasks-projects [ ( turtle-set tasklink-neighbors = turtle-set myself OR turtle-set tasklink-neighbors = nobody )  ]]
      let lonely-unpopular-project one-of lonely-projects with [ random-float 1 < ( [ xcor ] of myself - xcor / 17 - (- 4) )  ] ; 17 and -4 used as these are current project postion limits
      let lonely-unpopular-tasks [ my-tasks-projects ] of lonely-unpopular-project
      
      set my-projects-1s remove lonely-unpopular-project my-projects-1s
      set #1-dropped-a-project #1-dropped-a-project + 1
      ask lonely-unpopular-tasks [ ask my-tasklinks [die] ]
      set my-tasks-1s tasklink-neighbors
      set #1-dropped-a-task #1-dropped-a-task + (count lonely-unpopular-tasks )
      
      ]]
       
       
   
  
  ; 9s drop a project and its tasks if it is lonely and unpopular
  
  ask #9s [ 
    if any? ( turtle-set my-projects ) with [ all? my-tasks-projects [ ( turtle-set tasklink-neighbors = turtle-set myself ) OR ( turtle-set tasklink-neighbors = nobody )  ]] and random-float 1 < 0.1 [
      
      let lonely-projects ( turtle-set my-projects ) with [ all? my-tasks-projects [ ( turtle-set tasklink-neighbors = turtle-set myself OR turtle-set tasklink-neighbors = nobody )  ]]
      let lonely-unpopular-project one-of lonely-projects with [ random-float 1 < ( [ xcor ] of myself - xcor / 17 - (- 4) )  ] ; 17 and -4 used as these are current project postion limits
      let lonely-unpopular-tasks [ my-tasks-projects ] of lonely-unpopular-project
      
      set my-projects remove lonely-unpopular-project my-projects
      set #9-dropped-a-project #9-dropped-a-project + 1
      ask lonely-unpopular-tasks [ ask my-tasklinks [die] ]
      set my-tasks tasklink-neighbors
      set #9-dropped-a-task #9-dropped-a-task + (count lonely-unpopular-tasks )
       
      ]]
  
 
  
  ; 9s drop projects if i have no tasks in them and a certain chance
  
  ask #9s [ if count ( turtle-set my-projects ) with [ not member? self [ [ my-project ] of my-tasks ] of myself ] > 0 and random-float 1 < 0.2 
            [ let projects-to-drop ( turtle-set my-projects ) with [not member? self [ [my-project] of my-tasks ] of myself ]  
              
              set my-projects remove one-of projects-to-drop my-projects
              
              set #9-dropped-a-project #9-dropped-a-project + 1
            ]
           ]

end

to make-and-lose-friends
  
  
  ; tapi point - some 1s have a role of being new 9s into the community (mentor) - ie., linking them to other 9s with similar interest and or skill
  
  ; on entry 9 has some chance they have a mentor, and then the mentor does the above
  
  ; initilistion start with some friends
  
  ask #1s [ if count tasklink-neighbors > 0 [ let new-friends other turtle-set [ tasklink-neighbors ] of my-tasks-1s
                                              create-friendlinks-with n-of round ( count new-friends / 2 ) new-friends [set color red] 
                                              set my-friends-1s friendlink-neighbors
                                              if count friendlinks > 0 [ if random-float 1 < 0.1 [ ask one-of friendlinks [die] ] ]
                                            ]
          ]
  
  
  
  ask #9s [ if count tasklink-neighbors > 0 [ let new-friends other turtle-set [ tasklink-neighbors ] of my-tasks
                                              create-friendlinks-with n-of round ( count new-friends / 2 ) new-friends [set color blue] 
                                              set my-friends friendlink-neighbors
                                              if count friendlinks > 0 [ if random-float 1 < 0.1 [ ask one-of friendlinks [die] ] ]
                                            ]
          ]
  
  
end

to give-out-reward
  
  ; two types - competitive and thanks
  
  ; competitive is quantitative - get reward when task is complete, reward is then used in deciding whether to contribute again etc, 
  
  ; thanks - value is higher from 1 than 9 etc, also public thanks is better than private
  
  ;The expression of gratitude among community members create social ties (friendship in the model),

  ; We also identified different thanks mechanisms that are not exclusive: personal thanks (person to person) or public thanks (a person thanks another in a place that is visible to the community).
  
  
  if reward-mechanism = "'thanks' only" [
    
    ask projects [ 
      if num-tasks = 0 [ 
        ask current-contributors [ set thanks "received" ] ] ] 
    
    ask #1s [ if random-float 1 < 0.1 [ set thanks "not received" ] ]
    
    ask #9s [ if random-float 1 < 0.1 [ set thanks "not received" ] ]
  
  ]
  
  
  if reward-mechanism = "'points' only" [ 
    ask projects [ if num-tasks = 0 [ 
  
      if reward-type = "subjective" [ ask current-contributors [ set points points + random-normal ([ reward-level ] of myself) 20 ] ]
      if reward-type = "objective" [ ask current-contributors [ set points points + [ reward-level ] of myself ] ] ]  ] ] 
  
  
  
  
  if reward-mechanism = "both" [ 
    
    ask projects [ if num-tasks = 0 [ ask current-contributors [ set thanks "received" ] ] ]
    
    ask #1s [ if random-float 1 < 0.1 [ set thanks "not received" ] ]
    
    ask #9s [ if random-float 1 < 0.1 [ set thanks "not received" ] ]

    ask projects [ if num-tasks = 0 [ 
  
      if reward-type = "subjective" [ ask current-contributors [ set points points + random-normal ([ reward-level ] of myself) 20 ] ]
      if reward-type = "objective" [ ask current-contributors [ set points points + [ reward-level ] of myself ] ] ]  ] ]
  
  
  

end

to finish-tasks
  
   ; when a task is finished - it improves its related project
  
  
  ask t4sks [ if time-required <= 0 [   
  
  ;; this needs to move the product - improved product will get closer to 90s etc
  
  ifelse number-of-products = "many" [ ask products with [ mon-project = [ my-project ] of myself ] [ set volume volume + volume ] ]
                                     [ ask products with [ mon-project != nobody and member? [ my-project ] of myself mon-project ] [ set volume volume + volume ] ]
                                     
  set tasks-completed tasks-completed + 1 
  ask turtle-set my-project [ set num-tasks num-tasks - 1 ]
  die 
    ]
            
  if my-project = nobody [die] 
  ]
  
end

to finished-projects

  ;; a project is finshed it either improves its product, or creates a new one if it has no product
  
  ask projects [
    
    
    if num-tasks = 0 and my-product != nobody [ ask my-product [ set volume volume * 3 ]
                                                set projects-finished projects-finished + 1
                                                die ]
    if num-tasks = 0 and my-product = nobody [ birth-a-product 
                                               set projects-finished projects-finished + 1
                                               die ]
  ]
    ;; BUT WHEN A PROJECT FINISHES AND HATCHES A PRODUCT - SHOULD IT NOT CONTINUE TO MAINTAIN THAT PRODUCT?
    
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
end
   
to tasks-identified
  
    ;; if more people are working on a task - more likley to create further tasks
    
   ask t4sks [ if count tasklink-neighbors > 0 [
      if random-float 1 < chance-of-finding-new-task [ create-new-task ] ] ] 
 
  
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
end
  
to create-new-task
  hatch-t4sks 1 [ set heading random 360
                 fd 1
                 set size 0.7
                 set color green
                 set shape "circle" 
                 t4sk-set-typ3       
                 set inter3st [inter3st] of myself
                 set time-required random 1000
                 set skill-required random 100
                 set modularity random 20 + 1 
                 set age 0            
                 set my-project [my-project] of myself
                 set new-tasks-count new-tasks-count + 1 
                 ask turtle-set my-project [ set num-tasks num-tasks + 1 ]
               ]
end

to projects-die
  
  ;; projects can linger without contributors for a short time but die (ie., removed from list)
  ask projects [
    
    if not any? #9s with [ member? myself my-projects ] and not any? #1s with [ member? myself my-projects-1s ] [
       if random-float 1 < 0.5 [ set projects-died projects-died + 1
                                 ask turtle-set my-tasks-projects [ die ]
                                 die 
                               ]
    
  ] ]
  
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
end

to calc-recent-activity
 

  ask projects [ set my-tasks-projects t4sks with [ my-project = myself ]
                 if count my-tasks-projects > 0 and count turtle-set [ tasklink-neighbors ] of my-tasks-projects > 0 [ 
                 let my-tasks-tasklinkneighbors turtle-set [ tasklink-neighbors ] of my-tasks-projects
                 set production-activity  ( count link-set [ my-tasklinks ] of my-tasks-projects  /  mean  [ distance myself ] of  my-tasks-tasklinkneighbors  ) 
                 set production-history lput  ( count link-set [ my-tasklinks ] of my-tasks-projects /  mean  [ distance myself ] of  my-tasks-tasklinkneighbors )   production-history 
                 if length production-history = 11 [ set production-history but-first production-history ] ] ]
end

to new-projects
  
  ; 1s and 9s to propose new projects with a small probability (1 is higher?)
  
  ask #1s [ if random-float 1 < 0.005 [ #1-or-#9-hatch-project ] ]
  
  ask #9s [ if random-float 1 < 0.001 [ #1-or-#9-hatch-project ] ]
  
  ; projects can create other projects - if very active
  
  ; this will change when i update how recent activity is calc - ie., a history relative to itself
  
  ask projects [ if production-activity > mean [ production-activity ] of projects AND random-float 1 < 0.03 [
      project-hatch-a-project ] ]
      
  
  
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
end

to #1-or-#9-hatch-project
  hatch-projects 1 [
        set count-new-projects count-new-projects + 1
        set num-tasks random 10 + 2
        set production-history []
        set reward-level random 100
        ifelse random-float 1 < prop-of-projects-reward-subjective [ set reward-type "subjective" ] 
                                                                   [ set reward-type "objective" ]
        ifelse inter3st > 3 [ set inter3st [interest ] of myself  + random 3 - random 3 ] [ set inter3st [interest ] of myself  + random 3 ]
        hatch-t4sks num-tasks [ set size 0.7
                                set color green
                                set shape "circle" 
                                t4sk-set-typ3
                                set inter3st [inter3st] of myself
                                set time-required random 1000
                                set skill-required random 100
                                set modularity random 20 + 1 
                                set age 0 
                                set my-project myself 
                              ]
     set my-tasks-projects t4sks with [ my-project = myself ]
     set xcor 5
     ifelse inter3st < 50 [ set ycor -25 + inter3st ] [ set ycor -28 + inter3st]
     set size 2.5
     set color green - 2
     set shape "target" 
     set age 0 
     set likes-history []
     ask t4sks with [my-project = myself ] [ set xcor [xcor] of myself
                                             set ycor [ycor] of myself
                                             set heading random 360
                                             fd 1
                                            ]
    ifelse random-float 1 < 0.5 [ set my-product min-one-of products [distance myself]
                                  create-projectproductlink-with my-product [set color red] 
                                  ask projectproductlink-neighbors [ set mon-project lput myself mon-project ] ]
                                
                                [ set my-product nobody ] 
    
          ]
end

to project-hatch-a-project
  hatch-projects 1 [
        set count-new-projects count-new-projects + 1
        set num-tasks random 10 + 2
        set production-history []
        set reward-level random 100
        ifelse random-float 1 < prop-of-projects-reward-subjective [ set reward-type "subjective" ] 
                                                                   [ set reward-type "objective" ]
        ifelse inter3st > 3 [ set inter3st [inter3st ] of myself  + random 3 - random 3 ] [ set inter3st [inter3st ] of myself  + random 3 ]
        hatch-t4sks num-tasks [ set size 0.7
                                set color green
                                set shape "circle" 
                                t4sk-set-typ3
                                set inter3st [inter3st] of myself
                                set time-required random 1000
                                set skill-required random 100
                                set modularity random 20 + 1 
                                set age 0 
                                set my-project myself 
                              ]
     set my-tasks-projects t4sks with [ my-project = myself ]
     set xcor [xcor] of myself
     ifelse inter3st < 50 [ set ycor -25 + inter3st ] [ set ycor -28 + inter3st]
     set size 2.5
     set color green - 2
     set shape "target" 
     set age 0 
     set likes-history []
     ask t4sks with [my-project = myself ] [ set xcor [xcor] of myself
                                             set ycor [ycor] of myself
                                             set heading random 360
                                             fd 1
                                            ]
     if my-product != nobody [ create-projectproductlink-with my-product [set color red] 
                               ask projectproductlink-neighbors [ set mon-project lput myself mon-project ] ]
    
    ]
end


to birth-a-product
  
 if number-of-products = "one" [ hatch-products 1 [ set inter3st ( [ inter3st ] of myself )
                                            set xcor -10
                                            set ycor -25 + inter3st
                                            set size 2
                                            set color orange
                                            set shape "box"
                                            set volume random 100
                                            set age 0
                                            set mon-project (list (myself))
                                            set consumption-history []
                                            create-projectproductlink-with one-of mon-project [ set color red ]
                                            set new-products-count new-products-count + 1
                                           ] ]
 
 if number-of-products = "a few" [ hatch-products 1 [ set inter3st ( [ inter3st ] of myself )
                                            set xcor -10
                                            set ycor -25 + inter3st
                                            set size 2
                                            set color orange
                                            set shape "box"
                                            set volume random 100
                                            set age 0
                                            set mon-project (list (myself)) 
                                            set consumption-history []
                                            create-projectproductlink-with one-of mon-project [ set color red ]
                                            set new-products-count new-products-count + 1
                                           ]]
 
 if number-of-products = "many" [ hatch-products 1 [ set inter3st ( [ inter3st ] of myself )
                                            set xcor -10
                                            set ycor -25 + inter3st
                                            set size 2
                                            set color orange
                                            set shape "box"
                                            set volume random 100
                                            set age 0
                                            set mon-project (list (myself))
                                            set consumption-history []
                                            create-projectproductlink-with one-of mon-project [ set color red ]
                                            set new-products-count new-products-count + 1
                                           ] ]
end

to consume-products
  ;; #90s link to products they want to consume - non-rivalrous
  
  ask #90s [ if count consumerlink-neighbors < 3 and count products > 0 [ 
             let new-products products with [ not member? self [ consumerlink-neighbors ] of myself ]
             if count new-products > 0 AND ( random-float 1 < 0.01 OR count consumerlink-neighbors = 0 )
                [ create-consumerlink-with min-one-of new-products [ distance myself ] ] ] ] 
  
  ;; #90s consume
  ask #90s [
    set consumption consumption + ( prop-consumed-each-time * ( sum [ volume ] of consumerlink-neighbors ) )
           ]
  
  ; product sets consumption activity
  ask products [ if count my-consumerlinks > 0 [ 
                 set consumption-activity ( ( count my-consumerlinks / mean [ distance myself ] of consumerlink-neighbors ) * ( volume / mean [ volume ] of products ) )
                 set consumption-history lput ( ( count my-consumerlinks / mean [ distance myself ] of consumerlink-neighbors ) * ( volume / mean [ volume ] of products ) ) consumption-history
                 if length consumption-history = 11 [ set consumption-history but-first consumption-history ] ]

  ]
  
  ; random breaks in consumerlinks
  ask consumerlinks [ if random-float 1 < 0.1 [die] ]
  
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
  
end


to entry
  ; 90 enter if see high recent consumption activity
  
  if community-con-activity-t-10 != 0 [ 
  if (( community-con-activity-t-2 + 
        community-con-activity-t-1 + 
        community-con-activity-t ) / 3 )
        >
     (( community-con-activity-t-10 +
        community-con-activity-t-9 +
        community-con-activity-t-8 +
        community-con-activity-t-7 +
        community-con-activity-t-6 +
        community-con-activity-t-5 +
        community-con-activity-t-4 +
        community-con-activity-t-3 +
        community-con-activity-t-2 +
        community-con-activity-t-1 +
        community-con-activity-t ) / 11 ) * new-90s-barrier [
        
    create-#90s ( round ( initial-number-90s / 10 )) [
      set interest random num-interest-categories
      set xcor random 8 - 22
      set ycor -25 + interest    
      set size 1
      set color yellow
      set consumption 0
      set new-#90s-total new-#90s-total + 1
  ]]]
  
  ; 9 enter if see recent jump in consumption
  
   if (( community-con-activity-t-2 + 
         community-con-activity-t-1 + 
         community-con-activity-t ) / 3 ) 
        >
     (( community-con-activity-t-10 +
        community-con-activity-t-9 +
        community-con-activity-t-8 +
        community-con-activity-t-7 +
        community-con-activity-t-6 +
        community-con-activity-t-5 +
        community-con-activity-t-4 +
        community-con-activity-t-3 +
        community-con-activity-t-2 +
        community-con-activity-t-1 +
        community-con-activity-t ) / 11 ) * 1.5 [
        
    create-#9s round ( initial-number-9s / 10 ) [
      set interest random num-interest-categories
      set xcor ( random 6 ) + 19
      set ycor -25 + interest 
      set size 1
      set color blue
      set my-time 1 + random 20
      set time my-time
      set skill (n-of 3 (n-values num-skills [?]))
      let pref-prob random-float 1
      if pref-prob < 0.33 [ set typ3-preference "prod" ]
      if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
      if pref-prob >= 0.66 [ set typ3-preference "both" ]
      set using-platform? "true"
      set points 0 
      set thanks "not received"
      set my-projects (list (nobody))
      set my-tasks tasklink-neighbors
      
      ;; mentor and then get 3 friends via them
      
      let mentor min-one-of #1s [ distance myself ] 
      let mentors-friends count [ friendlink-neighbors ] of mentor
      create-friendlinks-with n-of ( mentors-friends / 2 ) [ friendlink-neighbors ] of mentor [set color blue] 
 
      set contribution-history-9s (list (0))
      set new-#9s-total new-#9s-total + 1
      set new-#9-attracted-by-#90s new-#9-attracted-by-#90s + 1 ] ]
 
     
  ; 1 how ? never?
  
  
  
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
end

to exit
  
  ; possible reasons?
  ; community feels too big and busy - 'i wont make a difference'
  ; why do people burn out
  
   ;; #9s exit if no tasks with my interest for a while 
   
  ask #9s [ if count my-tasklinks = 0 [ set time-with-no-links time-with-no-links + 1]
            if not any? t4sks with [ inter3st = [ interest ] of myself ] and random-float 1 < 0.01 [ 
              set #9s-left #9s-left + 1
              set #9-left-no-interest #9-left-no-interest + 1
              die ] 
          ]
  
  ;; 9s exit if consumption has dropped - ie., 90s have left, 
  
  ask #9s [
    if ((( community-con-activity-t-2 + 
        community-con-activity-t-1 + 
        community-con-activity-t ) / 3 ) 
        <
     (( community-con-activity-t-10 +
        community-con-activity-t-9 +
        community-con-activity-t-8 +
        community-con-activity-t-7 +
        community-con-activity-t-6 +
        community-con-activity-t-5 +
        community-con-activity-t-4 +
        community-con-activity-t-3 
         ) / 8 ) ) and random-float 1 < 0.01 
     [ set #9s-left #9s-left + 1
       set #9-left-drop-cons #9-left-drop-cons + 1
       die ] ]

  ;; #90s leave if no product i like and chance
  
  ask #90s [ if count my-consumerlinks = 0 [ set time-without-products time-without-products + 1 ]
             if ( not any? products with [ inter3st = [ interest ] of myself ] ) and 
                random-float 1 < 0.01 [
                    set #90s-left #90s-left + 1
                    set #90s-left-no-product #90s-left-no-product + 1 
                    die ]
           ]
  
  ;; #1s and #9s leave if motivation very low - this should now be like burnout described above - if thanks low...
  
  if reward-mechanism = "'thanks' only" or reward-mechanism = "both" [
    
   ask #1s [ if thanks = "not received" and random-float 1 < 0.001 [  set #1s-left #1s-left + 1
                                                                     set #1-left-burnout #1-left-burnout + 1
                                                                     die ]]
   
   ask #9s [ if thanks = "not received" and random-float 1 < 0.0005 [  set #9s-left #9s-left + 1
                                                                     set #9-left-burnout #9-left-burnout + 1
                                                                     die ]]
  
  ]
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
end

to change-breed
  
  
  
 ; 90 become 9 if they find a task close to their interest - and a very smal chance - ie., they find something on the list
 
 ; in the tool - with a small chance X 90 find a task (with similar interest and same skills they have ) and start to contribute...
 ; also change chance 90s check the list, 
 
 ask #90s [ if random-float 1 < 0.001 and ( any? t4sks with [ ( inter3st < [ interest ] of myself + 3 ) and
                                                             ( inter3st > [ interest ] of myself - 3 ) ] )
 
                            [   let task-i-found min-one-of t4sks [ ( abs ( inter3st - [ interest ] of myself ) )  ]
                                set breed #9s
                                ; set interest random num-interest-categories
                                set xcor ( random 6 ) + 19
                                set ycor -25 + interest
                                set size 1
                                set color blue
                                set my-time 1 + random 20
                                set time my-time
                                set skill (n-of 3 (n-values num-skills [?]))
                                set using-platform? "true"
                                let pref-prob random-float 1
                                if pref-prob < 0.33 [ set typ3-preference "prod" ]
                                if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
                                if pref-prob >= 0.66 [ set typ3-preference "both" ]
                                set points 0 
                                set thanks "not received"
                                create-tasklink-with task-i-found [set color 3]
                                set my-tasks tasklink-neighbors
                                
                                let new-project projects with [ member? task-i-found [ my-tasks-projects ] of self ]
                               
                                set my-projects (list (new-project))
                                
                                set contribution-history-9s (list (0))
                                
                                ask my-consumerlinks [die]
                                
                                set #90-to-#9-count #90-to-#9-count + 1
                              ]
              ] 

  

 
 ask #9s [ if length contribution-history-9s > 3 [ 
           let history-difference mean sublist contribution-history-9s (length contribution-history-9s - 3) (length contribution-history-9s ) - mean contribution-history-9s 
           if ( history-difference > 0 ) and ( random-float 1 < 0.01  )   [ 
     set breed #1s
     set xcor 18
     set ycor -25 + interest 
     set size 1.5
     set color red 
     set my-time 1 + random 40 
     set time my-time
     ; set skill (n-of 3 (n-values num-skills [?]))
     ; set interest random num-interest-categories
     set using-platform? "true"
     let pref-prob random-float 1
     if pref-prob < 0.33 [ set typ3-preference "prod" ]
     if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
     if pref-prob >= 0.66 [ set typ3-preference "both" ]
     ; set reward 0 
     set contribution-history-1s [ contribution-history-9s ] of self 
     set my-projects-1s [my-projects] of self
     set my-friends-1s [my-friends] of self
     set #9-to-#1-count #9-to-#1-count + 1 
     ]] ]
 
 ; #1s become #9s recent activity low plus a probability..
 
 ; could add- 1s also want to feel supported by communuty - thanks a proxy for this?, also number of friends, 
 
 ask #1s [ if length contribution-history-1s > 3 [ 
           let history-difference mean sublist contribution-history-1s (length contribution-history-1s - 3) (length contribution-history-1s ) - mean contribution-history-1s 
           if ( history-difference < 0 ) and ( random-float 1 < 0.01  ) [
     set breed #9s
     set xcor ( random 6 ) + 19
     set ycor -25 + interest
     set size 1
     set color blue
     set my-time 1 + random 20
     set time my-time
     ;set skill (n-of 3 (n-values num-skills [?]))
     set using-platform? "true"
     let pref-prob random-float 1
     if pref-prob < 0.33 [ set typ3-preference "prod" ]
     if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
     if pref-prob >= 0.66 [ set typ3-preference "both" ]
     ; set reward 0 
     set my-projects [my-projects-1s] of self
     set contribution-history-9s [contribution-history-1s] of self
     set my-friends [my-friends-1s] of self
                                
     set #1-to-#9-count #1-to-#9-count + 1 
     ]]]
end


;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 
;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 
;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 
;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 

to update-project-position
  

  
  ; change to be like product movement...
  
  ; this should be akin to how the list of projects in the platform is ordered - up votes (90,9,1 give support), crowd-funding, and acitivity, , important that change in both is relative to itself and speed of change, not to others (like reddit, twitter trending), 
  ; crowd funding analogy also - if project has just a few number of needs left to be done, it will be higher, ie., if, relative to total needs in the project, you have a few unfulfilled, the project will rise in the list.
  
  ; have on/off switches and weights for each - crowd funding, up votes, activity, effect on position.
  
  ask projects [ 
  
  ; recent contributor activity input to position
  ; production-history - gives number of contributor links divided by average distance for last 10 ticks
  
  ; increases in recent prod history will push up position
   
   if length production-history > 3 and mean production-history > 0  [ let history-difference mean sublist production-history (length production-history - 3) (length production-history ) - mean production-history
      if random-float 1 < 0.1 [ set xcor max list ( xcor + history-difference / ( mean production-history * 10) ) ( -4 ) ]]
  ]
      
      
  ; upvotes input
  ; with a probablity 1,9,90 give votes to projects with similar interest to theirs (but dont worry about skill etc)  
  ; this is then used to push up position if recent history if likes is up
      
  ask #1s [ let projects-i-like projects with [ inter3st < [ interest ] of myself + 3 and
                                                inter3st > [ interest ] of myself - 3 ] 
            
            if any? projects-i-like and random-float 1 < 0.1 [ ask projects-i-like [ set likes likes + 1 ] ] ]
  
  ask #9s [ let projects-i-like projects with [ inter3st < [ interest ] of myself + 3 and
                                                inter3st > [ interest ] of myself - 3 ] 
            
            if any? projects-i-like and random-float 1 < 0.1 [ ask projects-i-like [ set likes likes + 1 ] ] ]
              
  ask #90s [ let projects-i-like projects with [ inter3st < [ interest ] of myself + 3 and
                                                inter3st > [ interest ] of myself - 3 ] 
            
            if any? projects-i-like and random-float 1 < 0.1 [ ask projects-i-like [ set likes likes + 1 ] ] ]
      
  
  ask projects [ 
                 set likes-history lput likes likes-history 
                 if length likes-history = 11 [ set likes-history but-first likes-history ] 
  
      if length likes-history > 3 and mean likes-history > 0  [ let history-difference mean sublist likes-history (length likes-history - 3) (length likes-history ) - mean likes-history
      if random-float 1 < 0.1 [ set xcor max list ( xcor + history-difference / mean likes-history * 2 ) ( -4 ) ]] 
      
      
      
  ; crowd-funding input - i.e, if few tasks left - get pushed up the list
  
  if num-tasks < 3 [ set xcor xcor + 0.1 ]
  
      
      
      ; regulate position
     
      if xcor < -4 [ set xcor -4 ]
      if xcor > 17 [ set xcor 17 ]

  
]
  
  
;  ask projects [ if production-activity < 0.5 * mean [production-activity] of projects [ set xcor xcor - 1 ]
 ;                if production-activity > 1.5 * mean [production-activity] of projects [ set xcor xcor + 1 ]
 ;                if xcor < -4 [ set xcor -4 ]
 ;                if xcor > 17 [ set xcor 17 ]
 ; ]
  
  ask t4sks [ set xcor [ xcor ] of my-project
              set ycor [ ycor ] of my-project
              set heading random 360 
              fd 1           
            ]
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
end

to update-product-position
  
  ; product should move towards users, ie.. is more appealing, and will get high consumption activity score, 
  ;if...1) it has more users than it did in the past, 2) its related project has high activity (use volume or imporve products for this)
  
  ; some projects never finish, but do have a product, which is continually chanign as the project is worked on - to be implemented?
  
  ask products [
    
    ;; update position - activity from 90 and 9 on their project
    ;; if product dies dont update - just drift away
    
    ;; needed catch to avoid division by zero
    
      ; artefact? had to delay calculation until consumption hstory has 3 times
      if length consumption-history > 3 and mean consumption-history > 0  [ let history-difference mean sublist consumption-history (length consumption-history - 3) (length consumption-history ) - mean consumption-history
      if random-float 1 < 0.1 [ set xcor max list ( xcor - history-difference / mean consumption-history * 10 ) ( -14 ) ]]
      
    if xcor < -14 [ set xcor -14 ]
    if xcor > -6 [ set xcor -6 ]
  ]
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
end

to update-90s-and-9s-and-1s-positions
  
  ;; 9s and 90s get pulled close to their link-neighbours or similar
  
  ask #9s [ if count my-friendlinks > 0 [
    if mean [ycor] of friendlink-neighbors > ycor AND random-float 1 > 0.5 [ set ycor ycor + 1 ] 
    if mean [ycor] of friendlink-neighbors < ycor AND random-float 1 > 0.5 [ set ycor ycor - 1 ] 
    ]]
  
  ask #90s [ if count my-consumerlinks > 0 [
    let myconsumerlinkneighborslinkneighbors turtle-set [ consumerlink-neighbors ] of consumerlink-neighbors 
    if mean [ycor] of myconsumerlinkneighborslinkneighbors > ycor AND random-float 1 > 0.5 [ set ycor ycor + 1 ] 
    if mean [ycor] of myconsumerlinkneighborslinkneighbors < ycor AND random-float 1 > 0.5 [ set ycor ycor - 1 ] 
  ]]
  
  ; 1s move the same as 9s, but are more stubborn - less chance
  
  ask #1s [ if count my-friendlinks > 0 [
    if mean [ycor] of friendlink-neighbors > ycor AND random-float 1 > 0.8 [ set ycor ycor + 1 ] 
    if mean [ycor] of friendlink-neighbors < ycor AND random-float 1 > 0.8 [ set ycor ycor - 1 ] 
    ]]
  
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
end

to update-community-activity
  
  let total-prod-activity sum [production-activity] of projects
  let total-cons-activity sum [consumption-activity] of products 
  
  set community-prod-activity-t-10 community-prod-activity-t-9
  set community-prod-activity-t-9 community-prod-activity-t-8
  set community-prod-activity-t-8 community-prod-activity-t-7
  set community-prod-activity-t-7 community-prod-activity-t-6
  set community-prod-activity-t-6 community-prod-activity-t-5
  set community-prod-activity-t-5 community-prod-activity-t-4
  set community-prod-activity-t-4 community-prod-activity-t-3
  set community-prod-activity-t-3 community-prod-activity-t-2
  set community-prod-activity-t-2 community-prod-activity-t-1
  set community-prod-activity-t-1 community-prod-activity-t
  set community-prod-activity-t total-prod-activity
  
  set community-con-activity-t-10 community-con-activity-t-9
  set community-con-activity-t-9 community-con-activity-t-8
  set community-con-activity-t-8 community-con-activity-t-7
  set community-con-activity-t-7 community-con-activity-t-6
  set community-con-activity-t-6 community-con-activity-t-5
  set community-con-activity-t-5 community-con-activity-t-4
  set community-con-activity-t-4 community-con-activity-t-3
  set community-con-activity-t-3 community-con-activity-t-2
  set community-con-activity-t-2 community-con-activity-t-1
  set community-con-activity-t-1 community-con-activity-t
  set community-con-activity-t total-cons-activity
  
end

to products-die
  
  ask products [ if count my-consumerlinks = 0 [ 
                 if random-float 1 < 0.1 [ 
                   set product-had-no-consumer-so-left product-had-no-consumer-so-left + 1 
                   die ] ] ]
  
  if platform-features = FALSE and community-type = "online open" []
  if platform-features = FALSE and community-type = "online closed" []
  if platform-features = FALSE and community-type = "offline" []
  
  
end

to all-age
  ask #1s [ set time-in-community time-in-community + 1 ]
  ask #9s [ set time-in-community time-in-community + 1 ]
  ask #90s [ set time-in-community time-in-community + 1 ]
  ask t4sks [ set age age + 1 ]
  ask products [ set age age + 1 ]
  ask projects [ set age age + 1 ]
  ask tasklinks [ set ageL ageL + 1]
  ask consumerlinks [ set ageL ageL + 1]
  ask friendlinks [ set ageL ageL + 1]
end

to t4sk-set-typ3
  if count t4sks with [ my-project = [ my-project] of myself ] = 0 [ set typ3 random (num-skills - 1) ]
 
  if count t4sks with [ my-project = [ my-project] of myself ] > 0 [ ifelse random-float 1 > 0.5 [ set typ3 [ typ3 ] of one-of t4sks with [ my-project = [ my-project] of myself ]  ]
                                                                                                 [ set typ3 random  (num-skills - 1) ] ]
  
end
@#$#@#$#@
GRAPHICS-WINDOW
325
180
883
759
25
25
10.75
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
1
1
1
ticks
30.0

BUTTON
35
25
101
58
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

BUTTON
107
24
170
57
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
20
460
260
493
initial-number-1s
initial-number-1s
0
100
10
1
1
NIL
HORIZONTAL

SLIDER
20
496
259
529
initial-number-9s
initial-number-9s
0
1000
90
1
1
NIL
HORIZONTAL

SLIDER
19
613
259
646
initial-tasks
initial-tasks
0
100
10
1
1
NIL
HORIZONTAL

PLOT
975
70
1425
259
Size of Community
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
"#1s" 1.0 0 -2674135 true "" "plot count #1s"
"#9s" 1.0 0 -13345367 true "" "plot count #9s"
"#90s" 1.0 0 -1184463 true "" "plot count #90s"

PLOT
1809
895
2054
1070
Entry&Exit Per Tick
NIL
NIL
0.0
10.0
0.0
50.0
true
true
"" ""
PENS
"New#9s" 1.0 0 -6759204 true "" "if ticks > 0 [ plot new-#9s-total / ticks ]"
"New#90s" 1.0 0 -8330359 true "" "if ticks > 0 [ plot new-#90s-total / ticks]"
"Exit#90s" 1.0 0 -15040220 true "" "if ticks > 0 [ plot #90s-left / ticks]"
"Exit#9s" 1.0 0 -14730904 true "" "if ticks > 0 [ plot #9s-left / ticks]"

SLIDER
15
870
287
904
prop-of-projects-reward-subjective
prop-of-projects-reward-subjective
0
1
0.5
0.1
1
NIL
HORIZONTAL

PLOT
1443
1032
1603
1152
Tasks' TimeReq
NIL
NIL
0.0
1500.0
0.0
10.0
true
false
"" ""
PENS
"default" 100.0 1 -13840069 true "" "histogram [time-required] of t4sks"

PLOT
594
1018
754
1138
#1s' Points
NIL
NIL
0.0
1000.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -2674135 true "" "histogram [ points ] of #1s"

PLOT
1070
1040
1230
1160
#9s' Points
NIL
NIL
0.0
100.0
0.0
5.0
true
false
"" ""
PENS
"default" 1.0 1 -13345367 true "" "histogram [ points ] of #9s"

PLOT
1442
898
1602
1018
Projects' RewardLevel
NIL
NIL
0.0
100.0
0.0
10.0
true
false
"" ""
PENS
"default" 5.0 1 -13840069 true "" "histogram [reward-level] of projects"

PLOT
976
365
1426
515
Tasks&Products
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
"Tasks" 1.0 0 -10899396 true "" "plot count t4sks"
"Prod" 1.0 0 -955883 true "" "plot count products"
"Projects" 1.0 0 -15575016 true "" "plot count projects"

BUTTON
178
24
258
58
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

SLIDER
19
647
259
680
initial-products
initial-products
0
100
77
1
1
NIL
HORIZONTAL

SLIDER
20
530
260
563
initial-number-90s
initial-number-90s
0
5000
900
50
1
NIL
HORIZONTAL

PLOT
594
898
754
1018
#1s' Time
NIL
NIL
-50.0
40.0
0.0
10.0
true
false
"" ""
PENS
"default" 5.0 1 -2674135 true "" "histogram [ time ] of #1s"

PLOT
594
1155
754
1275
#9s' Time
NIL
NIL
-30.0
20.0
0.0
10.0
true
false
"" ""
PENS
"default" 5.0 1 -13345367 true "" "histogram [time] of #9s"

PLOT
2126
232
2364
352
Overtime
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
"#1s" 1.0 0 -2674135 true "" "plot count #1s with [ time < 0 ]"
"#9s" 1.0 0 -13345367 true "" "plot count #9s with [ time < 0 ]"

PLOT
750
1310
910
1430
#90s' Consumption
NIL
NIL
0.0
25.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -13840069 true "" "histogram [consumption] of #90s"

SLIDER
16
945
289
979
prop-consumed-each-time
prop-consumed-each-time
0
1
0.0010
0.001
1
NIL
HORIZONTAL

SLIDER
15
834
288
868
num-interest-categories
num-interest-categories
0
50
50
1
1
NIL
HORIZONTAL

PLOT
2123
69
2361
189
Ave No. Links
NIL
NIL
0.0
10.0
0.0
2.0
true
true
"" ""
PENS
"#1s" 1.0 0 -2674135 true "" "if count #1s > 0 [ plot mean [ count link-neighbors] of #1s ]"
"#9s" 1.0 0 -13345367 true "" "if count #9s > 0 [ plot mean [ count link-neighbors ] of #9s ]"
"#90s" 1.0 0 -13840069 true "" "if count #90s > 0 [ plot mean [ count link-neighbors ] of #90s ]"

BUTTON
33
63
260
96
Obey Power Law (based on 1s)
set initial-number-9s initial-number-1s * 9\nset initial-number-90s initial-number-1s * 90\nset initial-tasks initial-number-1s\nset initial-products initial-number-1s
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1325
260
1395
305
#90s Left
#90s-left
0
1
11

MONITOR
1190
260
1255
305
#9s Left
#9s-left
17
1
11

MONITOR
1125
260
1190
305
New #9s
new-#9s-total
0
1
11

MONITOR
1260
260
1325
305
New #90s
new-#90s-total
0
1
11

MONITOR
740
65
820
110
NIL
count #1s
0
1
11

MONITOR
820
65
890
110
NIL
count #9s
0
1
11

MONITOR
355
65
440
110
NIL
count #90s
0
1
11

MONITOR
540
50
635
95
NIL
count t4sks
0
1
11

MONITOR
445
50
540
95
NIL
count products
0
1
11

PLOT
1925
1098
2170
1248
ProdCons&TasksCompl
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
"Prod" 1.0 0 -955883 true "" "plot products-consumed"
"Tasks" 1.0 0 -13840069 true "" "plot tasks-completed"

PLOT
1925
1248
2170
1398
NewProd&Tasks
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
"Prod" 1.0 0 -955883 true "" "plot new-products-count"
"Tasks" 1.0 0 -13840069 true "" "plot new-tasks-count"
"Projects" 1.0 0 -15575016 true "" "plot count-new-projects"

MONITOR
1825
1158
1925
1203
NIL
products-consumed
0
1
11

MONITOR
1825
1202
1925
1247
NIL
tasks-completed
0
1
11

MONITOR
1821
1352
1926
1397
NIL
new-tasks-count
0
1
11

MONITOR
1821
1308
1926
1353
NIL
new-products-count
0
1
11

PLOT
754
898
914
1018
#1s' Skill
NIL
NIL
0.0
100.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -2674135 true "" "histogram [ skill ] of #1s"

PLOT
914
898
1074
1018
#1s' Interest
NIL
NIL
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -2674135 true "" "histogram [interest] of #1s"

PLOT
754
1155
914
1275
#9s' Skill
NIL
NIL
0.0
100.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -13345367 true "" "histogram [skill] of #9s"

PLOT
914
1155
1074
1275
#9s' Interest
NIL
NIL
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -13345367 true "" "histogram [interest] of #9s"

PLOT
1074
898
1234
1018
#1s' Time in Comm
NIL
NIL
0.0
500.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -2674135 true "" "histogram [time-in-community] of #1s"

PLOT
1074
1158
1234
1278
#9s' Time in Comm
NIL
NIL
0.0
250.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -13345367 true "" "histogram [time-in-community] of #9s"

PLOT
590
1310
750
1430
#90s' Interest
NIL
NIL
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -13840069 true "" "histogram [interest] of #90s"

PLOT
910
1310
1070
1430
#90s' Time in Comm
NIL
NIL
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 5.0 1 -13840069 true "" "histogram [time-in-community] of #90s"

PLOT
1600
1150
1760
1270
Tasks' Interest
NIL
NIL
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -13840069 true "" "histogram [inter3st] of t4sks"

PLOT
1282
898
1442
1018
Projects' RewardType
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
"Group" 1.0 0 -5825686 true "" "plot count projects with [reward-type = \"subjective\"]"
"Obj" 1.0 0 -7500403 true "" "plot count projects with [reward-type = \"objective\" ]"

PLOT
1603
1032
1763
1152
Tasks' SkillReq
NIL
NIL
0.0
100.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -13840069 true "" "histogram [skill-required] of t4sks"

PLOT
1283
1152
1443
1272
Tasks' Modularity
NIL
NIL
0.0
21.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -13840069 true "" "histogram [modularity] of t4sks"

PLOT
1443
1152
1603
1272
Tasks' Age
NIL
NIL
0.0
2000.0
0.0
10.0
true
false
"" ""
PENS
"default" 100.0 1 -13840069 true "" "histogram [age] of t4sks"

PLOT
1282
1288
1442
1408
Prod's Interest
NIL
NIL
0.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -955883 true "" "histogram [inter3st] of products"

PLOT
1442
1289
1602
1409
Prod's Age
NIL
NIL
0.0
200.0
0.0
10.0
true
false
"" ""
PENS
"default" 10.0 1 -955883 true "" "histogram [age] of products"

MONITOR
740
20
820
65
% #1s
( count #1s / ( count #1s + count #9s + count #90s )) * 100
1
1
11

MONITOR
820
20
890
65
% #9s
( count #9s / ( count #1s + count #9s + count #90s )) * 100
1
1
11

MONITOR
355
20
441
65
% #90s
( count #90s / ( count #1s + count #9s + count #90s )) * 100
1
1
11

PLOT
2126
488
2370
625
Long time Members
NIL
NIL
0.0
10.0
0.0
0.5
true
true
"" ""
PENS
"6 months" 1.0 0 -1264960 true "" "plot (( count #1s with [ time-in-community > 26 ] ) + ( count #9s with [ time-in-community > 26 ]) + ( count #90s with [ time-in-community > 26 ] )) / ( count #1s + count #9s + count #90s )"
"1 year" 1.0 0 -5825686 true "" "plot (( count #1s with [ time-in-community > 52 ] ) + ( count #9s with [ time-in-community > 52 ]) + ( count #90s with [ time-in-community > 52 ] )) / ( count #1s + count #9s + count #90s )"
"2 years" 1.0 0 -8431303 true "" "plot (( count #1s with [ time-in-community > 104 ] ) + ( count #9s with [ time-in-community > 104 ]) + ( count #90s with [ time-in-community > 104 ] )) / ( count #1s + count #9s + count #90s )"

PLOT
1809
223
2064
382
Why #9s Left
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
"no interest" 1.0 0 -16777216 true "" "plot #9-left-no-interest"
"Became #1" 1.0 0 -10899396 true "" "plot #9-to-#1-count"
"Cons Dop" 1.0 0 -7500403 true "" "plot #9-left-drop-cons"
"Burnout" 1.0 0 -955883 true "" "plot #9-left-burnout"

PLOT
1809
69
2064
219
Why #1s Left 
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
"BurntOut" 1.0 0 -16777216 true "" "plot #1-left-burnout"
"Became #9s" 1.0 0 -13345367 true "" "plot #1-to-#9-count"

PLOT
1809
543
2064
698
Why #9s and #90s Enter?
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
"#9s See #90s" 1.0 0 -955883 true "" "plot new-#9-attracted-by-#90s"
"#90s See Consumption " 1.0 0 -7500403 true "" "plot new-#90s-total"

TEXTBOX
30
765
350
809
---ADVANCED PARAMETERS---
14
0.0
1

TEXTBOX
15
130
285
148
---INPUT: PLATFORM FEATURES---
14
0.0
1

TEXTBOX
43
323
280
341
---INPUT: COMMUNITY TYPE---
14
0.0
1

TEXTBOX
975
30
1438
50
--------------------MAIN OUTPUTS-------------------
14
0.0
1

TEXTBOX
1819
29
2054
49
---OUTPUT: WHY EXIT/ENTER---
14
0.0
1

TEXTBOX
2116
28
2389
63
---OUTPUT: LINKS-STRUCTURE---
14
0.0
1

SLIDER
19
578
259
611
initial-projects
initial-projects
0
50
5
5
1
NIL
HORIZONTAL

TEXTBOX
905
211
920
752
^\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\ni\nn\nt\ne\nr\ne\ns\nt\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\nV\n
14
0.0
1

TEXTBOX
385
120
895
191
                 Products                                             \n                 <--More                      Projects\n#90s          Appealing-          ---Higher in list--->        #1s   #9s
15
0.0
1

SLIDER
15
908
288
942
chance-of-finding-new-task
chance-of-finding-new-task
0
1
0.0010
0.001
1
NIL
HORIZONTAL

PLOT
1600
898
1760
1019
HistoProjectsNumTasks
NIL
NIL
0.0
25.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -13840069 true "" "histogram [num-tasks] of projects"

MONITOR
1821
1266
1926
1311
NIL
count-new-projects
0
1
11

TEXTBOX
885
853
1390
872
-------UNINTERESTING OUTPUTS & DIAGNOSTICS----------
15
0.0
1

PLOT
976
636
1202
757
Aggregate Consumption
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
"10" 1.0 0 -16777216 true "" "plot community-con-activity-t-10"
"9" 1.0 0 -7500403 true "" "plot community-con-activity-t-9"
"8" 1.0 0 -2674135 true "" "plot community-con-activity-t-8"
"7" 1.0 0 -955883 true "" "plot community-con-activity-t-7"
"6" 1.0 0 -6459832 true "" "plot community-con-activity-t-6"
"5" 1.0 0 -1184463 true "" "plot community-con-activity-t-5"
"4" 1.0 0 -10899396 true "" "plot community-con-activity-t-4"
"3" 1.0 0 -13840069 true "" "plot community-con-activity-t-3"
"2" 1.0 0 -14835848 true "" "plot community-con-activity-t-2"
"1" 1.0 0 -11221820 true "" "plot community-con-activity-t-1"
"t" 1.0 0 -13791810 true "" "plot community-con-activity-t"

PLOT
1200
636
1426
757
Aggregate Production
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
"default" 1.0 0 -16777216 true "" "plot community-prod-activity-t-10"
"pen-1" 1.0 0 -7500403 true "" "plot community-prod-activity-t-9"
"pen-2" 1.0 0 -2674135 true "" "plot community-prod-activity-t-8"
"pen-3" 1.0 0 -955883 true "" "plot community-prod-activity-t-7"
"pen-4" 1.0 0 -6459832 true "" "plot community-prod-activity-t-6"
"pen-5" 1.0 0 -1184463 true "" "plot community-prod-activity-t-5"
"pen-6" 1.0 0 -10899396 true "" "plot community-prod-activity-t-4"
"pen-7" 1.0 0 -13840069 true "" "plot community-prod-activity-t-3"
"pen-8" 1.0 0 -14835848 true "" "plot community-prod-activity-t-2"
"pen-9" 1.0 0 -11221820 true "" "plot community-prod-activity-t-1"
"pen-10" 1.0 0 -13791810 true "" "plot community-prod-activity-t"

PLOT
976
516
1202
637
Count Links
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
"Task" 1.0 0 -7500403 true "" "plot count tasklinks"
"Friend" 1.0 0 -13345367 true "" "plot count friendlinks"
"Cons" 1.0 0 -13840069 true "" "plot count consumerlinks"

MONITOR
635
50
730
95
NIL
count projects
17
1
11

PLOT
1200
516
1426
637
AgesOfLinks
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
"Friend" 1.0 0 -13345367 true "" "if count friendlinks > 0 [ plot mean [ageL] of friendlinks ]"
"Consumer" 1.0 0 -13840069 true "" "if count consumerlinks > 0 [ plot mean [ageL] of consumerlinks ]"
"Task" 1.0 0 -7500403 true "" "if count tasklinks > 0 [ plot mean [ageL] of tasklinks ]"

CHOOSER
20
200
260
245
reward-mechanism
reward-mechanism
"'thanks' only" "'points' only" "both"
2

PLOT
1445
70
1785
255
Average Contributions Made
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
"No. Contributions 1s" 1.0 0 -2139308 true "" "if count #1s > 0 [ plot contributions-made-by-1s / count #1s ]"
"Time Contributed 1s (hrs)" 1.0 0 -8053223 true "" "if count #1s > 0 [ plot time-contributed-by-1s / count #1s ]"
"No. Contributions 9s" 1.0 0 -8275240 true "" "if count #9s > 0 [ plot contributions-made-by-9s / count #9s ]"
"Time Contributed 9s (hrs)" 1.0 0 -14730904 true "" "if count #9s > 0 [ plot time-contributed-by-9s / count #9s ]"

CHOOSER
20
350
260
395
community-type
community-type
"online" "offline"
0

CHOOSER
20
400
260
445
number-of-products
number-of-products
"one" "a few" "many"
2

PLOT
1445
625
1785
755
Dropped Projects&Tasks
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
"1 task" 1.0 0 -5298144 true "" "plot #1-dropped-a-task"
"9 task" 1.0 0 -14070903 true "" "plot #9-dropped-a-task"
"1 project" 1.0 0 -1069655 true "" "plot #1-dropped-a-project"
"9 project" 1.0 0 -5325092 true "" "plot #9-dropped-a-project"

PLOT
2128
358
2369
479
Projects Finished & Died
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
"Finshed" 1.0 0 -955883 true "" "plot projects-finished"
"Died" 1.0 0 -7500403 true "" "plot projects-died"

SWITCH
20
160
260
193
platform-features
platform-features
0
1
-1000

PLOT
1445
270
1785
445
ChangeRole
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
"#90->#9" 1.0 0 -16777216 true "" "plot #90-to-#9-count"
"#9->#1" 1.0 0 -7500403 true "" "plot #9-to-#1-count"
"#1->#9" 1.0 0 -2674135 true "" "plot #1-to-#9-count"

PLOT
1445
460
1785
610
ContributionsHisto
NIL
NIL
0.0
200.0
0.0
8.0
false
false
"" ""
PENS
"#9s" 1.0 1 -13791810 true "" "histogram [ my-total-contribution-9s ] of #9s"
"#1s" 1.0 1 -2139308 true "" "histogram [ my-total-contribution-1s ] of #1s"

PLOT
1809
389
2064
539
Why #90s Leave?
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
"No product 4 them" 1.0 0 -16777216 true "" "plot #90s-left-no-product"

MONITOR
1060
260
1122
305
#1s Left
#1s-left
0
1
11

SLIDER
20
250
260
283
proportion-using-platform
proportion-using-platform
0
1
1
0.1
1
NIL
HORIZONTAL

MONITOR
1000
260
1062
305
New #1s
#9-to-#1-count
0
1
11

SLIDER
16
796
286
829
new-90s-barrier
new-90s-barrier
0
5
1.5
0.25
1
NIL
HORIZONTAL

MONITOR
1326
306
1396
352
#90->#9
#90-to-#9-count
0
1
11

MONITOR
1192
306
1257
352
#9->#1
#9-to-#1-count
0
1
11

MONITOR
1062
305
1125
351
#1->#9
#1-to-#9-count
0
1
11

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
NetLogo 5.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="1st Calibration entry&amp;exit 1:9:90" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <final>export-interface (word "interface_from_run_number" behaviorspace-run-number ".png")</final>
    <timeLimit steps="600"/>
    <metric>count cores</metric>
    <metric>count peripheries</metric>
    <metric>count users</metric>
    <metric>count t4sks</metric>
    <metric>count products</metric>
    <metric>( count cores / ( count cores + count peripheries + count users )) * 100</metric>
    <metric>( count peripheries / ( count cores + count peripheries + count users )) * 100</metric>
    <metric>( count users / ( count cores + count peripheries + count users )) * 100</metric>
    <enumeratedValueSet variable="volume-req-to-attract-new-users">
      <value value="50"/>
      <value value="70"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="motivation-low-for-core-to-become-peri">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reward-mechanism">
      <value value="&quot;a&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oldness-of-peri-to-consider-exit">
      <value value="5"/>
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="chance-of-new-task">
      <value value="0.01"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="reward-for-peri-to-become-core">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="time-req-to-attract-new-peri">
      <value value="985"/>
      <value value="995"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-periphery-contributors">
      <value value="135"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="time-low-for-core-to-become-peri">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-consumed-each-time">
      <value value="0.0010"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-tasks">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="low-count-product-links-to-attract-new-users">
      <value value="2"/>
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="low-count-task-links-to-attract-new-peri">
      <value value="2"/>
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-tasks-on-platform">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="time-for-peri-to-become-core">
      <value value="52"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vision">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="motivation-threshold-for-core-to-leave">
      <value value="0.05"/>
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-core-contributors">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="inertia-before-exit">
      <value value="1"/>
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="peri-time-with-no-links-to-consider-leaving">
      <value value="1"/>
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-interest-categories">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-prod-per-task">
      <value value="15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="spatial-limit">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-users">
      <value value="1350"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-tasks-mngt">
      <value value="0.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prop-of-tasks-reward-group-decided">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="proportion-of-community-online">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="user-time-without-products-to-consider-leaving">
      <value value="1"/>
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="oldness-of-user-to-consider-exit">
      <value value="4"/>
      <value value="26"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initial-products">
      <value value="100"/>
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
