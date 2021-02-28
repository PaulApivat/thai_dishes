# Thai Dishes: Project Overview

## Motivation

- What is this project?
- What drives this project? People need to know they have other choices aside from Pad Thai.
- What questions are you answering?

## Initial Scope

- Phase 1: Scrape the Thai Dishes table from wikipedia. Clean the data. Run exploratory analysis to get some insights. Use Python for web scraping, R for data wrangling and visualization.

- Next: Potentially use Text Analysis

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

# Documenting Progress

- Project walk through
- Daily progress
- 2/24 - web scraping (Description)
- 2/25 - data cleaning & transformation
- 2/27 & 2/28 - figured out two dendrograms, normal and circular w/ geom_node_text readability

- (next step): finalize Circular Dendrogram for Shared Thai food; add annotations to sub-groups

- Explore potential to apply text analytics

- Contribute to open source in 2 ways:

1. contribute Thai_dishes to thai_food_open_data on github
2. contribute Update to circular dendrogram for R Gallery

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

## Data Cleaning

After scraping data, I transformed them into data frames in _Pandas_ before porting over to R. I made the following changes:

- Changing column names (snake case)
- Remove newline escape sequence (\n)
- Add/Mutate new columns: major_groupings (individual, shared, savory, sweet, drinks)
- _note_: Discovered that hyper-linked text in the Description column did not get scrapped. Must redo. `Done`

# EDA

## Visualizations

- Dendrogram
- Dendrogram (circular with geom_node_text rotating for maximum readability); major challenge figured out with help from

# Analysis

- TBD

# Results

- TBD

## Presentation / Productionization
