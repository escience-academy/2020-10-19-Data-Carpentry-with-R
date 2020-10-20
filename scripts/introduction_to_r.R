# Hello this is a comment
12 / 7

area_hectares <- 1.0
area_hectares

# Object names cannot start with a number
2area <- 1.0

# Cannot be fundamentel objects of R
if <- 2.0

2.47 * area_hectares
# change value
area_hectares <- 2.5

area_acres <- 2.47 * area_hectares
area_acres

area_hectares <- 50
# You could use =
area_hectares = 50
area_hectares

# What do you think is the value of area_acres?
area_acres
area_acres <- 2.47 * area_hectares
area_acres

a_length <- 50
a_width <- 20
area <- a_length * a_width
area
a_length <- 10
area

#########################################
# Functions and their arguments
#########################################
a <- 9
b <- sqrt(a)
b

# sqrt without argument
sqrt()

round(3.14159)

# Use ? to call for help
?round

# Use a different number of digits
round(3.14159, digits = 2) # best practice

# if arguments are in order we do not needt to name
round(3.14459, 2)

# if we name them they can be in any order
round(digits = 2, x = 3.1459)


##############################
# Vectors and data types
###############################
# Represents the number people in a household
hh_members <- c(3, 7, 10, 6)
hh_members

respondant_wall_types <- c("muddabu",
                           "burntbricks",
                           "sunbricks")
respondant_wall_types

# How many households are there?
?length
length(hh_members)

?class
class(hh_members)
class(respondant_wall_types)

str(hh_members)
str(respondant_wall_types)

posessions <- c("bicycle", "radio", "television")
posessions
# Add a value to the end of a vector
posessions <- c(posessions, "mobile_phone")

# Add a value to the beginning of a vector
posessions <- c("car", posessions)
posessions

# An atomic vector is a linear vector of a
# single type
#"logical" for TRUE and FALSE (the boolean data type)
#"integer" for integer numbers (e.g., 2L, the L indicates to R that it’s an integer) 
# "complex" to represent complex numbers with real and imaginary parts (e.g., 1 + 4i) and that’s all we’re going to say about them 
# "raw" for bitstreams that we won’t discuss further

# Excersise 1
# Coercion (chaning of data type)

num_char <- c(1, 2, 3, "a")
num_char
class(num_char)
num_logical <- c(1,2, 3, FALSE)
num_logical
class(num_logical)
char_logical <- c("a" ,"b", "c", TRUE)
char_logical
class(char_logical)
tricky <- c(1,2,3, "4")
tricky
class(tricky)
chars <- c(a, b, d)
a
b
d
chars <- c("a", "b")

# Exercise 3
num_logical <- c(1,2,3,TRUE)
char_logical <- c("a","b","c", TRUE)
combined_logical <- c(num_logical, char_logical)

combined_logical
num_logical
class(num_logical)

# hierarchy of data types
#character > numeric > boolean

########################
# Subsetting vectors
#########################
respondant_wall_types <- c("muddaub", "burntbricks", "sunbricks")
respondant_wall_types[2]

respondant_wall_types[c(3, 2)]

more_respondant_wall_type <- respondant_wall_types[c(1, 2, 3, 2, 1, 3)]
more_respondant_wall_type
length(more_respondant_wall_type)

muddaub_removed <- respondant_wall_types[c(2, 3)]
muddaub_removed

########################
# Conditional subsetting
########################
hh_members <- c(3, 7, 10, 6)
hh_members[c(TRUE, FALSE, TRUE, TRUE)]

hh_members > 5
hh_members[hh_members > 5]

# combine multiple logical statements
hh_members[hh_members < 4 | hh_members > 7]

# Use AND
hh_members[hh_members >= 7 & hh_members == 3]

posessions <- c("car", "bicycle", "radio", "television", "mobile_phone")
posessions
posessions[posessions == "car" | posessions == "bicycle"]

posessions %in% c("car", "bicycle")

posessions %in% c("car", "bicycle", "motorcycle", "truck", "boat", "bus")

posessions[posessions %in% c("car", "bicycle")]

#####################################
#Missing data
###################################
rooms <- c(2, 1, 1, NA, 4)
mean(rooms)
?mean
max(rooms)

mean(rooms, na.rm = TRUE)
max(rooms, na.rm = TRUE)

is.na(rooms)
!is.na(rooms)
rooms[!is.na(rooms)]  # Get all values of rooms that are not NA

# Count the number of missing values.
sum(is.na(rooms))

rooms[complete.cases(rooms)]

rooms <- c(1, 2, 1, 1, NA, 3, 1, 3, 2, 1, 1, 8, 3, 1, NA, 1)
rooms_no_na <- rooms[!is.na(rooms)]
rooms_no_na <- na.omit(rooms)
rooms_no_na <- rooms[complete.cases(rooms)]
rooms_no_na

median(rooms, na.rm=TRUE)
median(rooms_no_na)

rooms_above_2 <- rooms_no_na[rooms_no_na > 2]
rooms_above_2
length(rooms_above_2)
