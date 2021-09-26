# 2.1.3 - Logical expressions
# Misk Academy Data Science Immersive, 2020

# Logical expressions are how we
# Ask and combine TRUE/FALSE questions

# Asking questions ----
# There a 6 Relational Operators
# Can you list them?
#>, <, >=, <=, ==, !=

# Plus we have a special case in R:
# !x, where x is a logical vector, give the negation of x
!c(TRUE, FALSE, TRUE, TRUE, TRUE)


# Combining questions ----
# There are 2 typical Logical Operators
# Can you name them?
# &, |

# There is one more R-specific logical operator
# %in% WITHIN

## Number one thing to remember:
## You will ALWAYS get a logical vector whenever you see a relational or logical operator

# Examples with foo_df: Logical data ----
# All healthy observations
foo_df %>% 
  filter(healthy)
# Filter requires a logical vector as long as the nrow of the DF
# Returns only the TRUE rows.

# All unhealthy observations
foo_df %>% 
  filter(healthy == FALSE)

foo_df %>% 
  filter(healthy != TRUE)

foo_df %>% 
  filter(!healthy)

# Examples with foo_df: Numeric data
# Below quantity 10
glimpse(foo_df)
foo_df %>% 
  filter(quantity < 10)

# What really happened
# Calculate a logical vector using vector recycling:
foo_df$quantity < 10
# filter() returns rows that are TRUE

# Tails (beyond 10 and 20)
foo_df %>% 
  filter(quantity < 10 | quantity > 20)
# 1- 
foo_df$quantity < 10
# 2-
foo_df$quantity > 20
# 3-
# | Take those positions where we have at least 1 true 


# Impossible
foo_df %>% 
  filter(quantity < 10 | quantity > 20)


# Middle (between 10 and 20)
foo_df %>% 
  filter(quantity >= 10 & quantity <= 20)

# 1- 
foo_df$quantity >= 10
# 2-
foo_df$quantity <= 20
# 3-
# & Take those positions that are ALL TRUE


# Not going to work:
# foo_df %>% 
#   filter(10 <=  quantity <= 20)
# 10 <= foo_df$quantity # is a logical and can't compare to a numerical

# separate many & with a comma:
foo_df %>% 
  filter(quantity >= 10, quantity <= 20)


# Meaningless
foo_df %>% 
  filter(quantity >= 10 | quantity <= 20)



# What really happened
# We asked two questions:
# (see above)

# How is a logical vector really a numeric?
# TRUE == 1, , FALSE == 0
# How many observations have a quantity less than 16?
sum(foo_df$quantity < 16)

foo_df %>% 
  filter(quantity < 16) %>% 
  count()

foo_df %>% 
  filter(quantity < 16) %>% 
  nrow()

# Examples with foo_df: Character data
# NO PATTERN MATCHING so we have to use exact matches
# All heart observations
foo_df %>% 
  filter(tissue == "Heart")

# All heart and liver observations
# Cheap and easy way:
foo_df %>% 
  filter(tissue == "Heart" | tissue == "Liver")


# What if... our query was in a vector?
query <- c("Heart", "Liver")
# How can we combine many == and |
foo_df %>% 
  filter(tissue %in% query)
# %in% the "within" operator 
# 1- 
foo_df$tissue == query[1]
# 2 -
foo_df$tissue == query[2]
# put together with |


# to compare, NEVER DO THIS!!!
# This doesn't work:
foo_df %>% 
  filter(tissue == query)
# But this does: i.e. reverse the query
foo_df %>% 
  filter(tissue == rev(query))
# 1 -
foo_df$tissue
# 2 -
query
# 3 - combine using vector recycling!
foo_df$tissue == query


class(foo1)
foo1 %>% 
  filter(foo1 > 45)

typeof(foo3)
class(foo3)
mean(foo3)
sum(faithful)

# This will "coerce" an R obj to an data.frame (of tibble)
as.data.frame(foo1)
as_tibble(foo1)

# This will create a data.frame
data.frame(score = foo1)
tibble(score = foo1)

# this works, but it's dangerous!
data.frame(score = foo1) %>% 
  filter(foo1 > 45)

# Some examples we discussed in class:
weight <- 1:30

PlantGrowth %>% 
  rename(result = weight) %>% 
  group_by(group) %>%
  filter(weight > 5.5) %>% 
  summarise(obs = n(),
            total = sum(weight))

# attributes(PlantGrowth)
# temp
# attributes(temp)