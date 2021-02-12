# tibbles.R
# Practice problems, Ch. 10 of R for Data Science
# Isabel Hanewicz
# 12 Feb 2021

# Libraries
library(tidyverse)
library(dplyr)
library(nycflights13)

## 10.5 ##
# 1
print(mtcars) # Tibble says it is a tibble when printing, default 10 rows, 
# and has the data name of the columns

# 2
df <- data.frame(abc = 1, xyz = "a")
df_t <- as_tibble(df)
df$x
df_t$x # tibble does not do partial matching
class(df[, "xyz"]) # character
df_t[, "xyz"] # tibble always returns a tibble
class(df[, c("abc", "xyz")]) # df
class(df_t[, c("abc", "xyz")]) # tibble

# 3
# use [[]] df[[var]]