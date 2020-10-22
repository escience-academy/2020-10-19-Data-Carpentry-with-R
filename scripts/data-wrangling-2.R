library(tidyverse)

# Read data
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")
####################
# Recap of yesterday:
####################
# We made pipelines to operate on our data

# Select only 3 columns
interviews %>% 
  select(village, rooms, no_meals)

# Filter rows on two conditions
interviews %>%
  filter(rooms > 1, village == "Chirodzo")

# combine select and filter
interviews %>%
  filter(rooms > 1, village == "Chirodzo") %>%
  select(village, rooms, no_meals)

# Add a derived column
interviews %>%
  mutate(total_meals = no_meals * no_membrs)

# Split - apply - combine
# Make group per value of village, calculate mean nr of members
interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs))

# We can caclulate multiple statistics over our group
interviews %>%
  group_by(village) %>%
  summarize(mean_no_membrs = mean(no_membrs),
            mean_no_meals = mean(no_meals),
            no_observations = n())

###########
# Pivoting
###########
# How many observations do we have in each village, for each wall type?
# Grouping gives a table in long format:
interviews %>%
  group_by(village, respondent_wall_type) %>%
  summarize(no_housholds = n())

# We pivot to get a 'wide' format,
# where we have a column for each possible wall type
interviews %>%
  group_by(village, respondent_wall_type) %>%
  summarize(no_housholds = n()) %>%
  pivot_wider(names_from = respondent_wall_type,
              values_from = no_housholds,
              values_fill = 0)

# Exercise: create dataframe with column for interview_date, column for each village
# Values are nr of interviews conducted that day in that village
nr_interviews_wide <- interviews %>%
  group_by(village, interview_date) %>%
  summarize(no_interviews = n()) %>%
  pivot_wider(names_from = village,
              values_from = no_interviews,
              values_fill = list(no_interviews=0))
nr_interviews_wide
# Note that we used a list for values_fill, 
# there we can sepcify the columns to fill 
# (because you could specify multiple colums in values_from)

# We can also go back from the wide format to the long format
nr_interviews_wide %>%
  pivot_longer(cols = Chirodzo:Ruaca, 
               names_to="village",
               values_to = "no_interviews")

# Now we will use it to create columns for different wall types
# We create a helper column 'wall_type_logical' that is always true
# This way, we get 'TRUE' in our wide columns if the walltype was present
# in the original data. If not we want it to be FALSE so use values_fill
interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  pivot_wider(names_from =respondent_wall_type,
              values_from = wall_type_logical,
              values_fill = FALSE) %>%
  view()

# Now we use it to clean our data
# Pull apart the list of items_owned and make separate  columns
interviews %>%
  # Select only a few columns to make it more readable
  select(instanceID, village, items_owned) %>%
  # separate rows makes a long format for a new row for each item
  separate_rows(items_owned, sep=";") %>%
  # Sometimes there are no items, but we still want a column for that value
  # So we replace the na values
  replace_na(list(items_owned="no_items")) %>%
  # Add again a helping column which is always TRUE
  mutate(items_owned_logical = TRUE) %>%
  # Now go to long format
  pivot_wider(names_from = items_owned,
              values_from = items_owned_logical,
              values_fill = list(items_owned_logical=FALSE))

# Note that this code adds a column that is always TRUE:
interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  view()

##########################
# Clean data for plotting
#  You need to run this code for the next part (plotting)
#  Note it does similar things as we did above, 
#  but combined in one pipeline
#########################
interviews_plotting <- interviews %>%
  ## pivot wider by items_owned
  separate_rows(items_owned, sep = ";") %>%
  ## if there were no items listed, changing NA to no_listed_items
  replace_na(list(items_owned = "no_listed_items")) %>%
  mutate(items_owned_logical = TRUE) %>%
  pivot_wider(names_from = items_owned, 
              values_from = items_owned_logical, 
              values_fill = list(items_owned_logical = FALSE)) %>%
  ## pivot wider by months_lack_food
  separate_rows(months_lack_food, sep = ";") %>%
  mutate(months_lack_food_logical = TRUE) %>%
  pivot_wider(names_from = months_lack_food, 
              values_from = months_lack_food_logical, 
              values_fill = list(months_lack_food_logical = FALSE)) %>%
  ## add some summary columns
  mutate(number_months_lack_food = rowSums(select(., Jan:May))) %>%
  mutate(number_items = rowSums(select(., bicycle:car)))

write_csv(interviews_plotting, 
          path = "data_output/interviews_plotting.csv")
