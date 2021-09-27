# Exercises for Logical Expressions and Indexing

library(tidyverse)
# From ggplot2
data(diamonds)

# summary(diamonds)
# str(diamonds)
glimpse(diamonds)

# Exercise 9.2 (Counting individual groups)
# - How many diamonds with a clarity of category “IF” are present in the data-set?
diamonds %>% 
  filter(clarity == "IF") %>% 
  nrow()

# nrow doesn't recognize the "grouped_df" attribute added by group_by()
diamonds %>% 
  group_by(clarity) %>% 
  nrow()
# but summarize() and n() do
diamonds %>% 
  group_by(clarity) %>% 
  summarise(n = n())
  


sum(diamonds$clarity == "IF")

# Exercise 9.3 (Measuring proportions)
# - What fraction of the total do they represent?
sum(diamonds$clarity == "IF")/nrow(diamonds)

# table of obs counts
table(diamonds$clarity) # A named vector couting the number of obs in each group

# 2-variable "contigency table"
clarity_color <- table(diamonds$clarity, diamonds$color)
typeof(clarity_color)
class(clarity_color)
attributes(clarity_color) # basically a 2-dimensional int vector

# can we do three groups? n-D (3-dimensional) array
clarity_color_cut <- table(diamonds$clarity, diamonds$color, diamonds$cut)
attributes(clarity_color_cut)
clarity_color_cut[8, , ]
clarity_color_cut[4:8, , ]
clarity_color_cut[, ,5]

# Exercise 9.4 (Summarizing proportions)
# - What proportion of the whole is made up of each category of clarity?
diamonds %>% 
  group_by(clarity) %>% 
  summarise(proportion_clarity = n()/nrow(diamonds))

# Be cautious with this approach:
# b <- nrow(diamonds)
# ##  some work that changes the number of rows in diamonds
# diamonds %>%
#   group_by(clarity) %>%
#   summarise((n()/b)*100)

# Exercise 9.5 (Finding prices I)
# - What is the cheapest diamond price overall?
min(diamonds$price)


# Exercise 9.6 (Finding prices II)
# - What is the range of diamond prices?
diff(range(diamonds$price))

# Exercise 9.7 (Finding prices III)
# - What is the average diamond price in each category of cut and color?
diamonds %>%
  group_by(cut, color) %>%
  summarize(avg = mean(price))

# Exercise 9.8 (Only tall martians)
# - Use the entire dataset for this exercise, i.e. Site I and Site II.
# Let the median divide the height variable into lower and upper halfs. 
# Calculate the proportion of blue and red-nosed Martians in each half. 
# Do you think there is a real difference in the proportion of nose colors between the lower and upper 50% of the sample?
# lower_med <- martians[which(martian_tb$Height < median(martian_tb$Height)),]
lower_med <- martian_tb[martian_tb$Height < median(martian_tb$Height), ]
upper_med <- martian_tb[martian_tb$Height >= median(martian_tb$Height), ]

lower_med %>%
  group_by(Nose) %>%
  summarise(counts = n() / nrow(.)) -> lower_half

upper_med %>%
  group_by(Nose) %>%
  summarise(counts = n() / nrow(.)) -> upper_half

# Alternatively:
martian_tb %>%
  filter(Height > median(Height))  %>%
  group_by(Nose) %>%
  summarise(propN= length(Nose)/(nrow(martian_tb)/2))

# Can I do it all in one long command?
martian_tb %>% 
  group_by(Height > median(Height), Nose) %>% 
  summarise(prop = n()/(nrow(martian_tb)/2))

# A bit more explicit
# use mutate function to add a transformation variable
martian_tb %>% 
  mutate(UpperHalf = Height > median(Height)) %>%
  group_by(UpperHalf, Nose) %>% 
  summarise(prop = n()/(nrow(martian_tb)/2))

# Exercise 9.9 (Difference in means)
# - Calculate the mean and standard deviation of the eye-sight scores (Eye) for 
# each age group in AgeIndex.
martian_tb %>% 
  group_by(AgeIndex) %>% 
  summarise(average = mean(Eye),
            sd = sd(Eye))


# Exercise 9.10 (Measuring proportions)
# - Create a new data frame that only contains the values for the martians at site one. Use this dataset for the next exercise.
Site_I <- martian_tb %>% 
  filter(Site == "Site I")

# Base R equivalent... out of fashion
# subset(martian_tb, martian_tb$Site == "Site I", select = "Height")
# The equivalent in tidyverese is:
martian_tb %>% 
  filter(Site == "Site I") %>% 
  select(Height)

# Exercise 9.11 (Transformations and tests)
# - In the Statistical Literacy reference material, we described a scenarion where each Martians fastest time to ran 100 meters was measured, first on Mars and then on Earth. Thus, the data is paired, the same individual was measured before and after a treatment was given (here, changing planets).
# Calculate a paired two-sample t-test when using speed described by weight.
# Calculate the difference in running time between the two locations for each Martian
# Use this variable to perform a 1-sample t-test using t.test()

