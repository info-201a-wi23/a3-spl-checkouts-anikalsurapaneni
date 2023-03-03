# Load packages
library(knitr)
library(tidyverse)
library(dplyr)

# Load data
five_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2013-2023-5-Checkouts-SPL.csv")
ten_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2017-2023-10-Checkouts-SPL-Data.csv")
all_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2022-2023-All-Checkouts-SPL-Data.csv")

# Average number of checkouts for each Austen book
average_checkouts_per_Austen_book <- all_checkouts %>%
  filter(Creator == "Jane Austen") %>%
  group_by(Title) %>%
  summarize(avg_checkouts = mean(Checkouts, na.rm = TRUE))

View(average_checkouts_per_Austen_book)

# Month with the most checkouts for the eBook copy of "Emma"
most_checkouts_for_emma_ebook <- all_checkouts %>%
  filter(Creator == "Jane Austen") %>%
  filter(UsageClass == "Digital") %>%
  filter(Title == "Emma") %>%
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>%
  group_by(CheckoutMonth) %>%
  pull(CheckoutMonth)

most_checkouts_for_emma_ebook

# Month with the most checkouts for the print copy of "Emma"
most_checkouts_for_emma_print <- all_checkouts %>%
  filter(Creator == "Jane Austen") %>%
  filter(UsageClass == "Physical") %>%
  filter(Title == "Emma") %>%
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>%
  group_by(CheckoutMonth) %>%
  pull(CheckoutMonth).

most_checkouts_for_emma_print

# Checkout Year for the least checkouts for the book "Lady Susan"
least_checkouts_for_lady_susan <- all_checkouts %>%
  filter(Creator == "Jane Austen") %>%
  filter(Title == "Lady Susan") %>%
  filter(Checkouts == min(Checkouts, na.rm = TRUE)) %>%
  group_by(CheckoutYear) %>%
  pull(CheckoutYear)

View(least_checkouts_for_lady_susan)

# Number of print book checkouts from 2022 to 2023
emma_print_checkouts <- all_checkouts %>%
  group_by('Title') %>%
  filter(Creator == "Jane Austen") %>%
  filter(Title == "Emma") %>%
  count(Title)
  
View(emma_print_checkouts)
  
