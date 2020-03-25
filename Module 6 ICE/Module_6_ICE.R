# Hayden Smedley
# 3/3/20
# INST408F
# Module 6 ICE

setwd("C:/Users/hayde/Documents/INST408F")

# Import coronavirus data
cv <- read.csv("Module 6 ICE/coronavirus.csv")

# Find the number the cases by Sex
summary(cv$Sex[cv$CoronaVirus==1])

# Find number of cases by Country
summary(cv$Country[cv$CoronaVirus==1])

# Percentage of deaths by race
prop.table(table(cv$Race[cv$CoronaVirus==1 & cv$Death==1]))*100

# Median age of coronavirus cases in China
median(cv$Age[cv$Country=="China" & cv$CoronaVirus=="1"])

# Answer:
# 2. More Females have the most cases
# 3. Brazil, Ivory Coast, Mexico and Nigeria have no cases of coronavirus
# 4. 12.18% of coronavirus deaths were black or african american
# 5. The median age of coronavirus cases in China is 29