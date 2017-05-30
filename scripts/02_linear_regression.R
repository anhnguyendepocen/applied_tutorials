# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('readr')
library('broom')

# Load data
# ------------------------------------------------------------------------------
my_data = read_delim(file = 'data/linear_regression.txt', delim = "\t")

# Visualise the data
# ------------------------------------------------------------------------------
my_data %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() + 
  theme_bw()

# Perform a linear regression on the data
# ------------------------------------------------------------------------------
# Base model
my_model = my_data %>% lm( formula = y ~ x, data = .)

# Tidy model
my_model_tidy = my_model %>% summary %>% tidy %>% as_tibble

# Add confidence intervals
my_model_tidy = my_model %>%
  confint %>%
  tidy %>%
  full_join(x = my_model_tidy, y = ., by = c('term'='.rownames')) %>% 
  rename(ci_2.5 = X2.5.., ci_97.5 = X97.5..)

# Visualise the data with the regression line and confidence bands
# ------------------------------------------------------------------------------
my_data %>%
  ggplot(aes(x = x, y = y)) +
  geom_point() + 
  geom_smooth(method='lm',formula = y ~ x) +
  theme_bw()
