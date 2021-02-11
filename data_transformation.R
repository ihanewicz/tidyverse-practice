# data_transformation.R
# Practice problems, Ch. 5 of R for Data Science
# Isabel Hanewicz
# 11 Feb 2021

# Libraries
library(nycflights13)
library(tidyverse)
library(dplyr)

## 5.2.4 ##
# 1
# Arrival delay of >= 2 hours
filter(flights, arr_delay >= 120)

# 2 Flew to IAH or HOU
filter(flights, dest %in% c("IAH","HOU"))

# 3 United, American, Delta
filter(flights, carrier %in% c("UA", "AA", "DL"))

# 4 Departed in summer
filter(flights, month %in% c(7,8,9))

# 5 Arrived > 2 hours late, didn't leave late
filter(flights, dep_delay <= 0 & arr_delay >= 120)

# 6 Delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & (arr_delay < dep_delay-30))

# 7 Departed midnight - 6am
filter(flights, dep_time <= 600 | dep_time == 2400)

# 2
# between() -> if x is between two values, like for summer months

# 3
filter(flights, is.na(dep_time)) # 8255, these don't have dep_delay, arr_time, arr_delay 
# Canceled flights?

# 4
# Anything to the 0 is 1
# NA | TRUE would always evaluate to TRUE bc of the TRUE, regardless of NA value
# FALSE & NA would always evaluate to FALSE bc of the FALSE, regardless of NA value

## 5.3.1 ##
# 1
arrange(flights, desc(is.na(dep_time)), dep_time)

# 2
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)

# 3
arrange(flights, desc(distance/air_time))

# 4
arrange(flights, desc(distance))
arrange(flights, distance)

## 5.4.1 ##
# 1
select(flights, dep_time, dep_delay, arr_time, arr_delay)

# 2
select(flights, dep_time, dep_time) # It only shows up once

# 3
# any_of() - if any of the variables are present
# can do any_of(vars)

# 4
select(flights, contains("TIME")) # Result looks for time in variable names, does not take into account case
# ignore.case

## 5.5.2 ##
# Note - going to start doing a few diff problems per chapter, not all problems
# 1
mutate(flights,
       dep_time_mins = (dep_time %/% 100*60 + dep_time%%100) %% 1440,
       sched_dep_time_mins = (sched_dep_time %/% 100*60 + dep_time%%100) %% 1440
       )

# 5
1:3 + 1:10 # returns a sequence equal to adding up each element in the vector

## 5.6.7 ##
# 1
# Arrival delay probably worse, if time is made up in the air off a deperature delay not as big a deal

# 3
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
# If there is NA dep_delay, it follows that there would be NA arr_delay

# 4
cancelled <- flights %>%
  filter(is.na(arr_delay))
cancelled %>%
  group_by(year, month, day) %>%
  dplyr::summarize(count = n())
cancel_delay <- flights %>%
  mutate(cancelled = is.na(arr_delay)) %>%
  group_by (year, month, day) %>%
  dplyr::summarise(
    cancelled_prop = mean(cancelled),
    avg_dep_delay = mean(dep_delay, na.rm=TRUE),
    avg_arr_delay = mean(arr_delay, na.rm=TRUE)
  ) %>% 
  ungroup()
ggplot(cancel_delay) +
  geom_point(aes(x=avg_dep_delay, y=cancelled_prop))

## 5.7.1 ##
# 2
flights %>% 
  filter(!is.na(arr_delay)) %>%
  group_by(tailnum) %>%
  dplyr::summarise(arr_delay = mean(arr_delay), n=n()) %>%
  filter(min_rank(desc(arr_delay))==1)

# 3
flights %>%
  filter(!is.na(arr_delay) & !is.na(dep_delay)) %>%
  mutate(avg_delay = (arr_delay + dep_delay)/2) %>%
  group_by(sched_dep_time) %>%
  dplyr::summarise(avg_delay = mean(avg_delay),n=n()) %>%
  filter(min_rank(avg_delay) == 1)

# 7
flights %>%
  group_by(dest) %>%
  mutate(n_carriers = n_distinct(carrier)) %>%
  filter(n_carriers > 1) %>%
  group_by(carrier) %>%
  dplyr::summarise(n_dest = n_distinct(dest)) %>%
  arrange(desc(n_dest))
