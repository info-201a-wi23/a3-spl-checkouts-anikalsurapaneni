# Load libraries
library(knitr)
library(tidyverse)
library(dplyr)
library(stringr)

# Load data
ten_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2017-2023-10-Checkouts-SPL-Data.csv")

# Filtered data for Pride and Prejudice
pride_and_prejudice_checkouts <- ten_checkouts %>% 
  filter(str_detect(Creator, "Jane")) %>% 
  filter(str_detect(Creator, "Austen")) %>%
  filter(Title == "Pride and Prejudice")

# Filtered data for Pride and Prejudice unabridged
pride_and_prejudice_unabridged_checkouts <- ten_checkouts %>% 
  filter(str_detect(Creator, "Jane")) %>% 
  filter(str_detect(Creator, "Austen")) %>%
  filter(Title == "Pride and Prejudice (unabridged)")

pride_and_predjudice_checkouts_bind <- bind_rows(pride_and_prejudice_checkouts, pride_and_prejudice_unabridged_checkouts)

# Stacked bar chart comparing checkouts of both versions
stacked_bar_chart_with_both_versions <- ggplot(pride_and_predjudice_checkouts_bind, aes(x = CheckoutMonth, fill = Title)) +
  geom_bar(position = "stack", stat = "count") +
  scale_x_discrete(labels = c("J", "F", "M", "A", "M", "J",
                              "J", "A", "S", "O", "N", "D")) +
  labs(title = "Bar Chart of Pride and Prejudiced Versions",
       x = "Checkout Month",
       y = "Number of Checkouts",
       fill = "Book Title")

ggplotly(stacked_bar_chart_with_both_versions, tooltip = c("x", "y"))
