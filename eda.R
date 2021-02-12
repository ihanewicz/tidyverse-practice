# eda.R
# Practice problems, Ch. 7 of R for Data Science
# Isabel Hanewicz
# 12 Feb 2021

# Libraries
library(tidyverse)
library(dplyr)
library(nycflights13)
library(hexbin)

## 7.3.4 ##
# 1
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = x), binwidth = 0.5)
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) + 
  coord_cartesian(xlim=c(0,15))
ggplot(diamonds) + 
  geom_histogram(mapping = aes(x = z), binwidth = 0.5) +
  coord_cartesian(xlim=c(0,8))

# 2
ggplot(diamonds) +
  geom_histogram(mapping=aes(x=price), binwidth=250)

# 3
filter(diamonds, carat == 0.99) # 23
filter(diamonds, carat == 1) #1,558
diamonds %>%
  dplyr::filter(carat >= 0.95, carat <= 1.05) %>%
  dplyr::count(carat) %>%
  print(n=Inf) # Big price benefit to 1 vs. 0.99 carats?

## 7.4.1 ##
# 1
# Missing values removed in a histogram (continuous data)
# Missing values in NA category in bar chart (non-continuous)

# 2
# na.rm = removes na before calculating

## 7.5.11 ##
# 2
# Use carat as strongest predictor of price
ggplot(diamonds, aes(x = cut, y = carat)) +
  geom_boxplot() # lower quality cut -> larger carat diamonds

## 7.5.21 ##
# 2
flights %>%
  group_by(month, dest) %>%
  dplyr::summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x=factor(month), y=dest, fill=dep_delay)) +
  geom_tile()
# Really hard to read destinations because there are so many -
# group into subsets to make readable
# and only graph dest groups w/ departaure delays? ignore 0s?
  
# 3
# Color has more categories than cut, so it's better on the x axis

## 7.5.3.1 ##
# 2
ggplot(data = diamonds, mapping = aes(x = price, y = carat)) + 
  geom_boxplot(mapping = aes(group = cut_width(price, 1000)))

# 3
# Price distribution of large diamonds is larger (more variable) 
# than small diamonds

# 4
ggplot(data = diamonds, mapping=aes(x=cut_width(carat, 0.1, boundary=0), y=price)) +
  geom_boxplot() +
  facet_wrap(~cut, ncol=1)

