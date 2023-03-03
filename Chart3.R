# Load libraries
library(knitr)
library(tidyverse)
library(dplyr)
library(stringr)

# Load data
ten_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2017-2023-10-Checkouts-SPL-Data.csv")

# Filtered data for Emma
emma_checkouts <- ten_checkouts %>% 
  filter(str_detect(Creator, "Jane")) %>% 
  filter(str_detect(Creator, "Austen")) %>%
  filter(Title == "Emma")

# Filtered data for Pride and Prejudice
pride_and_prejudice_checkouts <- ten_checkouts %>% 
  filter(str_detect(Creator, "Jane")) %>% 
  filter(str_detect(Creator, "Austen")) %>%
  filter(Title == "Pride and Prejudice")

emma_and_pride_checkouts_bind <- bind_rows(emma_checkouts, pride_and_prejudice_checkouts)

# Stacked bar chart comparing checkouts of both books
stacked_bar_chart_with_both_books <- ggplot(emma_and_pride_checkouts_bind, aes(x = CheckoutMonth, fill = Title)) +
  geom_bar(position = "stack", stat = "count") +
  scale_x_discrete(labels = c("J", "F", "M", "A", "M", "J",
                              "J", "A", "S", "O", "N", "D")) +
  labs(title = "Bar Chart of Emma Checkouts by Checkout Month",
       x = "Checkout Month",
       y = "Number of Checkouts",
       fill = "Book Title")

ggplotly(stacked_bar_chart_with_both_books, tooltip = c("x", "y"))