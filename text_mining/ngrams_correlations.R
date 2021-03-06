library(dplyr)
library(readr)
library(tidyr)
library(tidytext)
library(janeaustenr)
library(igraph)
library(ggraph)

df <- read_csv("../web_scraping/edit_thai_dishes.csv")

# Book Example (Jane Austen) ----
austen_bigrams <- austen_books() %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2)

# Thai Dishes (minor grouping) ----

# Bigrams, ngrams
thai_dish_bigrams <- df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2)

# counting and filtering n-grams
thai_dish_bigrams %>%
    count(bigram, sort = TRUE) %>% View()

# NO STOP WORDS in NAMES of THAI DISHES
# note: tidyr/dplyr operations to help find common bigrams not containing stop-words
# separate/filter/count/unite

# Tri-grams
df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 3)

# Analyzing Bi-grams (Thai Dishes) ----

# Words that tend to go with "Khao"
# Khao will go beyond rice dishes
df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2) %>%
    separate(bigram, c("word1", "word2"), sep = " ") %>%
    filter(word1 == "khao") %>%
    count(minor_grouping, word2, sort = TRUE)

# Kaeng will usually stick to curries
df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2) %>%
    separate(bigram, c("word1", "word2"), sep = " ") %>%
    filter(word1 == "kaeng") %>%
    count(minor_grouping, word2, sort = TRUE) 

# Yam will usually be in Salads
df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2) %>%
    separate(bigram, c("word1", "word2"), sep = " ") %>%
    filter(word1 == "yam") %>%
    count(minor_grouping, word2, sort = TRUE)

# Mu has the most diverse pairing
df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2) %>%
    separate(bigram, c("word1", "word2"), sep = " ") %>%
    filter(word1 == "mu") %>%
    count(minor_grouping, word2, sort = TRUE)


# analyze Bi-grams by tf-idf ----

# Most important "pairing" is nam phrik
# Then "khao phat", then "nam chim"
# Most important (tf_idf) AND most frequent (n)
thai_dish_bigrams %>%
    count(minor_grouping, bigram) %>%
    bind_tf_idf(bigram, minor_grouping, n) %>%
    arrange(desc(tf_idf)) 


# Visualizing a network of Bi-grams with {ggraph} ----
library(igraph)

thai_dish_bigram_counts <- df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2) %>%
    separate(bigram, c("word1", "word2"), sep = " ") %>%
    count(word1, word2, sort = TRUE)


# filter for relatively common combinations (n > 2)
thai_dish_bigram_graph <- thai_dish_bigram_counts %>%
    filter(n > 2) %>%
    graph_from_data_frame()


library(ggraph)
set.seed(2021)

# ggraph is preferred for plotting (over igraph) because
# it has consistent grammar of graphics (ggplot2)
ggraph(thai_dish_bigram_graph, layout = "fr") +
    geom_edge_link() +
    geom_node_point() +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
    labs(
        title = "{ggraph} Network of Relationship between words",
        subtitle = "Common central nodes in Thai food",
        caption = "Data: Wikipedia | Graphics: @paulapivat"
    )

# polishing operations to make a better looking graph
a <- grid::arrow(type = "closed", length = unit(.15, "inches"))

ggraph(thai_dish_bigram_graph, layout = "fr") +
    geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                   arrow = a, end_cap = circle(.07, 'inches')) +
    geom_node_point(color = "dodgerblue", size = 5, alpha = 0.7) +
    geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
    labs(
        title = "{ggraph} Network of Relationship between words",
        subtitle = "Common central nodes in Thai food",
        caption = "Data: Wikipedia | Graphics: @paulapivat"
    ) +
    theme_void()



