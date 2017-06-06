# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('cowplot')
library('broom')

# Create data
# ------------------------------------------------------------------------------

# Set seed for random number generation, to ensure reproducibility 
set.seed(771160)

# Create linear data: y = a + b * x + e, where
# Intercept: a = 0.2 * (-1,1)
# Slope:     b = (b_1,b_2)
# Residuals: e = random normal numbers
b_1 = 1
b_2 = 2
X   = tibble(x  = rnorm(100), # x-values
             cl = sample(c(-1,1), 100, replace = TRUE), # class assignment
             y  = 0.2*cl + ifelse(cl == 1, b_1 * x, b_2 * x) + rnorm(100) # y-values
             ) %>% 
  mutate(cl = factor(cl))

# View data
# ------------------------------------------------------------------------------
p1 = X %>% ggplot(aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = 'lm') + 
  theme_bw() +
  labs(title = 'Model 1')

p2 = X %>% ggplot(aes(x = x, y = y, colour = cl)) +
  geom_point() +
  geom_smooth(method = 'lm') + 
  theme_bw() +
  labs(title = 'Model 2')

plot_grid(p1,p2) %>% print

# Do Anova Analysis and display output
# ------------------------------------------------------------------------------
# Model 1
m1 = X %>% lm(formula = y ~ x, data = .)
m1 %>% summary %>% print
m1 %>% anova %>% print

# Model 2
m2 = X %>% lm(y ~ x * cl, data = .)
m2 %>% summary %>% print
m2 %>% anova %>% print

# Combined
anova(m1,m2) %>% print
