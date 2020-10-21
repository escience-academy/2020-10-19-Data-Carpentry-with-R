# Load data
library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na="NULL")

# Select let us select specific columns from the dataframe
select(interviews, village, no_membrs, months_lack_food)

# Select columns village up to respondent_wall_type
select(interviews, village:respondent_wall_type)

# Filter gives us only rows that meet a condition
# Get rows where village equals "God"
filter(interviews, village=="God")

# Get rows where village equals "God" AND no_members is larger than 5
filter(interviews, village == "God", no_membrs>5)

# To combine filter and select, the cumbersome way:
interview_filtered <- filter(interviews, village=="God")
select(interview_filtered, village:respondent_wall_type)

# Can also do it in one command, but becomes difficult to read:
select(filter(interviews, village=="God"),
       village:respondent_wall_type)

# Nicer way: use pipes
# the output of the left-hand side is first argument of function in 
# right-hand side.
interviews %>%
  filter(village == "God") %>%
  select(village:respondent_wall_type)

interviews %>%
  filter(memb_assoc == "yes") %>%
  select(affect_conflicts, liv_count, no_meals)

# Use mutate to add column
# (note that you get new dataframe, does not alter interviews)
interviews %>%
  mutate(people_per_room = no_membrs / rooms)

interviews

# First filter out non-missing values, than add column
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs/rooms)

# exercise
# First add new column, then filter on this column, and select only 2 columns
interviews %>% 
  mutate(total_meals = no_membrs * no_meals) %>%
  filter(total_meals>20) %>%
  select(village, total_meals)

# Split-apply-combine
# We split the dataset into groups per value of village
# Then we summarize statistics for each group and put them in one dataframe

# What is the averge number of meals in each village?
interviews %>%
  group_by(village) %>%
  summarize(mean_no_members = mean(no_membrs))

# What is the average number of meals for each combination of village, 
# and whether or not they were member of an irrigation organization?
interviews %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_members = mean(no_membrs)) %>%
  ungroup()

# Same as above, but only for rows where memb_assoc is not missing
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_members = mean(no_membrs))

# We can summarize with multiple statistics
# For example, mean and minimum
# arrange sorts the rows
interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarize(mean_no_members = mean(no_membrs),
            min_no_members = min(no_membrs)) %>%
  arrange(desc(min_no_members))

# How many observations do we have for each value of village
interviews %>%
  count(village, sort=TRUE)

# Exercise: how many observations do we have for each possible nr of meals
interviews %>%
  count(no_meals)

# Exercise: different statistics per village
# n() gives us the number of observations for this group
interviews %>%
  group_by(village) %>%
  summarize(mean_members = mean(no_membrs),
            min_members = min(no_membrs),
            max_members=max(no_membrs),
            num_observations = n()) %>%
  view()
