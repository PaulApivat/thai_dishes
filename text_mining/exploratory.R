library(tidyverse)
install.packages("tidytext")
library(tidytext)


# read in data from another directory (web_scraping)
df <- read_csv("../web_scraping/edit_thai_dishes.csv")

# tidy text format
# tokenize each word in Thai_name
df %>%
    select(Thai_name, Thai_script) %>%
    unnest_tokens(word, Thai_name) 

# group by word and tally
df %>%
    select(Thai_name, Thai_script) %>%
    # can substitute 'word' for ngrams, sentences, lines
    unnest_tokens(ngrams, Thai_name) %>%  
    # to reference thai spelling: group_by(Thai_script)
    group_by(ngrams) %>%  
    tally(sort = TRUE) %>%  # alt: count(sort = TRUE)
# visualize
# pipe directly into ggplot2, because using tidytools
    ggplot(aes(n, ngrams)) + 
    geom_col(aes(fill = ngrams)) +
    theme(legend.position = "none")

# Join two tables
# 1. has Thai_script
# 2. has group_by(ngrams)

# No need to remove stop words
# note: stop words necessary to analyze English Descriptions.





?unnest_tokens
