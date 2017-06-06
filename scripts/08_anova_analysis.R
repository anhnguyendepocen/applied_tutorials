# Clear workspace
# ------------------------------------------------------------------------------
rm(list=ls())

# Load libraries
# ------------------------------------------------------------------------------
library('tidyverse')
library('cowplot')

# Create data
# ------------------------------------------------------------------------------
set.seed(771160)
a_1 = 1
a_2 = 2
X   = tibble(x  = rnorm(100),
             cl = sample(c(-1,1), 100, replace = TRUE),
             y  = 0.2*cl + ifelse(cl==1, a_1 * x, a_2 * x) + rnorm(100)) %>% 
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

plot_grid(p1,p2)

# Do Anova Analysis
# ------------------------------------------------------------------------------
# Model 1
m1 = X %>% lm(formula = y ~ x, data = .)
summary(m1)
anova(m1)

# Model 2
m2 = X %>% lm(y ~ x * cl, data = .)
summary(m2)
anova(m2)

# Combined
anova(m1,m2)
