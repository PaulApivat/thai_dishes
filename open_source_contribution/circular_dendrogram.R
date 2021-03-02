# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(RColorBrewer) 


d1=data.frame(from="origin", to=paste("group", seq(1,10), sep=""))
d2=data.frame(from=rep(d1$to, each=10), to=paste("subgroup", seq(1,100), sep="_"))
edges=rbind(d1, d2)


vertices = data.frame(
    name = unique(c(as.character(edges$from), as.character(edges$to))) , 
    value = runif(111)
) 


vertices$group = edges$from[ match( vertices$name, edges$to ) ]



vertices$id=NA
myleaves=which(is.na( match(vertices$name, edges$from) ))
nleaves=length(myleaves)
vertices$id[ myleaves ] = seq(1:nleaves)

vertices$angle = 360 / nleaves * vertices$id + 110  # adjust angle calculation

vertices$hjust<-ifelse( vertices$angle < 291, 1, 0) # adjust hjust

vertices$angle<-ifelse(vertices$angle < 291, vertices$angle+180, vertices$angle) # adjust where 180 is added


mygraph <- graph_from_data_frame( edges, vertices=vertices )


ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
    geom_edge_diagonal(colour="grey") +
    scale_edge_colour_distiller(palette = "RdPu") +
    geom_node_text(aes(x = x*1.15, y=y*1.15, filter = leaf, label=name, angle = angle, hjust=hjust, colour=group), size=2.7, alpha=1) +
    geom_node_point(aes(filter = leaf, x = x*1.07, y=y*1.07, colour=group, size=value, alpha=0.2)) +
    scale_colour_manual(values= rep( brewer.pal(9,"Paired") , 30)) +
    scale_size_continuous( range = c(0.1,10) ) +
    theme_void() +
    theme(
        legend.position="none",
        plot.margin=unit(c(0,0,0,0),"cm"),
    ) +
    expand_limits(x = c(-1.3, 1.3), y = c(-1.3, 1.3)) +
    coord_flip()  # add coord_flip
