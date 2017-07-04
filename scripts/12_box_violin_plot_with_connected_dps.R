# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')

# Create data
# ------------------------------------------------------------------------------
set.seed(584433)
n = 50
d = tibble(ID = 1:n, a = rnorm(n), b = rnorm(n), c = rnorm(n)) %>%
  gather(key='group',value='measurement',-ID) %>% 
  mutate(group = factor(group),ID = factor(ID))

# Create plot
# ------------------------------------------------------------------------------
d %>% 
  ggplot(aes(x = group, y = measurement)) +
  geom_violin(adjust = 0.5) +
  geom_boxplot(aes(fill = group), width = 0.2, alpha = 0.5) +
  geom_point() +
  geom_line(aes(group = ID), colour = 'darkgrey', alpha = 0.5) +
  theme_bw()
