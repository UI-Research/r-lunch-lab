library(palmerpenguins)
library(tidyverse)
library(urbnthemes)

set_urbn_defaults()

penguins_df = palmerpenguins::penguins %>%
  filter(!is.na(bill_length_mm) &!is.na(bill_depth_mm))


# --------- Text styling ---------------------
library(ggtext)

# Regular ol scatterplot of penguins dataset
penguins_df %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species), alpha = 0.6) +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       title = "Bill dimensions of Adelie, Chinstrap and Gentoo penguins") +
  scale_y_continuous(expand = expansion(mult = c(0.3, 0.3))) +
  scale_x_continuous(expand = expansion(mult = c(0.3, 0.3)))

# Style the text in the title using markdown!
penguins_df %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species), alpha = 0.6) +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       title = "Bill dimensions of *Adelie*, Chinstrap and Gentoo penguins") +
  theme(plot.title = element_markdown())


# You can even use HTML to color code words
title_text = "Bill dimensions of <b style='color:#1696d2;'> Adelie,</b> <b style='color:#fdbf11;'>Chinstrap</b> and <b style='color:#000000;'>Gentoo</b> penguins"

penguins_df %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species), alpha = 0.6) +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       title = title_text) +
  theme(plot.title = element_markdown())

# ---------- Annotations -------------
library(ggforce)

# geom_mark_* can be powerful for marking things!
penguins_df %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = species), alpha = 0.6) +
  scale_y_continuous(expand = expansion(mult = c(0.3, 0.3))) +
  scale_x_continuous(expand = expansion(mult = c(0.3, 0.3))) +
  geom_mark_hull(aes(label = species, fill = species),
                   ) +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       title = title_text) +
  theme(plot.title = element_markdown()) +
  guides(fill = FALSE, color = FALSE)


library(gghighlight)

diamonds %>%
  ggplot(aes(x = price, y = depth)) +
  geom_point(alpha = 0.3) +
  gghighlight(cut == "Fair")



# ------- Adjusting legends -----------


penguins_df %>%
  ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(color = body_mass_g), alpha = 0.8) +
  labs(x = "Bill Length (mm)",
       y = "Bill Depth (mm)",
       color = "Body Mass",
       title = "Some penguins are heavier than others!") +
  guides(color = guide_colorbar(
    title.hjust = 0.5,
    title.position = "top",
    barwidth = unit(20, "lines"),
    barheight = unit(0.5, "lines")
  )) +
  theme(legend.title = element_text())
