# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('readr')
library('broom')
library('cowplot')

# Load data
# ------------------------------------------------------------------------------
my_data = read_delim(file = 'data/stratification_analysis.txt', delim = "\t")
my_data = my_data %>% mutate(z = factor(z))

# Visualise the data
# ------------------------------------------------------------------------------
p1 = my_data %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() + 
  theme_bw()

# Perform a linear regression on the data stratified on z
# ------------------------------------------------------------------------------
my_models_tidy = my_data %>%
  group_by(z) %>%
  do(model = lm(data=., y ~ x) %>% tidy %>% slice(2),
     ci    = lm(data=., y ~ x) %>% confint %>% tidy %>% slice(2),
     n     = nrow(.) ) %>%
  unnest(model,ci, n) %>% 
  select(-.rownames) %>% 
  rename(ci_2.5 = X2.5.., ci_97.5 = X97.5..)
print(my_models_tidy)

# Visualise the data with the regression line and confidence bands
# ------------------------------------------------------------------------------
p2 = my_data %>%
  ggplot(aes(x = x, y = y, colour = z)) +
  geom_point() + 
  geom_smooth(method='lm',formula = y ~ x) +
  theme_bw()

my_plot = plot_grid(p1,p2)
print(my_plot)
