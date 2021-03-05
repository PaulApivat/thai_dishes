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

book_words <- left_join(book_words, total_words)

# plot term frequency distribution across Jane Austen novels
ggplot(book_words, aes(n/total, fill = book)) +
    geom_histogram(show.legend = FALSE) +
    xlim(NA, 0.0009) +
    facet_wrap(~book, ncol = 2, scales = "free_y")

# Zipf's Law
freq_by_rank <- book_words %>% 
    group_by(book) %>% 
    mutate(rank = row_number(), 
           `term frequency` = n/total) %>%
    ungroup()


# Visualize Zipf's Law
# Plot Rank on x-axis
# Plot Term Freq on y-axis
# both on logarithmic scales
freq_by_rank %>% 
    ggplot(aes(rank, `term frequency`, color = book)) + 
    geom_line(size = 1.1, alpha = 0.8, show.legend = FALSE) + 
    scale_x_log10() +
    scale_y_log10()


# Term Frequency in Thai Dishes ----

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

thai_dish_join <- left_join(minor_grouping_words, total_word_per_group)

# plot term frequency distribution across Thai Dish Groupings
# Term Frequency: The number of times a word appears in a minor_grouping (thai dishes)
# divided by the total number of terms (words) in that novel (n/total)

ggplot(thai_dish_join, aes(x = n/total, fill = minor_grouping)) +
    geom_histogram(show.legend = FALSE) +
    #xlim(NA, 0.0009) +
    facet_wrap(~minor_grouping, ncol = 3, scales = "free_y") +
    labs(
        title = "Long tail distribution of words in Thai Dishes"
    )

# Zipf's Law (Thai Dishes) ----

freq_by_rank_thai <- thai_dish_join %>%
    group_by(minor_grouping) %>%
    mutate(
        rank = row_number(),
        `term frequency` = n/total
    ) %>%
    ungroup()

# Visualize Zipf's Law (Thai Dishes)
# Rank on x-axis
# Term Freq on y-axis
# NOTE: Interesting to see Zipf's law playout

freq_by_rank_thai %>%
    ggplot(aes(x = rank, y = `term frequency`, color = minor_grouping)) +
    geom_line(size = 1.1, alpha = 0.8, show.legend = TRUE) +
    scale_x_log10() +
    scale_y_log10() +
    theme(legend.position = 'bottom') +
    labs(
        title = "Zipf's Law for Thai Dishes",
        subtitle = "log-log coordinates"
        )














