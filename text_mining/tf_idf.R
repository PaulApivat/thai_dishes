# select libraries from tidyverse
library(dplyr)
library(readr)
library(ggplot2)
library(forcats)

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

# Find Exponent of Power Law for Middle Section of Jane Austen Rank range
rank_subset <- freq_by_rank %>% 
    filter(rank < 500,
           rank > 10)

lm(log10(`term frequency`) ~ log10(rank), data = rank_subset)

# The bind_tf_idf() function
# Calculating tf-idf finds words that are important in a text, but not too common

book_tf_idf <- book_words %>%
    bind_tf_idf(word, book, n)

# Terms with high tf-idf in Jane Austen's works
book_tf_idf %>%
    select(-total) %>%
    arrange(desc(tf_idf))


# Visualize High tf-idf words from Jane Austen's works
book_tf_idf %>%
    group_by(book) %>%
    slice_max(tf_idf, n = 15) %>%
    ungroup() %>%
    ggplot(aes(tf_idf, fct_reorder(word, tf_idf), fill = book)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~book, ncol = 2, scales = "free") +
    labs(x = "tf-idf", y = NULL)








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


# Find Exponent of Power Law for Middle Section of Thai Dishes Rank range (btwn 3-10)

rank_subset_thai <- freq_by_rank_thai %>%
    filter(rank < 10,
           rank > 3)

# NOT QUITE an illustration of Zipf's law (-1 vs -0.63)
lm(log10(`term frequency`) ~ log10(rank), data = rank_subset_thai)

# Plot fitted power law with data 
freq_by_rank_thai %>%
    ggplot(aes(x = rank, y = `term frequency`, color = minor_grouping)) +
    geom_abline(intercept = -0.94, slope = -0.63, color = 'gray50', linetype = 2) +
    geom_line(size = 1.1, alpha = 0.8, show.legend = TRUE) +
    scale_x_log10() +
    scale_y_log10() +
    theme(legend.position = 'bottom') +
    labs(
        title = "Zipf's Law for Thai Dishes",
        subtitle = "log-log coordinates"
    )


# The bind_tf_idf() function ----

thai_dish_tf_idf <- thai_dish_join %>%
    bind_tf_idf(word, minor_grouping, n)

# Terms with high tf-idf in Thai dishes 
# Observation: even though mu is the most common term, the tf_idf doesn't consider it
# important for each of the food groups
# e.g., 'kaeng' is more important to Curries than 'mu' is to various dishes

thai_dish_tf_idf %>%
    select(-total) %>%
    arrange(desc(tf_idf))

# Visualize High tf-idf words in Thai Dishes
thai_dish_tf_idf %>%
    group_by(minor_grouping) %>%
    slice_max(tf_idf, n = 5) %>%
    ungroup() %>%
    ggplot(aes(x = tf_idf, y = fct_reorder(word, tf_idf), fill = minor_grouping)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~minor_grouping, ncol = 3, scales = 'free') +
    labs(
        x = "tf-idf", 
        y = NULL
    )


# SUMMARY ----

# Using Term Frequency and Inverse Document Frequency allows us to 
# find words that are characteristic for one document 
# within a collection of documents (minor grouping of Thai dishes)

# explore Frequency on it's own gives us insight into which ingredient
# or raw material is used most frequently in a collection of Thai dishes

# tf-idf from {tidytext} allows us to see which ingredients or raw materials
# are important in a grouping within a collection of groupings









