library(tidyverse)

# Load data
interviews <- read_csv("data/SAFI_clean.csv", na="NULL")
view(interviews)

########################
# Indexing
########################

# Take first row, second column
interviews[1,2]

# Get all rows, second column
interviews[2]

# Get first three rows, second column
interviews[1:3,2]

# Get all rows, second column
interviews[,2]

# the first 100 rows
interviews[1:100,]

# Small exercise: pull out the 100th row of our dataframe
interviews[100,]

# Use the column name
interviews["village"]
interviews[,"village"]

# These two commands will give a vector (instead of tibble)
interviews$village
interviews[["village"]]

# remember we can find the number of rows with:
nrow(interviews)

# Exercise: reproduce results of tail using nrow
number_of_rows <- nrow(interviews)
interviews[number_of_rows,]
# This gives same output:
tail(interviews, 1)

# Or in one command:
interviews_last <- interviews[nrow(interviews),]
interviews_last

# Exercise: pull out the middle row
help(median)
middle_index <- median(c(1:number_of_rows))
interviews_middle <- interviews[middle_index,]
interviews_middle

# We can use negative indices to exclude certain rows or columns
# Everything except first column
interviews[,-1]

#Everything except first three columns 
interviews[,-c(1:3)]

# Everything except first row
interviews[-1,]

# Exercise: Get first 6 rows uses negative index
head(interviews, 6)
interviews[1:6,]
interviews[-c(7:nrow(interviews)),]

########################
# Factors
########################
# We make a character vector
floor_type_char <- c("earth", "cement", "earth", "earth")
# And convert it to a factor
floor_type_factor <- factor(floor_type_char)
floor_type_factor

# It extracted 2 levels
levels(floor_type_factor)
nlevels(floor_type_factor)

# We can also specify the order of the levels, and whether it is ordered
floor_type_factor <- factor(floor_type_char, 
                            levels=c("earth", "cement"),
                            ordered=TRUE)
levels(floor_type_factor)
floor_type_factor

# we can rename levels
levels(floor_type_factor)[2] <- "bricks"
levels(floor_type_factor)
floor_type_factor

# We can convert back to character
as.character(floor_type_factor)

# However, if our factor has numeric values, we can not simply convert to numbers
year_fct <- factor(c(1990, 1997, 1990, 2007))
levels(year_fct)
as.numeric(year_fct)
# This gives us the indices of the levels!!!

# How do we get back our years as numbers?
years_char <- as.character(year_fct)
years_num <- as.numeric(years_char)
# Or in one line
as.numeric(as.character(year_fct))

# We can also do it by indexing the level names with the indices of our values
as.numeric(levels(year_fct)[as.numeric(year_fct)])

# Note that we can also convert our floor_type factor to numbers,
# it also gives the level indices.
as.numeric(floor_type_factor)
levels(floor_type_factor)

# Let's use it to apply to a vector from our dataset
memb_assoc <- interviews$memb_assoc
memb_assoc

# Convert to factor
memb_assoc_factor <- factor(memb_assoc)
memb_assoc_factor

# Now it automatically plots as barplot
plot(memb_assoc_factor)
# If we don't convert to factor, it doesn't work:
plot(memb_assoc)

# There is no level for the missing values, 
# so we first replace them with "undetermined"
memb_assoc <- interviews$memb_assoc
# This gives a boolean vector:
is.na(memb_assoc)
# Which we can use to replace the missing values
memb_assoc[is.na(memb_assoc)] <- "undetermined"
memb_assoc

# now convert to factor
memb_assoc_factor <- factor(memb_assoc)
memb_assoc_factor
plot(memb_assoc_factor)

# Exercise: rename the levels to upercase
levels(memb_assoc_factor)
levels(memb_assoc_factor) <- c("No", "Undetermined", "Yes")
levels(memb_assoc_factor)
plot(memb_assoc_factor)

# Exercise: reorder the levels
memb_assoc_factor <- factor(memb_assoc_factor, 
                            levels=c("No", "Yes", "Undetermined"))
plot(memb_assoc_factor)

#############
# Dates in R
#############
str(interviews)
library(lubridate)

# The date column is already interpreted as date
dates <- interviews$interview_date
str(dates)

# We can use the year, month, day functions from lubridate 
# and add columns to our dataframe
year(dates)
interviews$year <- year(dates)
interviews$month <- month(dates)
interviews$day <- day(dates)
view(interviews)

# Convert character vectors to dates:
char_dates <- c("10/21/2020", "10/22/2020")
char_dates
str(char_dates)
date_dates <- as_date(char_dates, format="%m/%d/%y")
str(date_dates)
date_dates
# alternatively with myd function:
mdy(char_dates)

# To convert back to custom format characters:
format(date_dates, format="%d-%m-%Y")
