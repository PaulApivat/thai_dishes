library(dplyr)
library(readr)
library(tidytext)
library(janeaustenr)

df <- read_csv("../web_scraping/edit_thai_dishes.csv")

# Book Example (Jane Austen) ----
austen_bigrams <- austen_books() %>%
    unnest_tokens(bigram, text, token = "ngrams", n = 2)

# Thai Dishes (minor grouping) ----

# Bigrams, ngrams
df %>%
    select(Thai_name, minor_grouping) %>%
    unnest_tokens(bigram, Thai_name, token = "ngrams", n = 2)






