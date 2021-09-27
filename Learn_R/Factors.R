# Note of factors

# e.g. group is <fct>
glimpse(PlantGrowth)

# e.g. cut, color, clarity are <ord>
glimpse(diamonds)

# They are all type integer
typeof(PlantGrowth$group)
typeof(diamonds$cut)

# Confusing:
PlantGrowth %>% 
  filter(group == "ctrl")

# The class!
class(PlantGrowth$group) # factor = Nominal variable
class(diamonds$cut)      # factor, ordered = Ordinal variable

# fct and ord are classes of type integer

# It's not entirely necessary:
foo_df$tissue

# The "groups" in a categorical, discrete, qualitative variable are 
# The "levels" in a factor variable
levels(PlantGrowth$group) # alphabetical
attributes(PlantGrowth$group)
# levels are defined by a character vector as an attribute
# integers in data match to each level
as.integer(PlantGrowth$group)

levels(diamonds$cut) # ordered by design
diamonds$cut

# see package forcats:

# e.g.
PlantGrowth %>% 
  mutate(group = fct_recode(group,
                            "Low Carbon Dioxide" = "trt1",
                            "High Carbon Dioxide" = "trt2",
                            "Athmospheric" = "ctrl"))

# or...
levels(PlantGrowth$group) <- c("Atm CO2", "Low CO2", "High CO2")
PlantGrowth
