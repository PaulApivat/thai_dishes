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



# Word Frequencies ----

# visualize freq via scatterplot
df %>%
    select(Thai_name, Thai_script) %>%
    unnest_tokens(ngrams, Thai_name) %>%  
    group_by(ngrams) %>%  
    tally(sort = TRUE) %>%  # alt: count(sort = TRUE)
    ggplot(aes(n, ngrams)) + 
    geom_point(aes(fill = ngrams)) +
    theme(legend.position = "none")

# Word Frequencies (Book Example)----
install.packages('gutenbergr')
library(gutenbergr)

# HG Wells ----
hgwells <- gutenberg_download(c(35, 36, 5230, 159))

tidy_hgwells <- hgwells %>%
    unnest_tokens(word, text) %>%
    anti_join(stop_words)

# most common words in H.G. Wells novel
tidy_hgwells %>%
    group_by(word) %>%
    tally(sort = TRUE)

tidy_hgwells %>%
    count(word, sort = TRUE)

# Bronte ----

bronte <- gutenberg_download(c(1260, 768, 969, 9182, 767))

tidy_bronte <- bronte %>%
    unnest_tokens(word, text) %>%
    anti_join(stop_words)

tidy_bronte %>%
    count(word, sort = TRUE)

# Jane Austen ----
library(janeaustenr)

original_books <- austen_books() %>%
    group_by(book) %>%
    mutate(linenumber = row_number(),
           chapter = cumsum(str_detect(text, 
                                       regex("^chapter [\\divxlc]",
                                             ignore_case = TRUE)))) %>%
    ungroup()

original_books


tidy_books <- original_books %>%
    unnest_tokens(word, text)

# Frequency ----
library(tidyr)

frequency <- bind_rows(mutate(tidy_bronte, author = "Brontë Sisters"),
                       mutate(tidy_hgwells, author = "H.G. Wells"), 
                       mutate(tidy_books, author = "Jane Austen")) %>% 
    mutate(word = str_extract(word, "[a-z']+")) %>%
    count(author, word) %>%
    group_by(author) %>%
    mutate(proportion = n / sum(n)) %>% 
    select(-n) %>% 
    spread(author, proportion) %>% 
    gather(author, proportion, `Brontë Sisters`:`H.G. Wells`)



