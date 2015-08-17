; Developed by Dr Peter G Johnson 2015 as part of the p2pvalue EU project

; Comments welcome - email: peter.johnson@surrey.ac.uk




; GENERAL TO DOS / COMMENTS / also check word doc



; pull out hidden parameters at some point!


; bug?! - 9s and 1s not making a tasklink when they have none, or is there good reason for this - no time or wrong interest - make sure


; calibration - 1% need to most contributions. maybe add a measure of actual contribution (time and number of projets/tasks) as an agent variable and can check average etc?


; currently 1s and 9s dont create projects? when and how do they do this? 1s create projects? 9s create projects?


; 9 -> 1 if their project is very popular ? (once 9 can create a project!)

  
; size of community will differentiate change in breed - ie., in small comms, you may bevome a 1 just by starting a project.


; size of community will affect a lot of rules? which?


; what should the position of product show when there is only one????


; exit rule - burn out/too old


; use volume in finding or staying with a product HOW? ie., consumption reduces volume in rivalrous products, 


; volume just doubles - sensible? how might it go down? should it be called quality?


; make frienndship ties increase chance of connecting to a task/project - how? write out logic first


; include variability on contribution to current tasks/projects? - you contribute more if recent activity high, or friends in that task?


; tasks/projects that are connnected? - task often come in groups and create groups of contributors - how would this be used?


; currentlt busy projects makes a new project, not more tasks, is this ok? tasks also have a small chance of making a new task in 'tasks-id'


; 90% or 9 (and 1s?) can also identify/create TASKS when they see issues? - currently high activity leads to new projects - catch all - should it be tasks, or should it be broek down by contributor type


; xcor of projects also affected by popularity of its adjoining product?


; PROJECTS / TASKS only fully public when need additional contribution, when they are OK, they go into semi-private mode - IE, no new contributors once 'full up'?


; updating motivation - size of project - large more likely to be able to make money, smaller communities less likely to deliver on this need


; currently completed tasks affect products, should it be projects?? probably




; in madrid

; how 1s and 9s pick to drop tasks when they are in overtime - is it those that are least popular, or have a lot of time left, or i have fewer friends working with

; can only drop one project at a time - can i make it more?



; data

; 2 + case studies - some initial conditions, type of community, and some patterns over time





;; from http://link.springer.com/chapter/10.1007/978-3-319-19003-7_4

;We, first, analyze the general structure of the social networks, e.g., graph distances and the degree distribution of the social networks. 
;Our social network structure analysis confirms a power-law degree distribution and small-world characteristics. However, the degree mixing 
;pattern shows that high degree nodes tend to connect more with low degree nodes suggesting a collaboration between experts and newbie developers. 
;We further conduct the same analysis on affiliation networks and find that contributors tend to participate in projects of similar team sizes. 
;Second, we study the correlation between various social factors (e.g., closeness and betweenness centrality, clustering coefficient and 
;tie strength) and the productivity of the contributors in terms of the amount of contribution and commitment to OSS projects. 

;power law degree distribution
; small world characteristics
; high degree and low degree do mix
; contrubutors tend to find all projects of siilar team sizes







; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters
; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters
; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters; Global Parameters


globals [
  
  ; platform-features                  ; chooser for current platform features turned on/off
  
  ; initial-number-#1s                 ; initial numbers of these agents
  ; initial-number-#9s
  ; initial-number-#90s
  ; initial-projects
  ; initial-tasks
  ; initial-products
  
  ; proportion-of-community-online      ; used if different rules for finding and contributing to tasks, and making friends,
                                        ; if some of community is offline
  
  ; spatial-limit                       ; means #1s and contributors can only see the tasks in their vision
  ; vision                              ; distance agents can 'see' to interact with others, when spatial-limit turned on
  
  ; num-interest-categories             ; number of discrete 'interest' categories
  
  ; prop-tasks-on-platform              ; proportion of tasks that are using the platform
  ; prop-tasks-mngt                     ; proportion of tasks that are classed as management tasks (attract different reward?)
  ; prop-of-tasks-reward-group-decided  ; proportion of tasks that have their reward decided by group that contributed to them
  
  ; chance-of-new-task                  ; chance on each timestep that a #1 creates a task
  
  ; prop-consumed-each-time             ; proportion of a product that is consumed by each #90 on each timestep
  
  ; num-prod-per-task                   ; max number of products produced per completed task (random x)
  
  #9s-left                              ; count of #9 who have left communuity
  #90s-left                             ; count of #90s who have left community
  
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
  
  #9-left-no-interest                   ; recording why #9 leave comm
  #9-left-#9-here
  #9-left-no-links-and-old
  #9-left-drop-cons
  
  #1-left-motivation                    ; recording why #1 left
  
  time-with-no-#1s                      ; recording ticks with no agents
  time-with-no-#9
  time-with-no-#90s
  time-with-no-products
  time-with-no-tasks
  
  new-#9-attracted-by-tasks             ; recording why #9 enter
  new-#9-attracted-by-#90s
    
  projects-died                         ; count of projects 'died'
  
  count-new-projects                    ; count new projects
  
  product-had-no-consumer-so-left       ; count of reasons why product 'died'
  
  contributions-made-by-1s                    ; count of indiviudal contributions made
  time-contributed-by-1s                     ; count of hours contributed
  contributions-made-by-9s                    ; count of indiviudal contributions made
  time-contributed-by-9s                     ; count of hours contributed
  
  #1-dropped-a-task
  #9-dropped-a-task
  
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
  my-time                      ; static time availability for community - random 40
  time                         ; current spare time available (not being used on tasks already)
  skill                        ; skill score - random 100
  interest                     ; interest score - random num-interest-categories
  motivation                   ; parameter derived from combination of desire variables below - used to decide how much to contribute?????
  typ3-preference              ; type of tasks preferred - prod, mngt, or both 
  using-platform?              ; yes/no - is the #1 using the platform?
  desire-for-money             ; score - how important is money to agent - NB community cannot offer money - ie., high des4money increases chance of leaving
  desire-for-collaboration     ; score - how important is collaboration for agent - goes up when not many collab, or friends
  desire-for-learning          ; score - decreases as time in comm goes up, higher scroe more likely to stay in community
  reward                       ; count reward received by agent
  time-in-community            ; count ticks/weeks spent in community
]

#9s-own [
  my-projects                  ; list (actual list) of projects 9 attached to
  my-tasks                     ; list (agentset) of tasks currently contributing to
  my-friends                   ; list (agentset) of other 9s currently friends with
  my-time                      ; static time availability for community - random 40
  time                         ; current spare time available (not being used on tasks already)
  skill                        ; skill score - random 100
  interest                     ; interest score - random num-interest-categories
  motivation                   ; parameter derived from combination of desire variables below - used to decide how much to contribute?????
  typ3-preference              ; prod, mngt, or both
  using-platform?              ; yes/no - is the #9 using the platform?
  desire-for-money             ; score - how important is money to agent - NB community cannot offer money - ie., high des4money increases chance of leaving
  desire-for-collaboration     ; score - how important is collaboration for agent - goes up when not many collab, or friends
  desire-for-learning          ; score - decreases as time in comm goes up, higher scroe more likely to stay in community
  reward                       ; count reward received by agent
  time-in-community            ; count ticks/weeks spent in community
  time-with-no-links           ; count ticks #9 has had no tasks
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
  recent-activity              ; score - count of current contributors to project's tasks
  time-project-with-no-contributors ; count ticks with no contributors to any of project's tasks
  age                          ; time task has been in community
  my-product
]

t4sks-own [
  my-project                   ; project task is within
  on-platform?                 ; yes/no - is the task on the platform?
  typ3                         ; mngt/prod - type of task, management or actual product - only prod tasks produce a product for #90s
  inter3st                     ; interest score - random num-interest-categories
  reward-level                 ; amount of reward random 100
  reward-type                  ; obj or group - how reward to each contributor is decided
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
  
  if platform-features = TRUE and how-community-works-without-platform = "online open" 
   [ ;; colour lines to mark projects and products spaces
     ask patches with [pxcor = 17 OR pxcor = -5 OR pxcor = -14  OR pxcor = -4] [set pcolor white]
     ;; set some globals to zero / reset-ticks
     setup-globals
     ;; create agents
     create-existing-product
     create-existing-projects
     if number-of-products = "one" [ set initial-products 1 ]
     if number-of-products = "a few" [ set initial-products random 5 + 1 ]  
     if number-of-products = "many" [ set initial-products random 100 ]      
     create-#1
     create-#9
     create-#90                           
     reset-ticks
   ]
  
  if platform-features = TRUE and how-community-works-without-platform = "online closed" []
  if platform-features = TRUE and how-community-works-without-platform = "offline" []
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
 
end

to go
  find-projects                   ;; contributors find projects
  find-tasks                      ;; contributors find tasks
  contribute-to-tasks             ;; contributors regulate the number of tasks they have, and contribute
  drop-tasks                      ;; contributors drop tasks if it is inactive
  drop-projects
  make-and-lose-friends           ;; friendships formed and broken
  give-out-reward                 ;; tasks give out reward depending on reward mechanism
  tasks-to-products               ;; completed tasks become products or improve existing ones - SHOULD THIS BE PROJECTS?
  tasks-identified                ;; creates new tasks from existing tasks, ie., find new ones by doing others
  tasks-finish                    ;; tasks finsih and 'die'
  projects-finish                 ;; projects 'die' if no contributors or tasks
  calc-recent-activity            ;; projects calculate recent-activity
  update-project-position         ;; projects get closer or further from 9s depending on recent activity
  new-projects                    ;; if projects have high activity they might produce another project
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
  update-motivation               ;; motivations shift over time depending on:
                                  ;; desire for money - higher if around long time and spend a lot of time in comm
                                  ;; desire for collab - high if low collab and vice versa
                                  ;; desire for learning - lower if been in comm long time
                                  ;; money up - wanna leave, collab up - wanna stay, learning up - wanna stay.    
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
      hatch-t4sks num-tasks [ 
                             set size 0.7
                             set color green
                             set shape "circle" 
                             
                             
                             ifelse random-float 1 < prop-tasks-on-platform [ set on-platform? true ] 
                                                                            [ set on-platform? false ]
                             
                             set inter3st [inter3st] of myself
                             set reward-level random 100
                             ifelse random-float 1 < prop-of-tasks-reward-group-decided [ set reward-type "group" ] 
                                                                                        [ set reward-type "objective" ]
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
    ask t4sks with [my-project = myself ] [ set xcor [xcor] of myself
                                            set ycor [ycor] of myself
                                            set heading random 360
                                            fd 1
                                           ]
    set my-product min-one-of products [distance myself]
    create-projectproductlink-with my-product [set color red] 
    
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
    set mon-project projectproductlink-neighbors
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
                                     set motivation 1
                                     set using-platform? "true"
                                     let pref-prob random-float 1
                                     if pref-prob < 0.33 [ set typ3-preference "prod" ]
                                     if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
                                     if pref-prob >= 0.66 [ set typ3-preference "both" ]
                                     set desire-for-money random-float 1
                                     set desire-for-collaboration random-float 1
                                     set desire-for-learning random-float 1
                                     set reward 0 
                                     set my-projects-1s (list (nobody))
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
                                   set motivation 1
                                   set using-platform? "true"
                                   set desire-for-money random-float 1
                                   set desire-for-collaboration random-float 1
                                   set desire-for-learning random-float 1
                                   set reward 0 
                                   set my-projects (list (nobody)) 
                                  ]
                                ]
end

to create-#90
  create-#90s initial-number-90s [
    set interest random num-interest-categories
    set xcor random 8 - 22
    set ycor -25 + interest
    set size 1
    set color yellow
    set consumption 0
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
  set #9-left-no-links-and-old 0
  set #1-left-motivation 0
  set time-with-no-#1s 0
  set time-with-no-#9 0
  set time-with-no-#90s 0
  set new-#9-attracted-by-tasks 0
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
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to find-tasks
  
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
                            create-tasklinks-with new-task$ [set color 3] ]
                     
                            set my-tasks tasklink-neighbors
                       ]
            ]
        ]
  
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to contribute-to-tasks
  
  ; update time availability, if no time left, drop tasks
 
   ask #1s [ set time my-time - sum [ modularity ] of tasklink-neighbors
             if time < 0 and count my-tasklinks > 1  [ set #1-dropped-a-task #1-dropped-a-task + 2
                                                       ask n-of 2 my-tasklinks [die] ]        
             set my-tasks-1s tasklink-neighbors
             
             set contributions-made-by-1s contributions-made-by-1s + count tasklink-neighbors
             set time-contributed-by-1s time-contributed-by-1s + ( my-time - time )
    
            ]
  
   ask #9s [ set time my-time - sum [ modularity ] of tasklink-neighbors
             if time < 0 and count my-tasklinks > 1  [ set #9-dropped-a-task #9-dropped-a-task + 2
                                                       ask n-of 2 my-tasklinks [die] ]        
             set my-tasks tasklink-neighbors
             
             set contributions-made-by-9s contributions-made-by-9s + count tasklink-neighbors
             set time-contributed-by-9s time-contributed-by-9s + ( my-time - time )
    
            ]
             
  ; contribute - task reduce their time by their contriubutors * modularity 
  
  ask t4sks [ set time-required time-required - (modularity * count tasklink-neighbors) 
            ]
  
  ; what about tasks that dont finish???
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to drop-tasks
  
  ; if tasks have only one contributor they record this
  
  ask t4sks with [ count tasklink-neighbors = 1 ] [ set time-only-one-contributor time-only-one-contributor + 1 ]
  
  
  ; 1s drop a task if they have been the only contributor
  
  ask #1s [ 
    if any? my-tasks-1s with [ time-only-one-contributor > 5 ]
        [ let lonely-tasks my-tasks-1s with [ time-only-one-contributor > 5  ]
          ask lonely-tasks [ set #1-dropped-a-task #1-dropped-a-task + (count my-tasklinks ) 
                             ask my-tasklinks [die ] ]
          set my-tasks-1s tasklink-neighbors ] ]
  
  ; 9s drop a task if they have been the only contributor
  
  ask #9s [ 
    if any? my-tasks with [ time-only-one-contributor > 5 ]
        [ let lonely-tasks my-tasks with [ time-only-one-contributor > 5  ]
          ask lonely-tasks [ set #9-dropped-a-task #9-dropped-a-task +  (count my-tasklinks )
                             ask my-tasklinks [die ] ]
          set my-tasks tasklink-neighbors 
           ] ]
  
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to drop-projects
  
  ; drop projects if i have no tasks in them and a certain chance
  
  ask #9s [ 
            if count ( turtle-set my-projects ) with [ not member? self  [  [my-project] of my-tasks ] of myself ] > 0 and random-float 1 < 0.2 [
            let projects-to-drop ( turtle-set my-projects ) with [not member? self [ [my-project] of my-tasks ] of myself ]  
            ;print who print my-projects print projects-to-drop
            set my-projects remove one-of projects-to-drop my-projects
            ;print my-projects
             ]]
    
    
  
  
 
end

to make-and-lose-friends
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
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
end

to give-out-reward
  if reward-mechanism = "default" [ ask t4sks [ if time-required <= 0 [ 
      if reward-type = "group" [ ask tasklink-neighbors [ set reward reward + random-normal ([ reward-level ] of myself) 20 ] ]
      if reward-type = "objective" [ ask tasklink-neighbors [ set reward reward + [ reward-level ] of myself ]] 
   ]]
  ]
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end
 
to tasks-finish
  
  ask t4sks [ if time-required <= 0 
    [ set tasks-completed tasks-completed + 1 
      ask turtle-set my-project [ set num-tasks num-tasks - 1 ]
      die 
    ]
            ]
  ask t4sks [ if my-project = nobody [die] ]
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to tasks-to-products
  
  if number-of-products = "one" [ ask t4sks [ if time-required <= 0 [   improve-current-products  ]] ]
  
  if number-of-products = "a few" [ ask t4sks [ if time-required <= 0 and count products > 4 [  improve-current-products   ]
                                                if time-required <= 0 and count products < 5 [  if typ3 = "prod" [ birth-a-product ] 
                                                                                                if typ3 = "mngt" [ improve-current-products ] 
                                                                                              ]
                                              ]
                                  ]
  
  if number-of-products = "many" [ ask t4sks [ if time-required <= 0 [  if typ3 = "prod" [ birth-a-product ] if typ3 = "mngt" [ improve-current-products ] ]] ]
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
end
   
to tasks-identified
   ask t4sks [ if count tasklink-neighbors > 0 [
      if chance-of-finding-new-task > random-float 1 [ create-new-task ] ] ] 
 
  ;; if more people are working on a task - more likley to create further tasks?
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
end
  
to create-new-task
  hatch-t4sks 1 [ set heading random 360
                 fd 1
                 set size 0.7
                 set color green
                 set shape "circle" 
                 ifelse random-float 1 < prop-tasks-on-platform [ set on-platform? true ] 
                                                                [ set on-platform? false ]
                 t4sk-set-typ3       
                 set inter3st [inter3st] of myself
                 set reward-level random 100
                 ifelse random-float 1 < prop-of-tasks-reward-group-decided [ set reward-type "group" ] [ set reward-type "objective" ]
                 set time-required random 1000
                 set skill-required random 100
                 set modularity random 20 + 1 
                 set age 0            
                 set my-project [my-project] of myself
                 set new-tasks-count new-tasks-count + 1 
                 ask turtle-set my-project [ set num-tasks num-tasks + 1 ]
               ]
end

to projects-finish
  
  ;; projects can linger without activity - may come back but unlikely - offline less likley to hang around
  
  ask projects [
    if num-tasks = 0 [ set time-project-with-no-tasks time-project-with-no-tasks + 1 ]
    if time-project-with-no-tasks > 20 [ ask turtle-set my-tasks-projects [ die ]                                     
                                         set projects-died projects-died + 1
                                         die
                                        ]
    
    if not any? #9s with [ member? myself my-projects ] and not any? #1s with [ member? myself my-projects-1s ] [
       set time-project-with-no-contributors time-project-with-no-contributors + 1 ]
       if time-project-with-no-contributors > 10 [ set projects-died projects-died + 1
                                                ask turtle-set my-tasks-projects [ die ]
                                                die 
                                              ]
    
  ]
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
end

to calc-recent-activity
  ask projects [ set my-tasks-projects t4sks with [ my-project = myself ]
                 set recent-activity sum [ count tasklink-neighbors ] of my-tasks-projects ] 
end

to new-projects
  
  ; projects can create other projects - if very active
  
  ask projects [ if recent-activity > 2 * mean [ recent-activity ] of projects AND random-float 1 < 0.01 [
      hatch-projects 1 [
        set count-new-projects count-new-projects + 1
        set num-tasks random 10 + 2
        set inter3st [inter3st ] of myself  + random 3 - random 3
        hatch-t4sks num-tasks [ set size 0.7
                                set color green
                                set shape "circle" 
                                ifelse random-float 1 < prop-tasks-on-platform [ set on-platform? true ] 
                                                                               [ set on-platform? false ]
                                t4sk-set-typ3
                                set inter3st [inter3st] of myself
                                set reward-level random 100
                                ifelse random-float 1 < prop-of-tasks-reward-group-decided [ set reward-type "group" ] 
                                                                                           [ set reward-type "objective" ]
                                set time-required random 1000
                                set skill-required random 100
                                set modularity random 20 + 1 
                                set age 0 
                                set my-project myself 
                              ]
     set my-tasks-projects t4sks with [ my-project = myself ]
     set xcor [xcor] of myself
     set ycor -25 + inter3st 
     set size 2.5
     set color green - 2
     set shape "target" 
     set age 0 
     ask t4sks with [my-project = myself ] [ set xcor [xcor] of myself
                                             set ycor [ycor] of myself
                                             set heading random 360
                                             fd 1
                                            ]
    
    ] ] ]
  
  ; projects can appear from 1s, 9s, or even 90s?
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end


to birth-a-product
  
 if number-of-products = "one" []
 
 if number-of-products = "a few" []
 
 if number-of-products = "many" [ hatch-products random num-prod-per-task [ set inter3st ( [ inter3st ] of myself )
                                            set xcor -10
                                            set ycor -25 + inter3st
                                            set size 2
                                            set color orange
                                            set shape "box"
                                            set volume random 100
                                            set age 0
                                            set mon-project [ my-project ] of myself 
                                            create-projectproductlink-with mon-project [ set color red ]
                                            set new-products-count new-products-count + 1
                                           ] ]
end

to consume-products
  ;; #90s link to products they want to consume - non-rivalrous
  
  ask #90s [ if count consumerlink-neighbors < 3 and count products > 0 [ 
             let new-products products with [ not member? self consumerlink-neighbors ]
             create-consumerlink-with min-one-of new-products [ distance myself ] ] ]
  
  ;; #90s consume
  ask #90s [
    set consumption consumption + ( prop-consumed-each-time * ( sum [ volume ] of consumerlink-neighbors ) )
           ]
  
  ; product is non-rivalrous, but a small chance it ceases to exist i
  ask products [ set consumption-activity ( count my-consumerlinks )
                 if random-float 1 < 0.01 [ die ] ]
  
  ; random breaks in consumerlinks
  ask consumerlinks [ if random-float 1 < 0.1 [die] ]
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
  
end


to entry
  ; 90 enter if see high recent consumption activity
  
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
        
    create-#90s ( round ( initial-number-90s / 10 )) [
      set interest random num-interest-categories
      set xcor random 8 - 22
      set ycor -25 + interest    
      set size 1
      set color yellow
      set consumption 0
      set new-#90s-total new-#90s-total + 1
  ]]
  
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
      set motivation 1
      set using-platform? "true"
      set desire-for-money random-float 1
      set desire-for-collaboration random-float 1
      set desire-for-learning random-float 1
      set reward 0 
      set my-projects (list (nobody))
      set new-#9s-total new-#9s-total + 1
      set new-#9-attracted-by-#90s new-#9-attracted-by-#90s + 1 ] ]
 
     ;; 9s enter if recent prod rise
     
      if (( community-prod-activity-t-2 + 
         community-prod-activity-t-1 + 
         community-prod-activity-t ) / 3 ) 
        >
     (( community-prod-activity-t-10 +
        community-prod-activity-t-9 +
        community-prod-activity-t-8 +
        community-prod-activity-t-7 +
        community-prod-activity-t-6 +
        community-prod-activity-t-5 +
        community-prod-activity-t-4 +
        community-prod-activity-t-3 +
        community-prod-activity-t-2 +
        community-prod-activity-t-1 +
        community-prod-activity-t ) / 11 ) * 1.5 [
        
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
      set motivation 1
      set using-platform? "true"
      set desire-for-money random-float 1
      set desire-for-collaboration random-float 1
      set desire-for-learning random-float 1
      set reward 0 
      set my-projects (list (nobody))
      set new-#9s-total new-#9s-total + 1 
      set new-#9-attracted-by-tasks new-#9-attracted-by-tasks + 1 ] ]
  
  ; 1 how ? 
  
  
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
end

to exit
  
  ; possible reasons?
  ; community feels too big and busy - 'i wont make a difference'
  ; why do people burn out
  
   ;; #9s exit if no tasks with my interest for a while 
   
  ask #9s [ if count my-tasklinks = 0 [ set time-with-no-links time-with-no-links + 1]
            if not any? t4sks with [ inter3st = [ interest ] of myself ] and ( time-with-no-links = #9s-time-with-no-links-to-consider-leaving ) [ 
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

  ;; #90s leave if no product i like for a while
  
  ask #90s [ if count my-consumerlinks = 0 [ set time-without-products time-without-products + 1 ]
             if ( not any? products with [ inter3st = [ interest ] of myself ] ) and 
                ( time-without-products = #90s-time-without-products-to-consider-leaving ) [
                    set #90s-left #90s-left + 1
                    die ]
           ]
  
  ;; #1s leave if motivation very low
  
  ask #1s [ if motivation < motivation-threshold-for-1s-to-leave [ 
            set #1-left-motivation #1-left-motivation + 1
            die ]
          ]
  
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
end

to new-tasks
  
  ;;NB not currently used
  ;; #1s randomly hatch new tasks
  
  ask #1s [ if random-float 1 < chance-of-new-task [ hatch-t4sks 1 [
    set xcor random 10 - random 10
    set ycor random 10 - random 10
    fd random 10
    set size 0.7
    set color green
    set shape "circle" 
    ifelse random-float 1 < prop-tasks-on-platform [ set on-platform? true ] 
                                                   [ set on-platform? false ]
    t4sk-set-typ3
    set inter3st ( [ interest ] of myself)
    set reward-level random 100
    ifelse random-float 1 < prop-of-tasks-reward-group-decided [ set reward-type "group" ] 
                                                               [ set reward-type "objective" ]
    set time-required random 1000
    set skill-required random 100
    set modularity random 40 
    set age 0
    set new-tasks-count new-tasks-count + 1 ]
  ]]
  
end

to change-breed
  
  
  
 ; 90 become 9 if they make a new project when products have interest near them, but not quite right, and have high consumption and high time
 
 ask #90s [ if any? products with [ ( inter3st < [ interest ] of myself + 5 ) and
                                    ( inter3st > [ interest ] of myself - 5 ) and
                                    ( inter3st != [ interest ] of myself + 1 ) and
                                    ( inter3st != [ interest ] of myself - 1) and
                                    ( inter3st != [ interest ] of myself ) ]
                              and ( consumption > 1.2 * mean [consumption] of #90s )
                              and ( time-in-community > 1.5 * mean [time-in-community ]of #90s) 
                            [ set breed #9s
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
                                set motivation 1
                                set desire-for-money random-float 1
                                set desire-for-collaboration random-float 1
                                set desire-for-learning random-float 1
                                set reward 0 
                                set my-projects (list (nobody)) 
                                
                                set #90-to-#9-count #90-to-#9-count + 1
                                
                                hatch-projects 1 [
                                                   set count-new-projects count-new-projects + 1
                                                   set num-tasks random 10 + 2
                                                   set inter3st [ interest ] of myself + random 3 - random 3
                                                   hatch-t4sks num-tasks [ set size 0.7
                                                                           set color green
                                                                           set shape "circle" 
                                                                           ifelse random-float 1 < prop-tasks-on-platform [ set on-platform? true ] 
                                                                                                                          [ set on-platform? false ]
                                                                           t4sk-set-typ3
                                                                           set inter3st [inter3st] of myself
                                                                           set reward-level random 100
                                                                           ifelse random-float 1 < prop-of-tasks-reward-group-decided [ set reward-type "group" ] 
                                                                                                                                      [ set reward-type "objective" ]
                                                                           set time-required random 1000
                                                                           set skill-required random 100
                                                                           set modularity random 20 + 1 
                                                                           set age 0 
                                                                           set my-project myself 
                                                                         ]  
                                                    set my-tasks-projects t4sks with [ my-project = myself ]
                                                    set xcor [xcor] of myself
                                                    set ycor -25 + inter3st 
                                                    set size 2.5
                                                    set color green - 2
                                                    set shape "target" 
                                                    set age 0 
                                                    ask t4sks with [my-project = myself ] [ set xcor [xcor] of myself
                                                                                            set ycor [ycor] of myself
                                                                                            set heading random 360
                                                                                            fd 1
                                                                                          ]
    
                                                 ] 
                                
                               ]]


  ; #9 become #1 if they have high reward, or have been around a long time
 
 ask #9s [ if ( reward > reward-for-9s-to-become-1s ) and ( time-in-community > time-for-9s-to-become-1s  ) [ 
     set breed #1s
     set xcor 18
     set ycor -25 + interest 
     set size 1.5
     set color red 
     set my-time 1 + random 40 
     set time my-time
     set skill (n-of 3 (n-values num-skills [?]))
     set interest random num-interest-categories
     set motivation 1
     set using-platform? "true"
     let pref-prob random-float 1
     if pref-prob < 0.33 [ set typ3-preference "prod" ]
     if pref-prob >= 0.33 and pref-prob < 0.66 [ set typ3-preference "mngt" ]
     if pref-prob >= 0.66 [ set typ3-preference "both" ]
     set desire-for-money random-float 1
     set desire-for-collaboration random-float 1
     set desire-for-learning random-float 1
     set reward 0 
     set my-projects-1s (list (nobody))
     set #9-to-#1-count #9-to-#1-count + 1 
     ]]
 
 ; #1s become #9s if motivation low
 
 ask #1s [ if ( motivation < motivation-low-for-1s-to-become-9s ) and ( my-time < time-low-for-1s-to-become-9s ) [
     set breed #9s
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
     set motivation 1
     set desire-for-money random-float 1
     set desire-for-collaboration random-float 1
     set desire-for-learning random-float 1
     set reward 0 
     set my-projects (list (nobody)) 
                                
     set #1-to-#9-count #1-to-#9-count + 1 
     ]]
end

to improve-current-products
  
  ifelse number-of-products = "many" [ ask products with [ mon-project = [ my-project ] of myself ] [ set volume volume + volume ] ]
                                     [ ask products with [ member? [ my-project ] of myself mon-project ] [ set volume volume + volume ] ]
  
end


;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 
;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 
;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 
;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations ;; Update Positions and Calculations 

to update-project-position
  
  ; project gets closer to right if in 
  
  ask projects [ if recent-activity < 0.5 * mean [recent-activity] of projects [ set xcor xcor - 1 ]
                 if recent-activity > 1.5 * mean [recent-activity] of projects [ set xcor xcor + 1 ]
                 if xcor < -4 [ set xcor -4 ]
                 if xcor > 17 [ set xcor 17 ]
  ]
  
  ask t4sks [ set xcor [ xcor ] of my-project
              set ycor [ ycor ] of my-project
              set heading random 360 
              fd 1           
            ]
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to update-product-position
  
  ; some projects never finish, but do have a product, which is continually chanign as the project is worked on - to be implemented?
  
  ask products [
    
    ;; update position - activity from 90 and 9 on their project
    ;; if product dies dont update - just drift away
    
    if number-of-products = "one" [ ifelse count turtle-set mon-project > 0 [ if consumption-activity < 0.5 * mean [consumption-activity] of products OR 
                                    mean [ recent-activity ] of mon-project < 0.5 * mean [recent-activity] of projects [ set xcor xcor + 1 ]
                                   if consumption-activity > 1.5 * mean [consumption-activity] of products OR 
                                    mean [ recent-activity ] of mon-project > 1.5 * mean [recent-activity] of projects [ set xcor xcor - 1 ] 
                                 ]
     [ set xcor xcor + 1 ] ]
     
      if number-of-products = "a few" [ ifelse count turtle-set mon-project > 0 [ if consumption-activity < 0.5 * mean [consumption-activity] of products OR 
                                    mean [ recent-activity ] of mon-project < 0.5 * mean [recent-activity] of projects [ set xcor xcor + 1 ]
                                   if consumption-activity > 1.5 * mean [consumption-activity] of products OR 
                                    mean [ recent-activity ] of mon-project > 1.5 * mean [recent-activity] of projects [ set xcor xcor - 1 ] 
                                 ]
     [ set xcor xcor + 1 ] ]
      
      if number-of-products = "many" [ ifelse count turtle-set mon-project > 0 [ if consumption-activity < 0.5 * mean [consumption-activity] of products OR 
                                     [ recent-activity ] of mon-project < 0.5 * mean [recent-activity] of projects [ set xcor xcor + 1 ]
                                   if consumption-activity > 1.5 * mean [consumption-activity] of products OR 
                                     [ recent-activity ] of mon-project > 1.5 * mean [recent-activity] of projects [ set xcor xcor - 1 ] 
                                 ]
     [ set xcor xcor + 1 ] ]
     
     
      
    if xcor < -14 [ set xcor -14 ]
    if xcor > -6 [ set xcor -6 ]
  ]
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
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
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to update-community-activity
  
  let total-prod-activity sum [recent-activity] of projects
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
  
  ask products [ if count my-consumerlinks = 0 [ set time-with-no-consumers time-with-no-consumers + 1 ]
                 if time-with-no-consumers > 10 [ 
                   set product-had-no-consumer-so-left product-had-no-consumer-so-left + 1 
                   die ] ]
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
  
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

to update-motivation
  ask #1s [
    
    ; desire for money goes up with time in community and my-time
    
    if ( my-time > 20 ) and ( time-in-community > 300 ) [ set desire-for-money ( desire-for-money * 1.1 ) ]
    
    ; desire for collab goes up/down depending on current level of collab
    
    if count my-friendlinks > 10 [ set desire-for-collaboration ( desire-for-collaboration * 0.9 ) ]
    if count my-friendlinks < 10 [ set desire-for-collaboration ( desire-for-collaboration * 1.1 ) ]
    
    ; desire for learning goes down as experience more in comm
    
    if time-in-community > 300 [ set desire-for-learning ( desire-for-learning * 0.9 ) ]
    
    ; regulate values between 0 and 1
    
    if desire-for-money < 0 [ set desire-for-money 0 ]
    if desire-for-money > 1 [ set desire-for-money 1 ]
    
    if desire-for-collaboration < 0 [ set desire-for-collaboration 0 ]
    if desire-for-collaboration > 1 [ set desire-for-collaboration 1 ]
    
    if desire-for-learning < 0 [ set desire-for-learning 0 ]
    if desire-for-learning > 1 [ set desire-for-learning 1 ]
    
    ; calculate motivatin - learning and collaboration increase it - money decreases it.
    
    set motivation ( ( desire-for-learning + desire-for-collaboration - desire-for-money ) / 3 )
    ]
  
  ask #9s [
    ; desire for money goes up with time in community and my-time
    
    if ( my-time > 10 ) and ( time-in-community > 100 ) [ set desire-for-money ( desire-for-money * 1.1 ) ]
    
    ; desire for collab goes up/down depending on current level of collab
    
    if count my-friendlinks > 10 [ set desire-for-collaboration ( desire-for-collaboration * 0.9 ) ]
    if count my-friendlinks < 10 [ set desire-for-collaboration ( desire-for-collaboration * 1.1 ) ]
    
    ; desire for learning goes down as experience more in comm
    
    if time-in-community > 150 [ set desire-for-learning ( desire-for-learning * 0.9 ) ]
    
    ; regulate values between 0 and 1
    
    if desire-for-money < 0 [ set desire-for-money 0 ]
    if desire-for-money > 1 [ set desire-for-money 1 ]
    
    if desire-for-collaboration < 0 [ set desire-for-collaboration 0 ]
    if desire-for-collaboration > 1 [ set desire-for-collaboration 1 ]
    
    if desire-for-learning < 0 [ set desire-for-learning 0 ]
    if desire-for-learning > 1 [ set desire-for-learning 1 ]
    
    ; calculate motivatin - learning and collaboration increase it - money decreases it.
    
    set motivation ( ( desire-for-learning + desire-for-collaboration - desire-for-money ) / 3 )]
  
  
  if platform-features = FALSE and how-community-works-without-platform = "online open" []
  if platform-features = FALSE and how-community-works-without-platform = "online closed" []
  if platform-features = FALSE and how-community-works-without-platform = "offline" []
  
end

to t4sk-set-typ3
  if count t4sks with [ my-project = [ my-project] of myself ] = 0 [ set typ3 random (num-skills - 1) ]
 
  if count t4sks with [ my-project = [ my-project] of myself ] > 0 [ ifelse random-float 1 > 0.5 [ set typ3 [ typ3 ] of one-of t4sks with [ my-project = [ my-project] of myself ]  ]
                                                                                                 [ set typ3 random  (num-skills - 1) ] ]
  
end
@#$#@#$#@
GRAPHICS-WINDOW
280
90
838
669
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
1073
74
1523
263
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
2008
1029
2253
1204
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
20
785
260
818
proportion-of-community-online
proportion-of-community-online
0
1
0.41
0.01
1
NIL
HORIZONTAL

SLIDER
20
750
260
783
prop-tasks-on-platform
prop-tasks-on-platform
0
1
0.2
0.1
1
NIL
HORIZONTAL

SLIDER
40
1032
280
1065
prop-tasks-mngt
prop-tasks-mngt
0
1
0.3
0.1
1
NIL
HORIZONTAL

SLIDER
40
1067
280
1100
prop-of-tasks-reward-group-decided
prop-of-tasks-reward-group-decided
0
1
0.5
0.1
1
NIL
HORIZONTAL

PLOT
754
1275
914
1395
#9s' Des4Money
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.1 1 -13345367 true "" "histogram [desire-for-money] of #9s"

SLIDER
158
265
271
298
vision
vision
0
50
9
1
1
NIL
HORIZONTAL

PLOT
1442
1018
1602
1138
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
#1s' Reward
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
"default" 10.0 1 -2674135 true "" "histogram [ reward ] of #1s"

PLOT
594
1275
754
1395
#9s' Reward
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
"default" 1.0 1 -13345367 true "" "histogram [ reward ] of #9s"

PLOT
1282
1018
1442
1138
Tasks' RewardLevel
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
"default" 5.0 1 -13840069 true "" "histogram [reward-level] of t4sks"

PLOT
1060
330
1305
480
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
1
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
2280
600
2518
720
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
"Peri" 1.0 0 -13345367 true "" "plot count #9s with [ time < 0 ]"

PLOT
752
1418
912
1538
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
39
1213
359
1246
prop-consumed-each-time
prop-consumed-each-time
0
1
0.0010
0.001
1
NIL
HORIZONTAL

PLOT
2264
359
2501
479
Ave No. Links
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
"Tasks" 1.0 0 -13840069 true "" "if count t4sks > 0 [ plot mean [count link-neighbors] of t4sks ]"
"Prod" 1.0 0 -955883 true "" "if count products > 0 [ plot mean [count link-neighbors] of products ]"

SLIDER
40
1102
280
1135
chance-of-new-task
chance-of-new-task
0
0.5
0.01
0.01
1
NIL
HORIZONTAL

SLIDER
19
697
259
730
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
2264
239
2502
359
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
1394
270
1494
315
NIL
#90s-left
0
1
11

MONITOR
1190
270
1290
315
NIL
#9s-left
17
1
11

MONITOR
1088
269
1190
314
NIL
new-#9s-total
0
1
11

MONITOR
1290
270
1397
315
NIL
new-#90s-total
0
1
11

MONITOR
954
193
1052
238
NIL
count #1s
0
1
11

MONITOR
954
239
1052
284
NIL
count #9s
0
1
11

MONITOR
954
283
1052
328
NIL
count #90s
0
1
11

MONITOR
949
423
1048
468
NIL
count t4sks
0
1
11

MONITOR
949
378
1049
423
NIL
count products
0
1
11

PLOT
2378
900
2623
1050
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
2378
1050
2623
1200
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
2278
960
2378
1005
NIL
products-consumed
0
1
11

MONITOR
2278
1004
2378
1049
NIL
tasks-completed
0
1
11

MONITOR
2273
1154
2378
1199
NIL
new-tasks-count
0
1
11

MONITOR
2273
1110
2378
1155
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
754
1018
914
1138
#1s' Des4Money
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.1 1 -2674135 true "" "histogram [desire-for-money] of #1s"

PLOT
914
1018
1074
1138
#1s' Des4Collab
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.1 1 -2674135 true "" "histogram [desire-for-collaboration] of #1s"

PLOT
1074
1018
1234
1138
#1s' Des4Learning
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.1 1 -2674135 true "" "histogram [desire-for-learning] of #1s"

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
914
1275
1074
1395
#9s Des4Collab
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.1 1 -13345367 true "" "histogram [desire-for-collaboration] of #9s"

PLOT
1074
1278
1234
1398
#9s' Des4Learning
NIL
NIL
0.0
1.0
0.0
10.0
true
false
"" ""
PENS
"default" 0.1 1 -13345367 true "" "histogram [desire-for-learning] of #9s"

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
592
1418
752
1538
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
912
1418
1072
1538
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
1282
898
1442
1018
Tasks' Type
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
"Mngt" 1.0 0 -5825686 true "" "plot count t4sks with [typ3 = \"mngt\"]"
"Prod" 1.0 0 -7500403 true "" "plot count t4sks with [typ3 = \"prod\"]"

PLOT
1602
898
1762
1018
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
1442
898
1602
1018
Tasks' RewardType
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
"Group" 1.0 0 -5825686 true "" "plot count t4sks with [reward-type = \"group\"]"
"Obj" 1.0 0 -7500403 true "" "plot count t4sks with [reward-type = \"objective\" ]"

PLOT
1602
1018
1762
1138
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
1282
1138
1442
1258
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
1442
1138
1602
1258
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
1288
1602
1408
Prod's Volume
NIL
NIL
0.0
100000.0
0.0
10.0
true
false
"" ""
PENS
"default" 1000.0 1 -955883 true "" "histogram [volume] of products"

PLOT
1602
1288
1762
1408
Prod's Age
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
"default" 10.0 1 -955883 true "" "histogram [age] of products"

SLIDER
39
1253
361
1286
num-prod-per-task
num-prod-per-task
0
50
15
1
1
NIL
HORIZONTAL

SWITCH
28
265
160
298
spatial-limit
spatial-limit
0
1
-1000

MONITOR
594
838
724
883
NIL
#9-to-#1-count
0
1
11

MONITOR
727
838
857
883
NIL
#1-to-#9-count
0
1
11

MONITOR
958
38
1038
83
% #1s
( count #1s / ( count #1s + count #9s + count #90s )) * 100
1
1
11

MONITOR
958
83
1028
128
% #9s
( count #9s / ( count #1s + count #9s + count #90s )) * 100
1
1
11

MONITOR
958
127
1044
172
% #90s
( count #90s / ( count #1s + count #9s + count #90s )) * 100
1
1
11

PLOT
2264
478
2501
598
No. Links
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
"#1s" 1.0 0 -2674135 true "" "plot sum [ count my-links] of #1s"
"#9s" 1.0 0 -13345367 true "" "plot sum [ count my-links] of #9s"
"#90s" 1.0 0 -13840069 true "" "plot sum [count my-links] of #90s"

PLOT
2008
893
2252
1030
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
2010
417
2254
537
Why #9s Leave
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
"#9 here" 1.0 0 -13345367 true "" "plot #9-left-#9-here"
"no links & old" 1.0 0 -2674135 true "" "plot #9-left-no-links-and-old"
"Became #1" 1.0 0 -10899396 true "" "plot #9-to-#1-count"
"Cons Dop" 1.0 0 -7500403 true "" "plot #9-left-drop-cons"

PLOT
2010
708
2255
845
Motivation
NIL
NIL
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"#1s" 1.0 0 -2674135 true "" "if count #1s > 0 [plot mean [motivation] of #1s ]"
"#9s" 1.0 0 -13345367 true "" "if count #9s > 0 [plot mean [motivation] of #9s ]"

PLOT
2010
237
2254
416
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
"Motiv" 1.0 0 -16777216 true "" "plot #1-left-motivation"
"Became #9s" 1.0 0 -13345367 true "" "plot #1-to-#9-count"

SLIDER
38
897
362
930
#9s-time-with-no-links-to-consider-leaving
#9s-time-with-no-links-to-consider-leaving
1
10
10
1
1
NIL
HORIZONTAL

SLIDER
38
928
395
961
#90s-time-without-products-to-consider-leaving
#90s-time-without-products-to-consider-leaving
1
10
5
1
1
NIL
HORIZONTAL

SLIDER
38
962
450
995
motivation-threshold-for-1s-to-leave
motivation-threshold-for-1s-to-leave
0
0.1
0.05
0.01
1
NIL
HORIZONTAL

SLIDER
39
1318
363
1351
reward-for-9s-to-become-1s
reward-for-9s-to-become-1s
0
500
100
10
1
NIL
HORIZONTAL

SLIDER
39
1355
364
1388
time-for-9s-to-become-1s
time-for-9s-to-become-1s
0
208
51
1
1
NIL
HORIZONTAL

SLIDER
39
1388
364
1421
motivation-low-for-1s-to-become-9s
motivation-low-for-1s-to-become-9s
0
0.5
0.19
0.01
1
NIL
HORIZONTAL

SLIDER
39
1425
364
1458
time-low-for-1s-to-become-9s
time-low-for-1s-to-become-9s
0
50
10
1
1
NIL
HORIZONTAL

TEXTBOX
80
872
247
890
entry&exit parameters
14
0.0
1

TEXTBOX
119
1008
251
1028
task parameters
14
0.0
1

TEXTBOX
120
1188
287
1208
product parameters
14
0.0
1

TEXTBOX
102
1297
329
1324
switching breed parameters
14
0.0
1

PLOT
2010
535
2256
708
Why #9s Enter?
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
"See Tasks" 1.0 0 -13840069 true "" "plot new-#9-attracted-by-tasks"
"See #90s" 1.0 0 -955883 true "" "plot new-#9-attracted-by-#90s"

TEXTBOX
47
830
367
874
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
1073
34
1536
54
--------------------MAIN OUTPUTS-------------------
14
0.0
1

TEXTBOX
2023
204
2252
224
---OUTPUT: WHY EXIT/ENTER---
14
0.0
1

TEXTBOX
2257
198
2530
233
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
860
215
875
585
^\n|\n|\n|\n|\n|\n|\ni\nn\nt\ne\nr\ne\ns\nt\n|\n|\n|\n|\n|\n|\nV\n
14
0.0
1

TEXTBOX
345
680
855
753
90          Products                      Projects                      1      9 \n                <--More         ---More recent activity-->\n               Appealing-
15
0.0
1

SLIDER
40
1135
267
1168
chance-of-finding-new-task
chance-of-finding-new-task
0
1
0.01
0.01
1
NIL
HORIZONTAL

PLOT
1305
329
1540
479
HistoNumTasks
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
2273
1068
2378
1113
NIL
count-new-projects
0
1
11

PLOT
1805
898
1965
1023
HistoProjectsActivity
NIL
NIL
-10.0
50.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 1 -16777216 true "" "histogram [recent-activity] of projects"

PLOT
1219
1428
1379
1548
TypePref
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
"Prod" 1.0 0 -16777216 true "" "plot count #9s with [typ3-preference = \"prod\"]"
"Mngt" 1.0 0 -7500403 true "" "plot count #9s with [typ3-preference = \"mngt\"]"
"Both" 1.0 0 -2674135 true "" "plot count #9s with [typ3-preference = \"both\"]"

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
1060
630
1300
750
ConsumptionActivity
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
1300
635
1535
755
ProductionActivity
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
1058
483
1302
633
Links
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
"tasklinks" 1.0 0 -7500403 true "" "plot count tasklinks"
"friendlinks" 1.0 0 -13345367 true "" "plot count friendlinks"
"consumerlinks" 1.0 0 -2674135 true "" "plot count consumerlinks"

MONITOR
949
468
1051
513
NIL
count projects
17
1
11

PLOT
1300
486
1538
636
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
"Consumer" 1.0 0 -2674135 true "" "if count consumerlinks > 0 [ plot mean [ageL] of consumerlinks ]"
"Task" 1.0 0 -7500403 true "" "if count tasklinks > 0 [ plot mean [ageL] of tasklinks ]"

CHOOSER
25
215
265
260
reward-mechanism
reward-mechanism
"default" "a" "b"
0

PLOT
1545
80
1885
230
contributions-made
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
"No. Contributions 1s" 1.0 0 -2139308 true "" "plot contributions-made-by-1s"
"Time Contributed 1s (hrs)" 1.0 0 -8053223 true "" "plot time-contributed-by-1s"
"No. Contributions 9s" 1.0 0 -8275240 true "" "plot contributions-made-by-9s"
"Time Contributed 9s (hrs)" 1.0 0 -14730904 true "" "plot time-contributed-by-9s"

CHOOSER
20
350
260
395
how-community-works-without-platform
how-community-works-without-platform
"online open" "online closed" "offline"
0

CHOOSER
20
400
260
445
number-of-products
number-of-products
"one" "a few" "many"
1

PLOT
1545
230
1885
380
Dropped Tasks
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
"#1s" 1.0 0 -5298144 true "" "plot #1-dropped-a-task"
"#9s" 1.0 0 -14070903 true "" "plot #9-dropped-a-task"

PLOT
2260
10
2460
160
HistoAgeofTaskLinks
NIL
NIL
0.0
500.0
0.0
10.0
false
false
"" ""
PENS
"default" 5.0 1 -16777216 true "" "histogram [ageL] of tasklinks"

PLOT
2280
730
2440
850
Projects Died
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
"default" 1.0 0 -955883 true "" "plot projects-died"

SWITCH
25
175
265
208
platform-features
platform-features
0
1
-1000

PLOT
1545
380
1885
530
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
