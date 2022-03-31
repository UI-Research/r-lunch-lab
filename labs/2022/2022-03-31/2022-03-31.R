# Today's example is about the importance of visualizing data
#
# It uses the classic Anscombe's Quartet data set
#
# Consider four data with 10 observations each and x and y. The four data sets
# have identical mean and sample variance for x, and nearly identical mean of
# y, sample variance of y, correlation between x and y, regression line, and
# coefficient of determination.

library(tidyverse)

theme_set(theme_minimal())

tidy_anscombe <-
  anscombe %>%
  # make the wide data too long
  pivot_longer(everything(), names_to = "names", values_to = "value") %>%
  # split the axis and quartet id
  mutate(
    coord = str_sub(names, start = 1, end = 1),
    quartet = str_sub(names, start = 2, end = 2)
  ) %>%
  group_by(quartet, coord) %>%
  mutate(id = row_number()) %>%
  # make the data tidy
  pivot_wider(id_cols = c(id, quartet), names_from = coord, values_from = value) %>%
  ungroup() %>%
  select(-id)


# Exercise 1 --------------------------------------------------------------

## 1. Create a scatter plot with `x = x`, `y = y`, and `geom_smooth(method = "lm", se = FALSE)`

## 2. Add facet_wrap() based on the quartet variable

## 3. Add geom_point()

# Exercise 2 --------------------------------------------------------------

## 1. Add x and y as aesthetic mappings

## Add geom_point() with alpha = 0.2

## facet_wrap() the data by the dataset variable

read_tsv(here::here("data", "DatasaurusDozen.tsv")) %>%
  ggplot()
