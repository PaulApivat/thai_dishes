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


# Add Major AND Minor Groupings ----
df <- df %>%
    mutate(
        major_grouping = as.character(NA),
        minor_grouping = as.character(NA)
        )
    
# Account for Individual vs Shared, Savoury, Sweet or Drinks
df[1:53,]$major_grouping <- 'Individual dishes'
df[54:254,]$major_grouping <- 'Shared dishes'
df[255:280,]$major_grouping <- 'Savory snacks'
df[281:311,]$major_grouping <- 'Sweet snacks'
df[312:328,]$major_grouping <- 'Drinks'

# Account for Minor grouping
df[1:22,]$minor_grouping <- 'Rice dishes'
df[23:46,]$minor_grouping <- 'Noodle dishes'
df[47:53,]$minor_grouping <- 'Misc Indiv'
df[54:93,]$minor_grouping <- 'Curries'
df[94:104,]$minor_grouping <- 'Soups'
df[105:156,]$minor_grouping <- 'Salads'
df[157:190,]$minor_grouping <- 'Fried and stir-fried dishes'    #need to change #157 to Kai phat khing [done]
df[191:209,]$minor_grouping <- 'Deep-fried dishes'
df[210:228,]$minor_grouping <- 'Grilled dishes'
df[229:232,]$minor_grouping <- 'Steamed or blanched dishes'
df[233,]$minor_grouping <- 'Stewed dishes'
df[234:249,]$minor_grouping <- 'Dipping sauces and pastes'   # need Editing
df[250:254,]$minor_grouping <- 'Misc Shared'
df[255:280,]$minor_grouping <- 'Savory snacks'
df[281:311,]$minor_grouping <- 'Sweet snacks'
df[312:328,]$minor_grouping <- 'Drinks'


# Edit Rows for missing Thai_name
df[26,]$Thai_name <- "Khanom chin nam ngiao"

df[110,]$Thai_name <- "Lap Lanna"

df[157,]$Thai_name <- "Kai phat khing"

df[234,]$Thai_name <- "Nam chim chaeo"
df[235,]$Thai_name <- "Nam chim kai"
df[236,]$Thai_name <- "Nam chim paesa"
df[237,]$Thai_name <- "Nam chim sate"
df[238,]$Thai_name <- "Nam phrik i-ke"
df[240,]$Thai_name <- "Nam phrik kha"
df[241,]$Thai_name <- "Nam phrik khaep mu"
df[246,]$Thai_name <- "Nam phrik pla chi"



# Write new csv to save edits made to data frame
write_csv(df, "edit_thai_dishes.csv")



# Dendrogram
library(ggraph)
library(igraph)

df %>%
    select(major_grouping, minor_grouping, Thai_name, Thai_script)




## NOTE ##
## Web-Scrapping Process need to get text from links [DONE]


