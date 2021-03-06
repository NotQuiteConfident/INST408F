# INST408F Final Project Code
# Amina Lampkin

# Set the working directory
setwd('/Users/aminasymone/Documents/INST408F/Final Project')

# Load the necessary libraries
library(foreign)
library(dplyr)
library(ggplot2)

# Open the .xpt file with the 2018 BRFSS data
setwd("C:/Users/hayde/Documents/GitHub/INST408F")
brfss <- read.xport("Final_Project_SLR/BRFSS18.xpt")

# Variables go as follows
# X_RACE
# _EDUCAG
# MENTHLTH
# CNCRAGE

## Data Cleaning and Preparation

# Filter the dataset into White, non-Hispanic Black, and Hispanic since those are our races of interest
# Values marked "Don't know/Not sure/Refused" in the race variable are excluded by nature of the subsetting done
brfss <- filter(brfss, X_RACE == 1 | X_RACE == 2 | X_RACE == 8)
# Turn X_RACE into a factor
brfss$X_RACE <- factor(brfss$X_RACE, levels = c(1,2,8),
                       labels = c("White",
                                  "non-Hispanic Black",
                                  "Hispanic"))

# Clean the Education variable
str(brfss$X_EDUCAG)

# Turn X_EDUCAG into a factor
# Responses with a value of 9 are also now NA
brfss$X_EDUCAG <- factor(brfss$X_EDUCAG, levels = c(1, 2, 3, 4, 9),
                         labels = c("Did not graduate high school",
                                    "Graduated high school",
                                    "Attended college/technical school",
                                    "Graduated from college/technical school",
                                    NA))

# Clean the MENTHLTH variable
str(brfss$MENTHLTH)

# Responses with a value of "None" (88) will be recoded to 0
brfss$MENTHLTH <- replace(brfss$MENTHLTH, brfss$MENTHLTH == 88, 0)
# Responses with a value of "Don't know/Not sure" (77) and "Refused" (99) will be recoded to NA
brfss$MENTHLTH <- replace(brfss$MENTHLTH, brfss$MENTHLTH == 77, NA)
brfss$MENTHLTH<- replace(brfss$MENTHLTH, brfss$MENTHLTH == 99, NA)

# Clean the CNCRAGE variable
# Filter the dataset into those respondents who were diagnosed with cancer and answered the age of diagnosis question
brfss <- filter(brfss, CNCRAGE >= 1 & CNCRAGE <=97)

## Data Visualization
# Race
ggplot(data=brfss) +
  geom_boxplot(mapping = aes(x=X_RACE, y=CNCRAGE, fill = X_RACE)) +
  labs(title = "Age of Cancer Diagnosis by Race", x = "Race", y= "Age of Diagnosis (Years)")

# Educational Attainment 
ggplot(data=brfss) +
  geom_boxplot(mapping = aes(x=X_EDUCAG, y=CNCRAGE, fill=X_EDUCAG)) +
  labs(title = "Age of Cancer Diagnosis by Educational Attainment", x = "Educational Attainment", y = "Age of Diagnosis (Years)")

# Number of Days Mental Health was Poor
ggplot(data=brfss) +
  geom_point(mapping = aes(x=MENTHLTH, y=CNCRAGE)) +
  labs(title = "Age of Cancer Diagnosis by Poor Mental Health Days", x="Poor Mental Health (Days)", y = "Age of Diagnosis (Years)")

## Multiple Linear Regression
mlr <- lm(CNCRAGE~X_RACE + X_EDUCAG + MENTHLTH, data =brfss)
summary(mlr)
