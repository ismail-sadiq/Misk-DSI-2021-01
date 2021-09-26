# 2.1.2 - Data handling
# Misk Academy Data Science Immersive, 2020

# Part 1: Functions (i.e. "verbs") ----
# Everything that happens, is because of a function

# Arithmetic operators ----
# e.g. type a math equation


# BEDMAS - order of operations
# brackets, expon, div, mult, add, sub
# How are these different?
2 - 3/4
(2 - 3)/4

# Use objects in place of numbers
n <- 34
p <- 6
# so...
n + p

# multiply two objects (single numbers)
# and then add the larger value to this
(n * p) + max(n, p)

# 1 - Generic functions have a form:
# fun_name(fun_arg = ...)

# 2 - Call args by name or position

# i.e. Can you tell the difference in these function calls?
# Which ones work and which one will produce an error?
log(x = 8, base = 2)
log(8, 2)
log(8, base = 10/5)
log2(8)
log10(10000)
log(base = 2, 8)

# 3 - Funs can have 0 to many un-named args
# Can you think of an example?

c()
library(tidyverse)
list.files()
Sys.time()
getwd()


# 4 - Args can be named or un-named

# c() for combine ----
# With numbers:
xx <- c(3, 8, 9, 23)
xx

# With characters:
myNames <- c("healthy","tissue","quantity")
myNames



# As an aside: recall, everything is a function...
# How is + a function?
p + n
# this is actually...
`+`(p, n)

# seq() for a regular sequence of numbers ----
seq(from = 1, to = 100, by = 7)
# Can you write this in a shorter form?
# Assign the output to foo1

foo1 <- seq(1, 100, 7)
# seq(1:100, 7)

# seq(seq(1, 100, 1), 7)

# We can use objects in functions:
foo2 <- seq(1, n, p)

# The colon operator ----
# regular sequence of 1 interval
seq(1, 10, 1)
# Use the colon operator instead:
1:10

# we can rename objects
hello <- foo1
rm(foo1)

# We can change the default number of sig digits displayed in the console
# options(digits = 3)
options(digits = 7)
# pi
# pi - 3.14

# tempnames <- c("hallo", "there", "hier")
# tempvalues <- list(1:30, 4:7, 45:98)
# assign("hi", 3:8)
# walk2(.x = tempnames, .y = tempvalues, assign)

# Applying math functions ----
# Two major types of math functions:
# Aggregation functions
# 1 output value (typically)
# mean, sd, n, var, median, max, min, sum, prod
sum(c(3,7,1))

# Transformation functions
# same number of output as input
# log, [0,1], z-scores, sqrt, exponents
# subtract background
# +, -, /, ...
# 1 input (operator) -> 1 transformed output
34 + 6

# Exercise: Are these transformation or aggregation?
# DON't execute the commands, try to guess what the output will be!
foo2 + 100 # 101 107 113 119 125 131 - Transformation
# 1  7 13 19 25 31 100
# foo2 <- c(foo2, foo2)

foo2 + foo2 # Transformation
# foo2 * 2
sum(foo2) + foo2 # Transformation
# 96 + foo2
# foo2 + 96

1:3 + foo2 # 

# FUNDAMENTAL CONCEPT: VECTOR RECYCLING ----
1:4 + foo2

# Now we're starting to see different kinds of feedback from R
# There are 3 types of messages:
# Information: Neutral
# Warning: Possible problem
# Error: Full stop

# Exercise:
# Calculate y = 1.12x − 0.4 for xx
B0 <- -0.4
B1 <- 1.12

B0 + B1 * xx 

myOLS <- function(x, y_int = -0.4, slope = 1.12) {
  y_hat <- y_int + slope * x
  return(y_hat)
}

myOLS(xx, 10, -10^7)

# Part 2: Objects (nouns) ----
# Anything that exists is an object

# Vectors - 1-dimensional, homogenous ----
# Everything in the values section
foo1
myNames

# "user-defined atomic vector types" ----
# What do you the 4 most common ones are used to represent? 
# Logical - TRUE/FALSE, T/F, 1/0 (Boolean)
# Integer - whole numbers
# Double - real numbers (float)
# Character - All values (string)

# Numeric - Generic class refer to int or dbl

# check
typeof(foo1)
typeof(myNames)

# Let's make some more vectors for later on:
foo3 <- c("Liver", "Brain", "Testes", "Muscle",
          "Intestine", "Heart")
typeof(foo3)

foo4 <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
typeof(foo4)

# Homogeneous types:
test <- c(1:10, "bob")
test
typeof(test)

# We can't do math:
mean(test)

# R has a type hierarchy

# Solution: Coercion to another type
# use an as.*() function
test <- as.numeric(test)
test

# Now we can do math: 
mean(test)
sd(test)
length(test)
# but we need to deal with the NA
mean(test, na.rm = TRUE)

# na.omit()
# NA
# NaN
# log(-54)

# Lists - 1-dimensional, heterogeneous ----
library(tidyverse)
martian_tb <- read_tsv("data/martians.txt")
plant_lm <- lm(weight ~ group, data = PlantGrowth)
plant_anova <- anova(plant_lm)
typeof(plant_lm)

# how many elements:
length(plant_lm)
length(foo1) # also works for vectors
data("PlantGrowth")

# attributes (meta data)
attributes(plant_lm)
# 13 named elements
# attributes(PlantGrowth)

# use common "accessor" functions for attributes
names(plant_lm)
# attributes(plant_lm)$names
str(plant_lm)
plant_lm
length(plant_lm)
# Anything that's named can be called with $
plant_lm$coefficients # a 3-element named dbl (numeric) vector
plant_lm$residuals # a 30-element dbl vector
plant_lm$model # data.frame
plant_lm$qr$qraux

# As an aside: You can even add comments:
comment(plant_lm) <- "I love R!"
attributes(plant_lm)

# Add comment as an actual list item:
plant_lm$myComment <- "But python also :)"
plant_lm$myComment

# What is class?
# An attribute to an object
attributes(plant_lm)
# can also access with "accessor" function:
class(plant_lm)
class(plant_anova)
# class tells R functions what to do with this object
# e.g.
summary(plant_lm) # get t-test and ANOVA summary from an "lm"
plant_anova
# summary(plant_anova) # Works because the object is a data.frame, 
# but this isn't necessary or useful
summary(PlantGrowth) # summarise each column in a "dataframe"

# Dataframes - 2-dimensional, heterogenous ----
class(PlantGrowth)
# A special class of type list...
typeof(PlantGrowth)

# look at a tibble
typeof(martian_tb)
class(martian_tb)
length(martian_tb)
# ...where each element is a vector of the SAME length!
# Rows = observations
# Columns = variables

list("apple" = 1:6,
     "pears" = 9:1)

list(1:6,
     9:1)

data.frame("apple" = 76,
           "pears" = 9:1)

tibble("apple" = 54,
       "pears" = 9:1)

# Make a data frame from scratch using data.frame(), or...
# You can use the modern variant  
# Note, I put _df on the end of the name to remind us that this is a
# data frame (well, a tibble), but it's not necessary.
foo_df <- tibble(foo4, foo3, foo2)
foo_df

# To modify the column names, what you're actually doing is
# Change an attribute (think metadata). The most common attributes
# can be accessed with accessor functions, in this case names()
names(foo_df) <- myNames
foo_df

# How can you call each variable (i.e. column) by name:
# Note it will return a vector
foo_df$healthy
# getthis <- "healthy"
# foo_df[getthis]

# Basic functions:
# Display the structure of foo_df using a base R function:
str(foo_df)
# Now using a tidyverse function:
glimpse(foo_df)

# Can you get a short summary of every variable with one command?
summary(foo_df)
# foo_df %>% 
#   summarise_all(~ typeof(.))
# sapply(foo_df, typeof)

# Can you print out the number of rows & columns?
dim(foo_df)

# How about just the number of rows?
nrow(foo_df)
# NOT:
# length(foo_df)

# How about just the number of columns? 
ncol(foo_df)


library(RColorBrewer)

library("Biobase")


library(datasets)
data(faithful)
faithful_lm <- lm(eruptions ~ waiting, data = faithful)
faithful_lm$coefficients
predict(faithful_lm, data.frame(waiting <- 45))

aa <- as.array(1:4)
class(aa)
typeof(aa)
