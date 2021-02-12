# tidy_data.R
# Practice problems, Ch. 12 of R for Data Science
# Isabel Hanewicz
# 12 Feb 2021

# Libraries
library(tidyverse)

## 12.2.1 ##
# 2
# Compute rate for table2
t2_cases <- filter(table2, type=="cases") %>%
  arrange(country, year)
t2_pop <- filter(table2, type=="population") %>%
  arrange(country, year)
t2_rate <- tibble(
  year = t2_cases$year,
  country = t2_cases$country,
  cases = t2_cases$count,
  population = t2_pop$count,
) %>%
  dplyr::mutate(rate = (cases/population)*10000) %>%
  dplyr::select(country, year,rate)

t2_rate <- t2_rate %>%
  mutate(type="rate") %>%
  rename(count=rate)

bind_rows(table2, t2_rate)

## 12.3.3. ##
# 2 
# No backticks around 1999 or 2000

# 3 create vectors because there are two phillip woods w/ diff ages

# 4
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
preg_tidy <- preg %>%
  pivot_longer(c("male", "female"), names_to="sex", values_to="count")

## 12.4.3. ##
# remove = discards the input columns that you were separating
# FALSE = you want to keep non-separated column

## 12.5.1 ##
# Fill - replace the na's with the previous non-NA or the next non-NA

## 12.6.1 ##
# 1
# May be reasonable depending on whether there are 0s and NAs in the dataset or 
# just 0s

# 3
who1 <- who %>% 
  pivot_longer(
    cols = new_sp_m014:newrel_f65, 
    names_to = "key", 
    values_to = "cases", 
    values_drop_na = TRUE
  )
who2 <- who1 %>% 
  mutate(names_from = stringr::str_replace(key, "newrel", "new_rel"))
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

select(who3, country, iso2, iso3) %>%
  distinct() %>%
  group_by(country) %>%
  filter(n() > 1) # iso2, iso3 are redundant 