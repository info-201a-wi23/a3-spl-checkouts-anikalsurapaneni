# Load libraries
library(knitr)
library(tidyverse)
library(dplyr)
library(stringr)
library(plotly)

# Load data
all_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2022-2023-All-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

all_checkouts <- all_checkouts %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
all_checkouts$date <- as.Date(all_checkouts$date, format = "%Y-%m-%d")


austen_df <- all_checkouts %>% 
  filter(str_detect(Creator, "Jane")) %>% 
  filter(str_detect(Creator, "Austen")) %>%
  mutate(title_group = str_sub(Title, end = 20)) %>% 
  group_by(title_group, date) %>% 
  summarize(total_checkouts = sum(Checkouts, na.rm = TRUE)) %>% 
  ungroup() %>% 
  mutate(Title = paste0(title_group, " (", n(), ")")) %>%
  select(-title_group)

title_checkouts_by_month_plot <- ggplot(austen_df, aes(x = date, y = total_checkouts, color = Title, group = Title)) +
  geom_line() +
  scale_color_discrete(name = "Title") +
  labs(title = "Jane Austen Checkouts by Title in 2022", 
       x = "Date", 
       y = "Total Checkouts")

ggplotly(title_checkouts_by_month_plot, tooltip = c("x", "y"))
