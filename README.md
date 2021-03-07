# Thai Dishes: Project Overview

## Motivation

- What is this project?

- What drives this project?

People need to know they have other choices aside from Pad Thai. In fact Pad Thai is one of 53 individual dishes and there are at least 201 shared dishes in Thai cuisine.

This project is an opportunity to build a dataset of Thai dishes by scrapping tables off Wikipedia. The project is an opportunity to further Python and R skills. Using Python for web scrapping and R for exploratory analysis. Web scrapping is done in Beautiful Soup (`Python`) and pre-processed further with `dplyr` and visualized with `ggplot2`.

This project also makes an **open source** contribution (i.e., Circular Dendrogram with Rotating Text), [see pull request here](https://github.com/holtzy/R-graph-gallery/pull/34).

In the second phase, we take a quick dive into (exploratory) Text Mining see what kind of insights could be gained from analyzing Thai Names (and Description) for each dish.

- What questions are you answering?

Initially, the questions are exploratory:

1. How might we organized Thai dishes?
2. What is the best way to organized the different dishes?
3. Which raw material(s) are most popular?
4. Which raw materials are most important?
5. Could you learn about Thai food just from the names of the dishes?

## Initial Scope

- Phase 1: Scrape the Thai Dishes table from [Wikipedia](https://en.wikipedia.org/wiki/List_of_Thai_dishes). Clean the data. Run exploratory analysis to get some insights. Use Python for web scraping, R for data wrangling and visualization.

- Phase 1a: Make open source contribution to [R Graph Gallery](https://www.r-graph-gallery.com/index.html)

- Phase 2: Explored basic [Text Mining with R](https://www.tidytextmining.com/index.html)

# Code and Libraries Used

## Python

- Beautiful Soup (Python)
- Requests: HTTP for Humans (Python)
- urllib: URL Handling modules (Python)
- ssl: Wrapper for socket objects (Python)
- Pandas (Python)

## R

- Base
- Tidyverse (R)
- readr
- dplyr
- ggplot2
- ggraph (dendrogram interface with ggplot2): ggraph, geom_node_text, geom_edge_diagonal
- igraph (dendrogram): graph_from_data_frame()

**Scraper Article**: https://sateesh110.medium.com/how-to-scrape-wikipedia-table-using-python-beautiful-soup-cd0d8ee1a319

**Circular Dendrogram Labels**: [Dendrograms in R, a lightweight approach](https://atrebas.github.io/post/2019-06-08-lightweight-dendrograms/) this helped me figure out the angles for geom_node_text

**Wikipedia: Thai Dishes**: https://en.wikipedia.org/wiki/List_of_Thai_dishes

**Text Mining in R**: https://www.tidytextmining.com/

# Documenting Progress

- Project walk through
- Daily progress
- 2/24 - web scraping (Description)
- 2/25 - data cleaning & transformation
- 2/27 & 2/28 - figured out two dendrograms, normal and circular w/ geom_node_text readability
- Shared visualization along with essay:
  [Thread 1](https://twitter.com/paulapivat/status/1365840992373379074?s=20)
  [Thread 2](https://twitter.com/paulapivat/status/1366385027001380865?s=20)

- 3/1 Finalize Circular Dendrogram for Shared Thai food; add annotations to sub-groups
- 3/2 Made first open source contribution. [See pull request here](https://github.com/holtzy/R-graph-gallery/pull/34). [Thread 3](https://twitter.com/paulapivat/status/1366768527529533440?s=20)

- 3/4 - Use {tidytext} package, `unnest_tokens()` function to change unstructured text to one-token-per-row - find Word Frequencies using `dplyr`, use {janeaustenr} package, `dplyr` and `ggplot2`, Visualize comparison of Word Frequencies, Visualize Zipf's law
- 3/5 - Analyze word and document frequency: `tf-idf`, term frequency, inverse document frequency, visualize Zipf's law, `bind_tf_idf()`, visualize td_idf across minor_grouping, long-tail distribution,

- 3/6 - Explore `bi-grams` and networks of relationship between words in {tidytext}

Contribute to open source in 2 ways:

1. contribute Update to circular dendrogram for R Gallery. [see here](https://github.com/holtzy/R-graph-gallery/pull/34)
2. [potentially] contribute Thai_dishes to [thai_food_open_data on github](https://github.com/thangman22/thai-food-open-data) (requires additional data manipulation to categorize whether each dish contains rice, egg, meats, spicy, seafood, green, coconut-nut, coconut-milk, calories etc)

# Getting Data

## Web Scraping

Tweaked web scraper article to scrape 16 tables from Wikipedia.com. We scraped over 300 Thai dishes. For each dish, we got:

- Thai name
- Thai script
- English name
- Region
- Description
- Description2\*

After discovering that the hyper-linked text in the Description column did not get scrapped, I created an empty column ('Description2'), then set it
to a list comprehension where I looped through each row (a list) and joined the strings in each list. A by product is _not_ having to flatten the column of lists.

Note: Also discovered missing words in the Thai_name column which suggests we need a tweak in how this column was scrapped in Python.

## Data Cleaning

After scraping data, I transformed them into data frames in _Pandas_ before porting over to R. I made the following changes:

- Changing column names (snake case)
- Remove newline escape sequence (\n)
- Add/Mutate new columns:
- major_groupings (individual, shared, savory, sweet, drinks)
- minor_groupings (rice, noodles, curries, soups, salads, grilled etc.)
- Edit rows for missing data in Thai_name column: 26, 110, 157, 234-238, 240, 241, 246

- save to "edit_thai_dishes.csv"

- _note_:

1. Discovered that hyper-linked text in the Description column did not get scrapped. Must redo. `Done`
2. Discovered that some text in the Thai_name column did not get propertly scrapped. Could redo (but already manually added missing words).

# EDA

## Visualizations

- Dendrogram ([see](https://github.com/PaulApivat/thai_dishes/blob/main/png/indiv_thai_dishes.png))
- Dendrogram (circular with geom_node_text rotating for maximum readability); major challenge figured out with help from [this article](https://atrebas.github.io/post/2019-06-08-lightweight-dendrograms/) ([see](https://github.com/PaulApivat/thai_dishes/blob/main/png/shared_dishes_final.png))

- Completed Dendrogram with working `geom_node_text` to improve Circular Dendrogram readability. This was submitted as a [pull request](https://github.com/holtzy/R-graph-gallery/pull/34) to contribute to the project.

#### Text Mining Visualizations

- [Word Frequency](https://github.com/PaulApivat/thai_dishes/blob/main/png/word_freq_barchart.png)
- [Work Frequency comparison between Individual & Shared dishes](https://github.com/PaulApivat/thai_dishes/blob/main/png/word_freq_indiv_shared_dishes.png)
- Facet wrap of `td_idf` for Thai dishes [sub-grouping](https://github.com/PaulApivat/thai_dishes/blob/main/png/high_td_idf_thai_dishes.png)
- [Network of Thai dish names](https://github.com/PaulApivat/thai_dishes/blob/main/png/network_thai_ingredients.png)
- [Network within Thai Salad](https://github.com/PaulApivat/thai_dishes/blob/main/png/thai_salad_correlation.png)

# Analysis

## Text Analysis

Apply tidy principles to unstructured text to observe the one-token-per-row format using the {tidytext} package.
Find word frequencies, observe zipf's law, compare word frequencies between documents, find `tf_idf`, visualize long tail distribution of word frequencies and a _facet_ bar chart comparing the most important words (using `tf_idf`).

This helps us understand that the most frequent raw material (mu - pork), is not necessarily the most important for each sub-grouping of Thai dishes.

From the initial question of :

> What kind of insight can we gain from doing Text Analysis on the Thai Name and Description of each dish?

We can find out the most common raw materials/ingredients across dishes. Then, within sub-grouping we can find out what word is most important (among a list of Thai dish names).

- use `unnest_tokens()` to manipulate words into one-per-row format
- use [bar chart](https://github.com/PaulApivat/thai_dishes/blob/main/png/word_freq_barchart.png) to visualize frequency
- use `geom_abline` and `geom_jitter` with `scale_x_log10` to re-scale both axes; Rice dishes compared to others in [word frequencies](https://github.com/PaulApivat/thai_dishes/blob/main/png/rice_word_freq_compare.png)
- visualize [zipf's law](https://github.com/PaulApivat/thai_dishes/blob/main/png/zipf_thai_dishes.png)
- visualize tf_idf using [facet bar charts](https://github.com/PaulApivat/thai_dishes/blob/main/png/high_td_idf_thai_dishes.png) in `ggplot2`.
- use `unnest_tokens()` to identify `bi-grams` (token = "ngrams", n = 2) between words
- separate `bi-grams` into two words, filter for certain words (e.g., "khao") to see what is most often paired with that word, then `group_by` and `count`
- rank bi-grams by `tf-idf`
- visualize network of bi-grams using `igraph` and `ggraph`, `graph_from_data_frame()`
- can target specific sub-groups to visualize networks (i.e., Thai salads)

# Results

This project has primarily been exploratory. Here are some interesting hypotheses for further testing:

1. The top five words in Individual Dishes will be different from Shared Dishes.
2. The most central raw material for Individual Dishes will be different from Shared Dishes.
3. Shared dishes will feature more curries, soups and salads.
4. Individual dishes will feature more rice or noodles.

We found pork ("mu") to be the most common word, but the most important word varies by dish type.
The most highly correlated word-pairs are: "khao" + "phat", "nam" + "phrik" and "mu" + "korp".

### Potential Next Steps

Thai Dish Project

1. Re-evaluate web-scrapping to ensure minimal missing data
2. Make web-scrapping code more DRY
3. Find way to convert data.frame to dictionary data structure with ingredients for each dish (potential open source contribution)

Twitter Text Mining

1. Extend Text Mining learning for Twitter case;
2. Revisit Sentiment Analysis in Python, apply to Twitter data
3. Compare Sentiment Analysis in Python vs {tidytext} in R
4. Go through end-to-end Text Mining in R vs Python for Twitter data

## Presentation / Productionization

Next step: Create Blog Series with this Project
