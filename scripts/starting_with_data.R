# What are data frames? 
# De facto data structure for tabular data 
# Columns are vectors that all have the same length. 
# Each column must contain a single type of data (e.g. characters) 

# load SAFI data
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")
library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")

# Install the tidyverse package
install.packages("tidyverse")

interviews

dim(interviews)
nrow(interviews)
ncol(interviews)
head(interviews) # first six rows
tail(interviews) # last six rows
names(interviews) # names of the columns
str(interviews)
summary(interviews)

?read.csv
