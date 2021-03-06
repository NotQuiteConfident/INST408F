# Hayden Smedley
# 3/22/20
# INST 408F
# Module 7 ICE

library(car)
library(dplyr)
library(ggplot2)

# Read file
brfss <- read.csv("Module 7 ICE/BRFSS.csv")

# Recode Data
brfss$WEIGHT2[brfss$WEIGHT2 >= 7000] <- NA
brfss$DOCTDIAB[brfss$DOCTDIAB == 88] <- 0
brfss$DOCTDIAB[brfss$DOCTDIAB > 88] <- NA

brfss$MENTHLTH[brfss$MENTHLTH == 88] <- 0
brfss$MENTHLTH[brfss$MENTHLTH > 30] <- NA
brfss$EXERANY2[brfss$EXERANY2 == 1] <- "Yes"
brfss$EXERANY2[brfss$EXERANY2 == 2] <- "No"
brfss$EXERANY2[brfss$EXERANY2 == 7] <- "Don't Know"
brfss$EXERANY2[brfss$EXERANY2 == 9] <- NA

# Create data frame of EXERANY2 frequency and count tables
EXERANY2_df = data.frame(prop.table(table(brfss$EXERANY2)),table(brfss$EXERANY2))
EXERANY2_df = subset(EXERANY2_df, select = -Var1.1)
colnames(EXERANY2_df) <- c("Response", "Frequency", "Count")

# Create data frame of WEIGHT2 and MENTHLTH grouped by EXERANY2
df = data.frame(brfss$WEIGHT2, brfss$MENTHLTH, brfss$EXERANY2)

WEIGHT2_df = data.frame(brfss$WEIGHT2, brfss$EXERANY2)

# Graphs
plot(brfss$WEIGHT2, brfss$DOCTDIAB, 
     main = "Weight in lbs versus number of visits to a Health Professional for diabetes in the last year",
     xlab = "Weight in lbs", ylab = "Visits to a Health Professional for diabetes in the last year")
abline(lm(brfss$DOCTDIAB ~ brfss$WEIGHT2))

boxplot(MENTHLTH ~ EXERANY2, data = brfss,
        main = "Number of poor mental health days in the last 30 days by exercise outside of work",
        xlab = "Exercise outside of work", ylab = "Number of poor mental health days in the last 30 days")

barplot(table(brfss$EXERANY2),
        main = "Respondents by if exercises outside of work",
        xlab = "Exercises outisde of work", ylab = "Number of respondents")

EXERANY2_df

plot_colors = c("black", "blue", "red")
plot(df$brfss.WEIGHT2, df$brfss.MENTHLTH, col = plot_colors[df$brfss.EXERANY2], pch = 19,
     main = "Number of poor mental health days in the last 30 days by Weight in lbs colored by Exercise",
     xlab = "Weight in lbs", ylab = "Number of poor mental health days in the last 30 days")
legend('topright',legend=levels(df$brfss.EXERANY2),col=plot_colors,pch=19,title='Exercise')

ggplot(WEIGHT2_df, aes(x = brfss.WEIGHT2,group=brfss.EXERANY2,fill=brfss.EXERANY2)) +
  geom_histogram(position="identity",alpha=0.5) +
  labs(title = "Frequency of weight grouped by if exercises outside of work", fill = "Exercise") +
  xlab("Weight in lbs") + ylab("Frequency of weight")
