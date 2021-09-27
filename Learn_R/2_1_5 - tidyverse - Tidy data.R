# 2.1.5 tidyverse - Tidy data
# Misk Academy Data Science Immersive, 2020

# The rules of "tidy data"
# 1. 1 observation per row
# 2. 1 variable per column
# 3. 1 Observational unit per data.frame

library(tidyverse)

PG_wide <- PlantGrowth %>% 
  mutate(id = rep(1:10,3)) %>% 
  pivot_wider(names_from = group, values_from = weight) %>% 
  select(-id)

glimpse(PG_wide)


# Get a play data set:
PlayData <- read_tsv("Learn_R/data/PlayData.txt")

# difficult to do:
# Tell me the difference from time 1 - 2 for 
# each measured trait (height, width) in each type (A/B)

# solution
# A, height is 10
# B, height is 10
# A, width is 10
# B, width is 10
# this works but it's too much work
PlayData %>% 
  group_by(type) %>% 
  summarise(W_delta = width[time == 2] - width[time == 1],
            H_delta = height[time == 2] - height[time == 1])

# For each time, give me the ratio A/B for each measure (height & width)
PlayData %>% 
  group_by(time) %>% 
  summarise(W_ratio = width[type == "A"] - width[type == "B"],
            H_ratio = height[type == "A"] - height[type == "B"])


# Easy:
# Some transformation function of height and with
# for each time and type
PlayData$height/PlayData$width




# Let's see the scenarios we discussed in class:
# Scenario 1: Transformation across height & width
PlayData$height/PlayData$width


# For the other scenarios, tidy data would be a 
# better starting point: 
# Specify the ID variables (i.e. Exclude them)
# ID variables = Categorical before and after pivoting - specify with -
PlayData %>% 
  pivot_longer(-c(type, time), names_to = "key", values_to = "value") -> PlayData_t



# Now try the same thing but specify the MEASURE variables (i.e. Include them)
# MEASURE variables = Continuous before but actually levels in a factor variable
PlayData %>% 
  pivot_longer(c(height, width), names_to = "key", values_to = "value")

# Repeat above examples:
# For each time, give me the ratio A/B for each measure (height & width)
PlayData_t %>% 
  group_by(time, key) %>% 
  summarise(diff = diff(value))

# Scenario 2: Transformation across time 1 & 2 (group by type & key)
# Difference from time 1 to time 2 for each type and key (time2 - time1)
# we only want one value as output
PlayData_t %>% 
  group_by(type, key) %>% 
  summarise(diff = value[time == 2] - value[time == 1])


# As another example: standardize to time 1 i.e time2/time1
# i.e.
# A height - 2x increase 20/10
# A width - 1.2x increase 60/50
# B height - 1.33x increase 
# B width - 1.14x increase 80/70

PlayData_t %>% 
  group_by(type, key) %>% 
  summarise(diff = value[time == 2] / value[time == 1])

PlayData_t %>% 
  group_by(type, key) %>% 
  mutate(diff = value / value[time == 1])

# Keep all values

# Scenario 3: Transformation across type A & B
# Ratio of A/B for each time and key

