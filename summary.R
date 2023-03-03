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

average_checkouts_per_Austen_book

# Month with the most checkouts for the digital copy of "Emma"
most_checkouts_for_emma_digital <- all_checkouts %>%
  filter(Creator == "Jane Austen", UsageClass == "Digital", Title == "Emma") %>%
  group_by(CheckoutMonth) %>%
  summarize(max_checkouts = max(Checkouts, na.rm = TRUE)) %>%
  filter(max_checkouts == max(max_checkouts)) %>%
  pull(CheckoutMonth)

most_checkouts_for_emma_digital

# Month with the most checkouts for the physical copy of "Emma"
most_checkouts_for_emma_physical <- all_checkouts %>%
  filter(Creator == "Jane Austen" & UsageClass == "Physical" & Title == "Emma") %>%
  group_by(CheckoutMonth) %>%
  summarize(max_checkouts = max(Checkouts, na.rm = TRUE)) %>%
  filter(max_checkouts == max(max_checkouts)) %>%
  pull(CheckoutMonth)

most_checkouts_for_emma_physical

# Checkout Year for the least checkouts for the book "Lady Susan"
least_checkouts_for_lady_susan <- five_checkouts %>%
  filter(Creator == "Jane Austen" & Title == "Lady Susan") %>%
  group_by(CheckoutYear) %>%
  summarize(min_checkouts = min(Checkouts, na.rm = TRUE)) %>%
  filter(min_checkouts == min(min_checkouts)) %>%
  pull(CheckoutYear)

least_checkouts_for_lady_susan

# Number of total Emma checkouts from 2022 to 2023
emma_print_checkouts <- all_checkouts %>%
  filter(Creator == "Jane Austen" & Title == "Emma" & CheckoutYear >= 2022 & CheckoutYear <= 2023) %>%
  group_by(Title) %>%
  summarize(total_checkouts = sum(Checkouts))

emma_print_checkouts
