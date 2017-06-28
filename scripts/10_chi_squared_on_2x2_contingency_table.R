# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')

# Do
# ------------------------------------------------------------------------------
# Set seed for reproducibility
set.seed(421284)

# Set number of samples
n_women = 700

# Create data tibble
d = tibble(id           = seq(from = 1, to = n_women),
           intervention = sample(x = c(0,1), size = n_women, replace = TRUE),
           high_vit_d   = sample(x = c(0,1), size = n_women, replace = TRUE)) %>% 
  mutate(i_h_0_0 = ifelse(intervention == 0 & high_vit_d == 0, 1, 0),
         i_h_1_0 = ifelse(intervention == 1 & high_vit_d == 0, 1, 0),
         i_h_0_1 = ifelse(intervention == 0 & high_vit_d == 1, 1, 0),
         i_h_1_1 = ifelse(intervention == 1 & high_vit_d == 1, 1, 0))

# Create 2x2 contingency table
m = matrix(c(sum(d$i_h_0_0),sum(d$i_h_0_1),
             sum(d$i_h_1_0),sum(d$i_h_1_1)),
           nrow=2,ncol=2,byrow = TRUE)
rownames(m) = c('intervention_0','intervention_1')
colnames(m) = c('high_vit_d_0','high_vit_d_1')

# Perform chi-squared test
chisq.test(x = m)
