# The Commoners Framework

This repository holds the NetLogo implementation of a conceptual framework - the ‘Commoners Framework’ - to be used when conceptualising and modelling the behaviour of commons-based peer production (CBPP) communities. The framework is currently being finalised, implemented in NetLogo, and tested on a case study, by Peter Barbrook-Johnson and Antonio Tenorio Fornes.

The Commoners Framework, and by extension, this model, can be used to represent the behaviour and operation of a wide-range of CBPP communities, and similar organisations (such as those that make use of volunteers). It represents the processes behind individuals’ decisions to contribute to, enter or exit, or make ‘friends’ in, communities. Through this representation of individuals’ behaviour, the framework aims to account for patterns of behaviour observed at the community level. For example, the distribution of participation rates among individuals, which often follows a power law distribution, also known as the ‘1-9-90 rule’; where 1% of the community – the core members – perform most of the work, 9% of the community – the contributors – occasionally contribute and 90% of the community – the users or consumers - use the commons without directly contributing to produce it. The framework was developed based on recent empirical findings on behaviour in a wide variety of communities and was refined using the structural rigour imposed when building an agent-based model (ABM).

To open the NetLogo file, you will first need to install NetLogo, which is available at https://ccl.northwestern.edu/netlogo/.

For more information please contact Peter and/or Antonio - Peter Barbrook-Johnson <P.Barbrookjohnson1@westminster.ac.uk>, Antonio Tenorio Fornés <antoniotenorio@ucm.es> 


*The Logic of the Framework*

The focus of the model is Commoners. Commoners is the name given to individuals in a community – both those that contribute, and those that consume the product(s) of a community. The core productive activity of any Commoner is to find tasks in the community, and contribute to them. Their ability to, and likelihood of, contributing will depend on their time available (a resource Commoners have), interests (a Commoner and task parameter which should match), and skill types (a Commoner and task parameter which should match). Commoners may stay in a community, only consuming but not contributing, if no tasks meet their interest or skills. Commoners may make ‘friends’ with others contributing to the same tasks. Having friends increases the chance of finding tasks and contributing. Friends may be lost over time with a certain probability. Commoners’ probability of leaving a community decreases as they make more contributions and have more friends. Contributions improve the quality, or number, of products in the community. More consumption of products increases the probability of existing consumers of these products continuing to consume them, and new Commoners entering the community.

The framework was developed based on recent empirical findings (Morell et al 2016; Arvidsson et al 2016) on behaviour in communities and was refined using the structural rigour imposed when building an agent-based model (ABM). 


*Details*


* Products and Projects

On the left hand side of the model, goods produced by the community, called “Products”, and the projects to produce or improve them, called “Projects” are displayed. Products are the ‘box’ icons, and Projects are the ‘target’ icons. Consumption activity (i.e. others consuming a Product) makes Products more appealing to Commoners - this is represented by bringing the Product towards the center of the model. Production activity (i.e. contributions by Commoners) in the “Tasks” of a Project also makes the Project more appealing to contributors, this behaviour is also represented by bringing the Project towards the center. Note, contributions to Projects is made via the multiple Tasks within them (displayed by the green dots inside the target icon).


* Commoners *

Commoners are positioned in the right hand side of the model. The chances of discovering any elements on the left hand side of the model (i.e. Products/Projects/Tasks) depends on the distance between those elements and the Commoner. Not only does consumption and production activity make the Products and Projects more appealing (thus bringing them towards the center) but it also makes the Commoners more likely to engage in the community, thus these activities attracts the Commoners towards the center of the model.

Commoners’ recent history of consumption and contribution also affects the chances of current contribution or consumption. Consumption of contrbutions are represented by links, and each consumption/prodution link has a recent weight that accounts for the recent activity, if the weight is 0, the link will be forgoten with some likelihood.

Friendship among Commoners is created when Commoners work in the same task. Having friends increases the likelihood of finding Tasks and contributing to them (if friends are working on them).


* Decay *

The model also include forces that bring the elements towards the edges of the model, thus decreasing their chances to be found or active (i.e. representing some natural decay in engagement over time). This forces are stronger near the center, where elements have to be considerably active to remain.


* The Interface *

Please note, it is expected only those with at least a basic familiarty of NetLogo will use this model.

In the upper left corner of the interface, the buttons setup and go will setup and run the model respectively.

Sliders at the left of the model control the number of each of the elements of the model at the start the simulation.

Vertical sliders at the right of the world view set up parameters for the ‘find operations’ (i.e. find Products, Projects, Tasks and friends) and how much having friends affects these activities. They also set up how much distance is taken into account for the creation of new Products or the arrival of new Commoners.

Horizontal sliders below set the attraction and repulsion of the elements towards the center (e.g. how much contributing to a Task makes a Commoner move towards the center).

Finally, three horizontal sliders at the bottom set how much having friends, having an active recent contribution history, or how many tasks the commoner has found, affects the likelihood of the Commoner contributing.


* Playingw with the model *

The model tries to represent the behaviour in collaborative communities, where contributions and participation often follow a power law distribution where 1% of the community does most of the work, 9% contributes occasionally and the rest only consumes.

Try setting the repulsion, attraction and find probabilities in the model to represent this behaviour. Too much attraction or too little repulsion will make all the elements come towards the center. Few chances of finding tasks and contributing will make the Commoners leave the model, due to their small involvement.


*References*

ARVIDSSON, A., Caliandro, A., Cossu, A., Deka, M., Gandini, A., Luise, V., Orria, B., and Anselmi, G. (2016). Commons Based Peer Production in the Information Economy. Academia. Accessed 13 April 2017. https://www.academia.edu/29210209/Commons_Based_Peer_Production_in_the_Information_Economy 

MORELL M.F., Salcedo J.L., and Berlinguer M. (2016). Debate About the Concept of Value in Commons-Based Peer Production. In: Bagnoli F. et al. (eds) Internet Science. INSCI 2016. Lecture Notes in Computer Science, vol 9934. Springer, Cham.

