install.packages("devtools")
library(devtools)
install.packages('spartan')
library('spartan')

PARAMETERS =
  c('commoners-num',
    'number-of-products',
    'initial-projects',
    'num-interest-categories',
    'num-skills',
    'mean-time-required',
    'task-hatch-task-prob',
    'max-find-level',
    'leave-prob',
    'consume-dist',
    'contrib-dist',
    'recommend-dist',
    'find-product-dist',
    'find-project-dist',
    'find-task-dist',
    'prop-project-total-contrib',
    'prop-project-recent-contrib',
    'find-friend',
    'commoner-repulsion-prob',
    'project-repulsion-prob',
    'product-repulsion-prob',
    'product-commoner-attraction-prob',
    'commoner-product-attraction-prob',
    'task-commoner-attraction-prob',
    'commoner-task-attraction-prob',
    'friends-recent-forg',
    'friends-long-forg',
    'consume-recent-forg',
    'consume-long-forg',
    'contrib-recent-forg',
    'contrib-long-forg',
    'project-recent-forg',
    'project-long-forg'
    )
PARAMVALS =   c(
  "[10,200,20]", # commoners-num: 10, 200
  "[1,100,10]", # number-of-products: TODO ¿can we change this param?
  "[10,100,10]", # initial-projects: 10, 70
  "[5,50,5]", # num-interest-categories: 5, 50
  "[10,100,10]", # num-skills: 10, 70
  "[10,100,10]", # mean-time-required: 10, 70
  "[0.3,1,0.1]", # task-hatch-task-prob: 0.3, 0.7
  "[0.2,1,0.1]", # max-find-level: 0.2, 0.7
  "[0.0002,0.002,0.0002]", # leave-prob: 0.0002, 0.002
  "[1,5,0.5]", # consume-dist: 1, 4
  "[1,5,0.5]", # contrib-dist: 1, 4
  "[1,5,0.5]", # recommend-dist: 1, 4
  "[1,5,0.5]", # find-product-dist: 1, 4
  "[1,5,0.5]", # find-project-dist: 1, 4
  "[1,5,0.5]", # find-task-dist: 1, 4
  "[0.2,1,0.1]", # prop-project-total-contrib: 0.2, 0.8
  "[0.2,1,0.1]", # prop-project-recent-contrib: 0.2, 0.8
  "[0.2,1,0.1]", # find-friend: 0.2, 0.8
  "[0.2,1,0.1]", # commoner-repulsion-prob: 0.2, 0.7
  "[0.2,1,0.1]", # project-repulsion-prob: 0.2, 0.7
  "[0.2,1,0.1]", # product-repulsion-prob: 0.2, 0.7
  "[0.1, 0.5, 0.05]", # product-commoner-attraction-prob: 0.1, 0.5
  "[0.2,2,0.2]", # commoner-product-attraction-prob: 0.2, 1.2
  "[0.2,2,0.2]", # task-commoner-attraction-prob: 0.2, 1.2
  "[0.2,2,0.2]", # commoner-task-attraction-prob: 0.2, 1.2
  "[10,20,1]", # friends-recent-forg: 10, 20
  "[30,60,3]", # friends-long-forg: 30, 60
  "[10,20,1]", # consume-recent-forg: 10, 20
  "[30,60,3]", # consume-long-forg: 30, 60
  "[10,20,1]",  # contrib-recent-forg: 10, 20
  "[30,60,3]", # contrib-long-forg: 30, 60
  "[10,20,1]", # project-recent-forg: 10, 20
  "[30,60,3]" # project-long-forg: 30, 60
  )

MEASURES <-  c('count commoners', 'count t4sks', 'count projects', 'count products','count turtles', 'count commonerprojectlinks', 'count consumerlinks', 'count friendlinks', 'count commonertasklinks', 'count links', 'power-law-alpha', 'sum contrib-distrib', 'contrib-distrib')

NETLOGO_SETUPFILE_NAME<-"nl_robustness_setup"

FILEPATH <- './LHC'

lhc_generate_lhc_sample_netlogo('./LHC/', PARAMETERS, PARAMVALS, 100, 'normal', 5, "true", 'setup', 'go', MEASURES)
