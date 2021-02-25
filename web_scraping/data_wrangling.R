library(tidyverse)

# load data ----
df <- read_csv("thai_dishes.csv")

str(df)



# exploratory ----
df %>% str()

# change column name ----
df <- df %>%
    rename(
        Thai_name = `Thai name`,
        Thai_script = `Thai script`,
        English_name = `English name`
    )

df %>%
    select(Description, Description2)

# tally Columns Region
df %>%
    group_by(Region) %>%
    tally(sort = TRUE)

df %>%
    count(Region)

df %>%
    count(`Thai_name`)

# remove  \n from all columns ----
df$Thai_name <- gsub("[\n]", "", df$Thai_name)
df$Thai_script <- gsub("[\n]", "", df$Thai_script)
df$English_name <- gsub("[\n]", "", df$English_name)
df$Image <- gsub("[\n]", "", df$Image)
df$Region <- gsub("[\n]", "", df$Region)
df$Description <- gsub("[\n]", "", df$Description)
df$Description2 <- gsub("[\n]", "", df$Description2)

df$Image
df$Region
df$Description2

# Count individual words ----

# Count by individual words in Thai_name column [English works better]
df %>%
    separate_rows(Thai_name, sep = ' ') %>%
    group_by(Thai_name = tolower(Thai_name)) %>%
    group_by(Thai_name) %>%
    tally(sort = TRUE) %>%
    view()

# Count by individual words in Thai_script column
df %>%
    separate_rows(Thai_script, sep = ' ') %>%
    group_by(Thai_script = tolower(Thai_script)) %>%
    group_by(Thai_script) %>%
    tally(sort = TRUE) %>%
    view()
    
# Count by individual words in Description2
df %>%
    separate_rows(Description2, sep = ' ') %>%
    group_by(Description2 = tolower(Description2)) %>%
    group_by(Description2) %>%
    tally(sort = TRUE) 


# Add Major Grouping ----
df <- df %>%
    mutate(
        major_grouping = as.character(NA),
        )
    
# Account for Individual vs Shared, Savoury, Sweet or Drinks
df[1:53,]$major_grouping <- 'Individual dishes'
df[54:254,]$major_grouping <- 'Shared dishes'
df[255:280,]$major_grouping <- 'Savory snacks'
df[281:311,]$major_grouping <- 'Sweet snacks'
df[312:328,]$major_grouping <- 'Drinks'



## NOTE ##
## Web-Scrapping Process need to get text from links [DONE]


