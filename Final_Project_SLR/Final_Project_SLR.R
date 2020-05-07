# Hayden Smedley
# Final Project
# Simple Linear Regression

library(Hmisc)

setwd("C:/Users/hayde/Documents/GitHub/INST408F")
data <- sasxport.get("Final_Project_SLR/BRFSS18.xpt")

data$drvisits[data$drvisits == 88 ] <- 0
data$drvisits[data$drvisits > 76 ] <- NA

data$poorhlth[data$poorhlth == 88 ] <- 0
data$poorhlth[data$poorhlth > 30 ] <- NA

slr <- lm(data = data, poorhlth ~ drvisits)
summary(slr)
