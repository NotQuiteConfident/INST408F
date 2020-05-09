# Hayden Smedley
# Final Project
# Simple Linear Regression

library(Hmisc)

#Get Data
setwd("C:/Users/hayde/Documents/GitHub/INST408F")
data <- sasxport.get("Final_Project_SLR/BRFSS18.xpt")

# Recode drvisits
data$drvisits[data$drvisits == 88 ] <- 0
data$drvisits[data$drvisits > 76 ] <- NA

# Recode poorhlth
data$poorhlth[data$poorhlth == 88 ] <- 0
data$poorhlth[data$poorhlth > 30 ] <- NA

# Simple Linear Regression
slr <- lm(data = data, poorhlth ~ drvisits)
summary(slr)

# Plot Data in a scatter plot
ggplot(data=data,aes(x=drvisits, y=poorhlth))+
  labs(title="Days in the last 30 days in Poor Health by Doctor Visits in the last year",x="Doctor Visits", y = "Days in Poor Health")+
  geom_point(shape=1)
