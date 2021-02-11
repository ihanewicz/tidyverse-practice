# data_viz.R
# Notes, practice from Ch. 3 of R for Data Science
# Isabel Hanewicz
# 09-Feb-2021

# Load packages
library(tidyverse)

###### Exercises #####
## 3.2.4 ##
# 1
ggplot(data=mpg) # blank screen

# 2
mpg # 234 rows, 11 columns

# 3
?mpg # DRV = type of drive terrain

# 4
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl))

# 5
ggplot(data = mpg) + 
  geom_point(map=aes(x=class, y=drv))
# No clear divisions of class/drive

## 3.3.1 ##
# 1
# The color is in the aes(), not outside

# 2
# Categorical: manufacturer, model, trans, drv, fl, class
# Continuous: displ, year, cty, hwy, cyl

# 3
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl, color=hwy)) # Continuous = gradient
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl, size=hwy)) 
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl, shape=hwy)) # Continous cannot be mapped for shape

# 4 
# Same variable, multiple aesthetics
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl, color=fl, shape=fl)) # Diff color for each shape

# 5 
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl, stroke=cty, shape=fl))
# Stroke - modifies width of border of shapes

# 6
ggplot(data = mpg) + 
  geom_point(map=aes(x=hwy, y=cyl, colour = displ < 5))
# Binary colored - if statement is T/F

## 3.5.1 ##
# 1
# Facet on continous - many plots
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ hwy, nrow = 2)

# 2
# Empty cells - there are no data points with that drv/cyl combo
# Just like we see only certain drv/cyl combos in this plot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

# 3
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
# Scatter plot of display v. hwy, faceted in rows by drive
# the . means we do not want to facet in a column  direction 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)
# Scatter plot of display v. hwy, faceted in cols by cyl
# the . means we do not want to facet in a row direction

# 4
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)
# Faceting adv = spaces out clearly as opposed to color
# Can easily see trend for each class
# Disadv - not as tight, harder to see overall trend in data

# 5
# nrow = defines # of rows
# ncol = defines # of cols
# scales = allows scales to vary across panels
# facet_grid doesn't have nrow/ncol because # of rows/cols is defined by the x and y variables

# 6
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(rows=vars(drv), cols=vars(cyl))
# More unique variable in columns - makes it eaiser to see what each unique point is

## 3.6.1 ##
# 1
# Line chart - geom_line()
# Boxplot - geom_boxplot()
# Histogram - geom_histogram()
# Area chart - geom_area()

# 2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# 3
# show.legend = FALSE -> hides legend
# Remove it - legend appears
# Hid it for comparison purposes

# 4
# SE - whether or not to display CI around 

# 5
# No, they won't - the first graph 
# is just a more concise way of writing the code

# 6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(color = "black") + 
  geom_smooth(se = FALSE, color = "blue")

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(color = "black") + 
  geom_smooth(se = FALSE, mapping = aes(group=drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE, mapping = aes(group=drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping=aes(color=drv)) +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping=aes(color=drv)) +
  geom_smooth(se = FALSE, mapping=aes(linetype=drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(size=4, color="white") +
  geom_point(mapping=aes(color=drv)) 

## 3.7.1. ##
# 1
# Default - geom point range
ggplot(data=diamonds) +
  geom_pointrange(
    mapping = aes(x=cut, y=depth),
    stat = "summary",
    fun.min = min,
    fun.max = max,
    fun = median
  )

# 2
# geom_col default stat is identity (using provided y value)
# geom_bar default stat is stat_count, so you only use the x value from data

# 3
# Find geom/stat at: https://ggplot2.tidyverse.org/reference/#section-geoms

# 4
# stat smooth = smoothed conditional means
# method, formula, se, na.rm, method.arg

# 5 
# w/o prop = 1, all the bars have the same height b/c the proportion is 
# proportion with in a single group (always 100%)

## 3.8.1 ##
# 1 
# Multiple observations for each unique cty/hwy combo
# use jitter to show better

# 2
# geom_jitter: width (hz displacement) + height (vert displacement)

# 3
# geom_jitter adds random variation to points (changes obvs. slightly)
# geom_count gives each point a size relative to its prominence in data set

# 4
# default is dodge2 - placing different vars side-by-side, not stacking
ggplot(data=mpg, aes(x=drv, y=hwy, colour=class)) +
  geom_boxplot()
# different classes side-by-side for each drv

## 3.9.1 ##
# 1
ggplot(mpg, aes(x=factor(1), fill=drv)) +
  geom_bar() + 
  coord_polar(theta="y")

# 2
# labs() = set labels for your plot, like title or subtitle
# can also use xlab, ylab

# 3
# coord_map() uses a slower but slightly more accurate projection onto Earth

# 4
# Positive relationship btwn cty and hwy
# coord_fixed = makes geom_abline() @ 45 degree angle
# geom_ab line = creates the line on the graph 

# END