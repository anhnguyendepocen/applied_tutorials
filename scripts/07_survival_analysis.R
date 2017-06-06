# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('readr')
library('survival')

# Load data
# ------------------------------------------------------------------------------
data(lung)
my_data = lung %>% as_tibble
remove(lung)
print(my_data)

# Do Survival Analysis
# ------------------------------------------------------------------------------
# Create survival object. status == 2 is death
my_data$surv_obj = with(my_data, Surv(time = time, event = (status == 2)))

print(my_data)
