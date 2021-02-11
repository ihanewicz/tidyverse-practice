# workflow.R
# Practice problems, Ch. 4 of R for Data Science
# Isabel Hanewicz
# 11 Feb 2021

# Libraries
library(tidyverse)

# 4.4

# 1
# This code doesn't work because you didn't use an "i" in variable, it's a 1 or an l

# 2
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) # Command 1

filter(mpg, cyl==8) # Command 2

filter(diamonds, carat>3) # Command 3

# 3
# I don't have an alt key on Mac, I use option+shit+k
# Gives a keyboard shortcut menu
# Also tools-> keyboard shortcuts

# END

