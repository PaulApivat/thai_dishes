# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(RColorBrewer) 


# CIRCULAR PLOT ----


# create a data frame giving the hierarchical structure of your individuals
d1=data.frame(from="origin", to=paste("group", seq(1,10), sep=""))
d2=data.frame(from=rep(d1$to, each=10), to=paste("subgroup", seq(1,100), sep="_"))
edges=rbind(d1, d2)

# create a vertices data.frame. One line per object of our hierarchy
vertices = data.frame(
    name = unique(c(as.character(edges$from), as.character(edges$to))), 
    value = runif(111)
) 
# Let's add a column with the group of each name. It will be useful later to color points
vertices$group = edges$from[ match( vertices$name, edges$to ) ]


#Let's add information concerning the label we are going to add: angle, horizontal adjustement and potential flip
#calculate the ANGLE of the labels
vertices$id=NA
myleaves=which(is.na( match(vertices$name, edges$from) ))
nleaves=length(myleaves)
vertices$id[ myleaves ] = seq(1:nleaves)


# Original: vertices$angle = 90 - 360 * vertices$id / nleaves

# NOTE: This line sets the angle of the text (geom_node_text)
# The last number (110) adjusts the specific angle of each subgroup text

vertices$angle = 360 / nleaves * vertices$id + 110

# Original: vertices$hjust<-ifelse( vertices$angle < -90, 1, 0)

# calculate the alignment of labels
# Left (subgroup_1 to subgroup_50), Right (subgroup_51 to subgroup_100)
# angles and hjust must be consistent (110 & 291)
# make hjust = 1 for subgroup_1 to subgroup_50
# make hjust = 0 for subgroup_51 to subgroup_51

vertices$hjust<-ifelse( vertices$angle < 291, 1, 0)

# Original: vertices$angle<-ifelse(vertices$angle < -90, vertices$angle+180, vertices$angle)

# flip text to make them READABLE
# When making hjust = 1 for subgroup_1 to subgroup_50, must ALSO add 180 degree to those angles to push out the geom_node_text labels

vertices$angle<-ifelse(vertices$angle < 291, vertices$angle+180, vertices$angle)

# Create a graph object
mygraph <- graph_from_data_frame(edges, vertices = vertices)


# Make the plot
ggraph(mygraph, layout = 'dendrogram', circular = TRUE) + 
    geom_edge_diagonal(colour="grey") +
    scale_edge_colour_distiller(palette = "RdPu") +
    geom_node_text(aes(x = x*1.15, y=y*1.15, filter = leaf, label=name, angle = vertices$angle, hjust= vertices$hjust, colour=vertices$group), size=2.7, alpha=1) +
    geom_node_point(aes(filter = leaf, x = x*1.07, y=y*1.07, colour=vertices$group, size = vertices$value, alpha=0.2)) +   #size = value
    scale_colour_manual(values= rep( brewer.pal(9,"Paired") , 30)) +
    scale_size_continuous( range = c(0.1,7) ) +
    theme_void() +
    theme(
        legend.position="none",
        plot.margin=unit(c(0,0,0,0),"cm"),
    ) +
    expand_limits(x = c(-1.3, 1.3), y = c(-1.3, 1.3)) +
    coord_flip()


