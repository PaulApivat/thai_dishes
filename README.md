# Thai Dishes: Project Overview

## Motivation

- What is this project?

- What drives this project?

People need to know they have other choices aside from Pad Thai. In fact Pad Thai is one of 53 individual dishes and there are at least 201 shared dishes in Thai cuisine.

This project is an opportunity to build a dataset of Thai dishes by scrapping tables off Wikipedia. The project is an opportunity to further Python and R skills. Using Python for web scrapping and R for exploratory analysis. Web scrapping is done in Beautiful Soup (`Python`) and pre-processed further with `dplyr` and visualized with `ggplot2`.

This project will also be used to make an **open source** contribution (i.e., Circular Dendrogram with Rotating Text).

In the second phase, I hope to learn Text Analysis to see what kind of insights I could gain from analyzing the Thai Name and Description of each dish.

- What questions are you answering?

Initially, the questions are exploratory:

How might we organized Thai dishes?
What is the best way to organized the different dishes?

What kind of insight can we gain from doing Text Analysis on the Thai Name and Description of each dish?

## Initial Scope

- Phase 1: Scrape the Thai Dishes table from [Wikipedia](https://en.wikipedia.org/wiki/List_of_Thai_dishes). Clean the data. Run exploratory analysis to get some insights. Use Python for web scraping, R for data wrangling and visualization.

- Phase 1a: Make open source contribution to [R Graph Gallery](https://www.r-graph-gallery.com/index.html)

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

**Wikipedia: Thai Dishes**: https://en.wikipedia.org/wiki/List_of_Thai_dishes

# Documenting Progress

- Project walk through
- Daily progress
- 2/24 - web scraping (Description)
- 2/25 - data cleaning & transformation
- 2/27 & 2/28 - figured out two dendrograms, normal and circular w/ geom_node_text readability
- Shared visualization along with essay: [Thread 1]

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
- Add/Mutate new columns:
- major_groupings (individual, shared, savory, sweet, drinks)
- minor_groupings (rice, noodles, curries, soups, salads, grilled etc.)
- Edit rows for missing data in Thai_name column: 26, 110, 157, 234-238, 240, 241, 246

- save to "edit_thai_dishes.csv"

- _note_: Discovered that hyper-linked text in the Description column did not get scrapped. Must redo. `Done`

# EDA

## Visualizations

- Dendrogram ([see](https://github.com/PaulApivat/thai_dishes/blob/main/png/indiv_thai_dishes.png))
- Dendrogram (circular with geom_node_text rotating for maximum readability); major challenge figured out with help from [this article](https://atrebas.github.io/post/2019-06-08-lightweight-dendrograms/) ([see](https://github.com/PaulApivat/thai_dishes/blob/main/png/shared_dishes_final.png))
-

# Analysis

- TBD

# Results

- TBD

## Presentation / Productionization
