# Hayden Smedley
# 3/22/20
# INST 408F
# Module 7 ICE

library(car)

# Read file
brfss <- read.csv("Module 7 ICE/BRFSS.csv")

# Recode Data
brfss$WEIGHT2[brfss$WEIGHT2 >= 7000] <- NA
brfss$DOCTDIAB[brfss$DOCTDIAB == 88] <- 0
brfss$DOCTDIAB[brfss$DOCTDIAB > 88] <- NA

# Graphs
plot(brfss$WEIGHT2, brfss$DOCTDIAB, main = "Weight in lbs versus number of viditd to a Health Professional for diabetes in the last year")
abline(lm(brfss$DOCTDIAB ~ brfss$WEIGHT2))
