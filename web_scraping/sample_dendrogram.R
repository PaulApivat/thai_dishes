# Libraries
library(ggraph)
library(igraph)=
library(tidyverse)
theme_set(theme_void())

# data: edge list
d1 <- data.frame(from="origin", to=paste("group", seq(1,7), sep=""))
d2 <- data.frame(from=rep(d1$to, each=7), to=paste("subgroup", seq(1,49), sep="_"))
edges <- rbind(d1, d2)

# We can add a second data frame with information for each node!
name <- unique(c(as.character(edges$from), as.character(edges$to)))
vertices <- data.frame(
    name=name,
    group=c( rep(NA,8) ,  rep( paste("group", seq(1,7), sep=""), each=7)),
    cluster=sample(letters[1:4], length(name), replace=T),
    value=sample(seq(10,30), length(name), replace=T)
)

# Create a graph object
mygraph <- graph_from_data_frame( edges, vertices=vertices)

# linear plot
ggraph(mygraph, layout = 'dendrogram', circular = FALSE) + 
    geom_edge_diagonal() +
    geom_node_text(aes( label=name, filter=leaf) , angle=0 , hjust=1, nudge_y = -0.01) +
    ylim(-.4, NA) +
    coord_flip()

ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
    geom_edge_diagonal() +
    geom_node_text(aes( label=name, filter=leaf) , angle=90 , hjust=1, nudge_y = -0.04) +
    geom_node_point(aes(filter=leaf) , alpha=0.6)
