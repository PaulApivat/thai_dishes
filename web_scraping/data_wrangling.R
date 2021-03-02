library(tidyverse)

# load data ----
### NOTE: read in edit_thai_dishes.csv and skip to DENDROGRAM

df <- read_csv("thai_dishes.csv")

str(df)



# exploratory ----
df %>% str()

# change column name ----
df <- df %>%
    rename(
        Thai_name = `Thai name`,
        Thai_script = `Thai script`,
        English_name = `English name`
    )

df %>%
    select(Description, Description2)

# tally Columns Region
df %>%
    group_by(Region) %>%
    tally(sort = TRUE)

df %>%
    count(Region)

df %>%
    count(`Thai_name`)

# remove  \n from all columns ----
df$Thai_name <- gsub("[\n]", "", df$Thai_name)
df$Thai_script <- gsub("[\n]", "", df$Thai_script)
df$English_name <- gsub("[\n]", "", df$English_name)
df$Image <- gsub("[\n]", "", df$Image)
df$Region <- gsub("[\n]", "", df$Region)
df$Description <- gsub("[\n]", "", df$Description)
df$Description2 <- gsub("[\n]", "", df$Description2)

df$Image
df$Region
df$Description2

# Count individual words ----

# Count by individual words in Thai_name column [English works better]
df %>%
    separate_rows(Thai_name, sep = ' ') %>%
    group_by(Thai_name = tolower(Thai_name)) %>%
    group_by(Thai_name) %>%
    tally(sort = TRUE) %>%
    view()

# Count by individual words in Thai_script column
df %>%
    separate_rows(Thai_script, sep = ' ') %>%
    group_by(Thai_script = tolower(Thai_script)) %>%
    group_by(Thai_script) %>%
    tally(sort = TRUE) %>%
    view()
    
# Count by individual words in Description2
df %>%
    separate_rows(Description2, sep = ' ') %>%
    group_by(Description2 = tolower(Description2)) %>%
    group_by(Description2) %>%
    tally(sort = TRUE) 


# Add Major AND Minor Groupings ----
df <- df %>%
    mutate(
        major_grouping = as.character(NA),
        minor_grouping = as.character(NA)
        )
    
# Account for Individual vs Shared, Savoury, Sweet or Drinks
df[1:53,]$major_grouping <- 'Individual dishes'
df[54:254,]$major_grouping <- 'Shared dishes'
df[255:280,]$major_grouping <- 'Savory snacks'
df[281:311,]$major_grouping <- 'Sweet snacks'
df[312:328,]$major_grouping <- 'Drinks'

# Account for Minor grouping
df[1:22,]$minor_grouping <- 'Rice dishes'
df[23:46,]$minor_grouping <- 'Noodle dishes'
df[47:53,]$minor_grouping <- 'Misc Indiv'
df[54:93,]$minor_grouping <- 'Curries'
df[94:104,]$minor_grouping <- 'Soups'
df[105:156,]$minor_grouping <- 'Salads'
df[157:190,]$minor_grouping <- 'Fried and stir-fried dishes'    #need to change #157 to Kai phat khing [done]
df[191:209,]$minor_grouping <- 'Deep-fried dishes'
df[210:228,]$minor_grouping <- 'Grilled dishes'
df[229:232,]$minor_grouping <- 'Steamed or blanched dishes'
df[233,]$minor_grouping <- 'Stewed dishes'
df[234:249,]$minor_grouping <- 'Dipping sauces and pastes'   # need Editing
df[250:254,]$minor_grouping <- 'Misc Shared'
df[255:280,]$minor_grouping <- 'Savory snacks'
df[281:311,]$minor_grouping <- 'Sweet snacks'
df[312:328,]$minor_grouping <- 'Drinks'


# Edit Rows for missing Thai_name
df[26,]$Thai_name <- "Khanom chin nam ngiao"

df[110,]$Thai_name <- "Lap Lanna"

df[157,]$Thai_name <- "Kai phat khing"

df[234,]$Thai_name <- "Nam chim chaeo"
df[235,]$Thai_name <- "Nam chim kai"
df[236,]$Thai_name <- "Nam chim paesa"
df[237,]$Thai_name <- "Nam chim sate"
df[238,]$Thai_name <- "Nam phrik i-ke"
df[240,]$Thai_name <- "Nam phrik kha"
df[241,]$Thai_name <- "Nam phrik khaep mu"
df[246,]$Thai_name <- "Nam phrik pla chi"



# Write new csv to save edits made to data frame
write_csv(df, "edit_thai_dishes.csv")



# Dendrogram ----

### NOTE: read in edit_thai_dishes.csv
df <- read_csv("edit_thai_dishes.csv")

library(ggraph)
library(igraph)

df %>%
    select(major_grouping, minor_grouping, Thai_name, Thai_script) %>%
    filter(major_grouping == 'Individual dishes') %>%
    group_by(minor_grouping) %>%
    count() 

# Individual Dishes ----

# data: edge list
d1 <- data.frame(from="Individual dishes", to=c("Misc Indiv", "Noodle dishes", "Rice dishes"))

d2 <- df %>%
    select(minor_grouping, Thai_name) %>%
    slice(1:53) %>%
    rename(
        from = minor_grouping,
        to = Thai_name
    ) 

edges <- rbind(d1, d2)

# plot dendrogram (idividual dishes)
indiv_dishes_graph <- graph_from_data_frame(edges)

ggraph(indiv_dishes_graph, layout = "dendrogram", circular = FALSE) +
    geom_edge_diagonal(aes(edge_colour = edges$from), label_dodge = NULL) +
    geom_node_text(aes(label = name, filter = leaf, color = 'red'), hjust = 1.1, size = 3) +
    geom_node_point(color = "whitesmoke") +
    theme(
        plot.background = element_rect(fill = '#343d46'),
        panel.background = element_rect(fill = '#343d46'),
        legend.position = 'none',
        plot.title = element_text(colour = 'whitesmoke', face = 'bold', size = 25),
        plot.subtitle = element_text(colour = 'whitesmoke', face = 'bold'),
        plot.caption = element_text(color = 'whitesmoke', face = 'italic')
    ) +
    labs(
        title = '52 Alternatives to Pad Thai',
        subtitle = 'Individual Thai Dishes',
        caption = 'Data: Wikipedia | Graphic: @paulapivat'
    ) +
    expand_limits(x = c(-1.5, 1.5), y = c(-0.8, 0.8)) +
    coord_flip() +
    annotate("text", x = 47, y = 1, label = "Miscellaneous (7)", color = "#7CAE00")+
    annotate("text", x = 31, y = 1, label = "Noodle Dishes (24)", color = "#00C08B") +
    annotate("text", x = 8, y = 1, label = "Rice Dishes (22)", color = "#C77CFF") +
    annotate("text", x = 26, y = 2, label = "Individual\nDishes", color = "#F8766D")


# Shared Dishes ----
df %>%
    select(major_grouping, minor_grouping, Thai_name, Thai_script) %>%
    filter(major_grouping == 'Shared dishes') %>%
    group_by(minor_grouping) %>%
    count() %>%
    arrange(desc(n))

d3 <- data.frame(from="Shared dishes", to=c("Curries", "Soups", "Salads",
                                            "Fried and stir-fried dishes", "Deep-fried dishes", "Grilled dishes",
                                            "Steamed or blanched dishes", "Stewed dishes", "Dipping sauces and pastes", "Misc Shared"))


d4 <- df %>%
    select(minor_grouping, Thai_name) %>%
    slice(54:254) %>%
    rename(
        from = minor_grouping,
        to = Thai_name
    )

edges2 <- rbind(d3, d4)

# create a vertices data.frame. One line per object of hierarchy
vertices = data.frame(
    name = unique(c(as.character(edges2$from), as.character(edges2$to)))
)

# add column with group of each name. Useful to later color points
vertices$group = edges2$from[ match(vertices$name, edges2$to)]

# Add information concerning the label we are going to add: angle, horizontal adjustment and potential flip
# calculate the ANGLE of the labels
vertices$id=NA
myleaves=which(is.na(match(vertices$name, edges2$from)))
nleaves=length(myleaves)
vertices$id[myleaves] = seq(1:nleaves)

vertices$angle = 360 / nleaves * vertices$id + 90    # Works the best


# calculate the alignment of labels: right or left
# If I am on the left part of the plot, my labels have currently an angle < -90
#vertices$hjust<-ifelse( vertices$angle < -90, 1, 0)   #original

vertices$hjust<-ifelse( vertices$angle < 275, 1, 0)



# flip angle BY to make them readable
#vertices$angle<-ifelse(vertices$angle < -90, vertices$angle+180, vertices$angle)  #original
vertices$angle<-ifelse(vertices$angle < 275, vertices$angle+180, vertices$angle)

# plot dendrogram (shared dishes)
shared_dishes_graph <- graph_from_data_frame(edges2)

ggraph(shared_dishes_graph, layout = "dendrogram", circular = TRUE) +
    geom_edge_diagonal(aes(edge_colour = edges2$from), label_dodge = NULL) +
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
    
    
    



