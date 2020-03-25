# Hayden Smedley
# 2/18/20
# INST408F
# Module 4 ICE

# Read csv into data
data <- read.csv("Module 4 ICE/patients-1.csv")

# Find number of rows in data
nrow(data)

# Find number of columns in data
ncol(data)

# Print first ten observations
head(data, n=10)

# Print last ten observations
tail(data, n=10)

# Loop through data to print the type and summary of each variable
for(var in data){
  
  print("------------------------------")
  print(typeof(var))
  print(summary(var))
  
}
