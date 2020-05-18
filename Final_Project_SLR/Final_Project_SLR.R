# Hayden Smedley
# Final Project
# Simple Linear Regression

library(Hmisc)

#Get Data
setwd("C:/Users/hayde/Documents/GitHub/INST408F")
data <- read.xport("Final_Project_SLR/BRFSS18.xpt")

# Recode drvisits
data$DRVISITS[data$DRVISITS == 88 ] <- 0
data$DRVISITS[data$DRVISITS > 76 ] <- NA

# Recode poorhlth
data$POORHLTH[data$POORHLTH == 88 ] <- 0
data$POORHLTH[data$POORHLTH > 30 ] <- NA

# Simple Linear Regression
slr <- lm(data = data, POORHLTH ~ DRVISITS)
summary(slr)

# Plot Data in a scatter plot
ggplot(data=data,aes(x=DRVISITS, y=POORHLTH))+
  labs(title="Days in the last 30 days in Poor Health by Doctor Visits in the last year",x="Doctor Visits", y = "Days in Poor Health")+
  geom_point(shape=1)

par(mfrow = c(2, 2))
plot(slr)
