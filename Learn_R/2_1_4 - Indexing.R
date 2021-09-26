# 2.1.4 - Indexing
# Misk Academy Data Science Immersive, 2020

# Indexing refers to
# Finding information by position, using []

# Vectors (1-dimensional) ----
# Using this vector:
foo1
# Try to find the following:
# The 6th element
# The pth element
# The 3rd to the pth element
# the pth to the last element

# remove using - (e.g. 11 - 15th element)
foo1[-11:-15]
foo1[-(11:length(foo1))]

# remove using - (e.g. 11 & 15th element)
foo1[c(-11,-15)]
foo1[-c(11,15)]

# The upper 50th percentile (i.e. Q2, median)
foo1[foo1 >= quantile(foo1, 0.9)]
foo1[foo1 >= median(foo1)]
# top values according to a percentile (frac of the total)
# top n number of values, i.e. highest 5 values
# All values above a certain cut-off

# extra on  quantiles:
yy <- floor(rnorm(200, mean = 300, sd = 17))

# Quartiles (4)
quantile(yy, seq(0, 1, length.out = 5))

# Quintiles (5)
quantile(yy, seq(0, 1, length.out = 6))

# Deciles (10)
quantile(yy, seq(0, 1, length.out = 11))

# Percentiles (100)
quantile(yy, seq(0, 1, length.out = 101))

# We can use integers, object and functions that
# equate to integers in any combination!

# BUT!!! The exciting part is... using LOGICAL VECTORS
# I.E. THE RESULT OF LOGICAL EXPRESSIONS! (see above)

foo1[foo1 < 45] # All values less than 45

# So what happened here:
foo1 < 45 # produces a logical vector, 
# Remember, this will ALWAYS be the case when you see a 
# relational or logical operator
# Then we use that logical vector to select only the TRUE positions:
foo1[foo1 < 45] 

# Lists (1-dimensional, hetero)
# Use [] or [[]]for each element 
# Each of the 13 elements has a name, 
names(plant_lm)
str(plant_lm)

# Get the coefficients
plant_lm$coefficients # by name using $

plant_lm["coefficients"] # by name using [] maintaining structure (i.e. list)
plant_lm[["coefficients"]] # by name using [[]] extracted from the structure (i.e. whatever was inside)

plant_lm[1] # by position using []
plant_lm[[1]] # by position using [[]]

# How to get the groups defined in the xlevels element of plant_lm
# These are the same:
plant_lm$xlevels$group
plant_lm[["xlevels"]][[1]]


# Data frames (2-dimensional) ----
# so use [ <rows> , <cols> ] 
# Using this data frame:
foo_df
class(foo_df)
# Can you find the following 
# The 3rd row, all columns
foo_df[3, 1:ncol(foo_df)]
foo_df[3, ] # as a data.frame (i.e. tibble) 


# The 3rd column, all rows
foo_df[,3] # as data.frame (i.e. tibble)
foo_df[3] # as a data.frame (i.e. tibble)
foo_df[[3]] # as a vector (see [[]] above)

# Can you identify the data structure of the output?
# What if foo_df wasn't tibble, but actually a true plain old data frame?

# What happens if we have a tibble?
foo_df <- as.data.frame(foo_df)
class(foo_df)
foo_df
# repeat the solutions from above:

#===========================================

# Can you find the following 
# The 3rd row, all columns
foo_df[3, ] # as a data.frame


# The 3rd column, all rows
foo_df[,3] # as a vector ******
foo_df[3] # as a data.frame
foo_df[[3]] # as a vector (see [[]] above)
#===========================================

# ok, but let's go back to a tibble
foo_df <- as_tibble(foo_df)

# We can also use names:
foo_df[,"healthy"]

# But don't forget logical vectors:
# e.g. which tissues have low quantity (below 10)?
foo_df[foo_df$quantity < 10, "tissue"]
# foo_df[foo_df$quantity < 10,][,"tissue"]

# This also works, as a vector:
foo_df$tissue[foo_df$quantity < 10]

# here is the reverse question:
foo_df$quantity[foo_df$tissue == "Heart"]

# How can we do this using the tidyverse way?
foo_df %>% 
  filter(quantity < 10) %>% 
  select(tissue)

# Using integer vectors instead of logical vectors
foo_df[1:3, "tissue"]
foo_df %>% 
  slice(1:3) %>% 
  select(tissue)

# What else can we use with select:
# Character (i.e. name of the column), see previous example
# Integer = YES!
foo_df[1:3, 3]
foo_df %>% 
  slice(1:3) %>% 
  select(3)

# Logical expression?
# i.e.
names(foo_df) == "tissue" # is a logical vector
foo_df[1:3, names(foo_df) == "tissue"]
# NO! but there are some great helper functions
# i.e. starts_with()
foo_df %>% 
  slice(1:3) %>% 
  select(starts_with("t"))

