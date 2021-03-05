# select libraries from tidyverse
library(dplyr)
library(readr)
library(ggplot2)

library(tidytext)
library(janeaustenr)

# Term Frequency in Jane Austen's novels ----

book_words <- austen_books() %>%
    unnest_tokens(word, text) %>%
    count(book, word, sort = TRUE)

total_words <- book_words %>% 
    group_by(book) %>% 
    summarize(total = sum(n))

# NOTE: Applying to Thai Dishes
# book_words = word frequency across each minor grouping
# total_words = total words in each minor grouping

# read in data from another directory (web_scraping)
df <- read_csv("../web_scraping/edit_thai_dishes.csv")

# (minor)_grouping words
minor_grouping_words <- df %>%
    select(Thai_name, Thai_script, minor_grouping) %>%
    unnest_tokens(word, Thai_name) %>%   # can substitute ngrams for word
    count(word, minor_grouping, sort = TRUE) 

total_word_per_group <- minor_grouping_words %>%
    group_by(minor_grouping) %>%
    summarize(total = sum(n))











