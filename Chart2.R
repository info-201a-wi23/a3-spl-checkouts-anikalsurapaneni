# Load libraries
library(knitr)
library(tidyverse)
library(dplyr)
library(stringr)
library(plotly)

# Load data
five_checkouts <- read.csv("~/Documents/Info201code/a3-spl-checkouts-anikalsurapaneni/2013-2023-5-Checkouts-SPL.csv")

five_checkouts <- five_checkouts %>% mutate(date = paste0(CheckoutYear, "-", CheckoutMonth, "-01"))
five_checkouts$date <- as.Date(five_checkouts$date, format = "%Y-%m-%d")

material_type_grouping_austen <- five_checkouts %>% 
  filter(str_detect(Creator, "Jane")) %>% 
  filter(str_detect(Creator, "Austen")) %>%
  group_by(MaterialType, date) %>%
  summarize(total_checkouts = sum(Checkouts, na.rm = TRUE))


material_type_grouping_austen_plot <- ggplot(material_type_grouping_austen, aes(x = date, y = total_checkouts, color = MaterialType)) +
  geom_line() +
  scale_y_continuous(limits = c(0, 500)) +
  labs(title = "Jane Austen Checkouts by Material Type over Time", 
       x = "Month", 
       y = "Total Checkouts",
       color = "Material Type")

ggplotly(material_type_grouping_austen_plot, tooltip = c("x", "y"))
