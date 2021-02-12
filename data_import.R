# data_import.R
# Practice problems, Ch. 11 of R for Data Science
# Isabel Hanewicz
# 12 Feb 2021

# Libraries
library(tidyverse)

## 11.2.2 ##
# 1
# read_delim(filepath, delim="|")

# 3
# file, col_positions

# 4
# use the "quote" argument in read_delim

## 11.3.5 ##
# 2
parse_number("123.456.789", locale = locale(grouping_mark = ".", decimal_mark="."))
# throws an error - must be different

# 5
# read_csv2 uses ; for field separator and , for decimal point (European style)

# 7
d1 <- "January 1, 2010"
parse_date(d1, "%B %d, %Y")
