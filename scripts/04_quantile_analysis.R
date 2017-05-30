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
my_data = read_delim(file = 'data/quantile_analysis.txt', delim = "\t")

# Visualise the data
# ------------------------------------------------------------------------------
my_data %>%
  ggplot(aes(x = x)) +
  geom_density() + 
  theme_bw()

# Perform a quantile anaylsis on the data
# ------------------------------------------------------------------------------
my_quantiles = my_data %>%
  select(x) %>%
  as_vector %>%
  quantile(seq(from = 0, to = 1, by = 0.25)) %>%
  tidy %>%
  rename(lines=names) %>% 
  mutate(lines=factor(lines, levels = c('0%','25%','50%','75%','100%')))
print(my_quantiles)

# Visualise the data including the quantiles
# ------------------------------------------------------------------------------
p1 = my_data %>%
  ggplot(aes(x = x)) +
  geom_density() + 
  geom_vline(aes(xintercept = x, colour = lines),
             data = my_quantiles, linetype = 'dashed', lwd = 1) +
  theme_bw()
print(p1)
