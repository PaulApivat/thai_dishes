library(tidyverse)
library(ggraph)
library(igraph)

# read in edit_thai_dishes
df <- read_csv("edit_thai_dishes.csv")


# create edge
d1 <- data.frame(from="Shared dishes", to=c("Curries", "Soups", "Salads",
                                            "Fried and stir-fried dishes", "Deep-fried dishes", "Grilled dishes",
                                            "Steamed or blanched dishes", "Stewed dishes", "Dipping sauces and pastes", "Misc Shared"))

d2 <- df %>%
    select(minor_grouping, Thai_name) %>%
    slice(54:254) %>%
    rename(
        from = minor_grouping,
        to = Thai_name
    )

edges <- rbind(d1, d2)

# create vertices
# one line per object of hierarchy
vertices = data.frame(
    name = unique(c(as.character(edges$from), as.character(edges$to)))
)

# add column with group of each name
vertices$group = edges$from[ match(vertices$name, edges$to)]

# add label data and calculate ANGLE of labels
vertices$id=NA
myleaves=which(is.na(match(vertices$name, edges$from)))
nleaves=length(myleaves)
vertices$id[myleaves] = seq(1:nleaves)

vertices$angle = 360 / nleaves * vertices$id + 90    # Works the best

# calculate the alignment of labels: right or left
vertices$hjust<-ifelse( vertices$angle < 275, 1, 0)

# flip angle BY to make them Readable
vertices$angle<-ifelse(vertices$angle < 275, vertices$angle+180, vertices$angle)

# plot dendrogram (shared dishes)
shared_dishes_graph <- graph_from_data_frame(edges)

ggraph(shared_dishes_graph, layout = "dendrogram", circular = TRUE) +
    geom_edge_diagonal(aes(edge_colour = edges$from), label_dodge = NULL) +
    geom_node_text(aes(x = x*1.15, y=y*1.15, filter = leaf, label=name, angle = vertices$angle, hjust= vertices$hjust, colour= vertices$group), size=2.7, alpha=1) +
    geom_node_point(color = "whitesmoke") +
    #scale_color_manual(values = c("red", "orange", "blue", "yellow", "green", "purple", "dodgerblue", "black", "pink", "white")) +
    #scale_edge_color_manual(values = c("red", "orange", "blue", "yellow", "green", "purple", "dodgerblue", "black", "pink", "white", "white")) +
    theme(
        plot.background = element_rect(fill = '#343d46'),
        panel.background = element_rect(fill = '#343d46'),
        legend.position = 'none',
        plot.title = element_text(colour = 'whitesmoke', face = 'bold', size = 25),
        plot.subtitle = element_text(colour = 'whitesmoke', margin = margin(0,0,30,0), size = 20),
        plot.caption = element_text(color = 'whitesmoke', face = 'italic')
    ) +
    labs(
        title = 'Thai Food is Best Shared',
        subtitle = '201 Ways to Make Friends',
        caption = 'Data: Wikipedia | Graphic: @paulapivat'
    ) +
    #expand_limits(x = c(-1.5, 1.5), y = c(-0.8, 0.8)) +
    expand_limits(x = c(-1.5, 1.5), y = c(-1.5, 1.5)) +
    coord_flip() +
    annotate("text", x = 0.4, y = 0.45, label = "Steamed", color = "#F564E3") +
    annotate("text", x = 0.2, y = 0.5, label = "Grilled", color = "#00BA38") +
    annotate("text", x = -0.2, y = 0.5, label = "Deep-Fried", color = "#DE8C00") +
    annotate("text", x = -0.4, y = 0.1, label = "Fried &\n Stir-Fried", color = "#7CAE00") +
    annotate("text", x = -0.3, y = -0.4, label = "Salads", color = "#00B4F0") +
    annotate("text", x = -0.05, y = -0.5, label = "Soups", color = "#C77CFF") +
    annotate("text", x = 0.3, y = -0.5, label = "Curries", color = "#F8766D") +
    annotate("text", x = 0.5, y = -0.1, label = "Misc", color = "#00BFC4") +
    annotate("text", x = 0.5, y = 0.1, label = "Sauces\nPastes", color = "#B79F00")











