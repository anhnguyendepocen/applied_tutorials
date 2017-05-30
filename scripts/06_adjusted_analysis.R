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
  geom_smooth(method='lm',formula = y ~ x) +
  geom_point() + 
  theme_bw()

# Perform a linear regression on the data raw and adjusted for z
# ------------------------------------------------------------------------------
my_model_raw = my_data %>% lm(formula = y ~ x, data = .) %>% summary %>% tidy
my_model_adj = my_data %>% lm(formula = y ~ x + z, data = .) %>% summary %>% tidy
print(my_model_raw)
print(my_model_adj)

# Visualise the data with the regression line and confidence bands
# ------------------------------------------------------------------------------
p2 = my_data %>%
  ggplot(aes(x = x, y = y, colour = z)) +
  geom_point() + 
  geom_smooth(method='lm',formula = y ~ x) +
  theme_bw()

my_plot = plot_grid(p1,p2)
print(my_plot)
