# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('readr')

# Set seed
# ------------------------------------------------------------------------------
set.seed(949886) # This controls that the 'random' dummy numbers below will be 
                 # the same each time this script is run

# Create dummy data for linear regression
# ------------------------------------------------------------------------------
n_dpoints = 100
my_data   = tibble( id = n_dpoints %>% sample,
                    x  = n_dpoints %>% rnorm %>% sort %>% round(3),
                    y  = n_dpoints %>% rnorm %>% sort %>% round(3)) %>% 
  arrange(id)
write_delim(x = my_data, path = 'data/linear_regression.txt', delim = "\t")

# Create dummy data for logistic regression
# ------------------------------------------------------------------------------
n_dpoints = 100
x = n_dpoints %>% rnorm %>% round(3)
y = rep(NA,n_dpoints)
for( i in 1:n_dpoints ){
  y[i] = ifelse(x[i]<0,
                sample(x = c(0,1),size = 1,prob = c(0.975,0.025)),
                sample(x = c(0,1),size = 1,prob = c(0.025,0.975)) )
}

my_data   = tibble( id = n_dpoints %>% sample,
                    x  = x,
                    y  = y ) %>% 
  arrange(id)

write_delim(x = my_data, path = 'data/logistic_regression.txt', delim = "\t")

# Create dummy data for quantile analysis
# ------------------------------------------------------------------------------
n_dpoints = 100
my_data   = tibble( id = n_dpoints %>% sample,
                    x  = n_dpoints %>% rnorm %>% sort %>% round(3) ) %>% 
  arrange(id)
write_delim(x = my_data, path = 'data/quantile_analysis.txt', delim = "\t")

# Create dummy data for stratification analysis
# ------------------------------------------------------------------------------
n_dpoints = 100
my_data   = tibble( id = n_dpoints %>% sample,
                    x  = n_dpoints %>% rnorm %>% sort %>% round(3),
                    y  = n_dpoints %>% rnorm %>% sort %>% round(3),
                    z  = n_dpoints %>% sample(x = c(0,1), size = ., replace = TRUE)) %>%
  mutate(y = ifelse(z==0,y,y+1)) %>% 
  arrange(id)
write_delim(x = my_data, path = 'data/stratification_analysis.txt', delim = "\t")
