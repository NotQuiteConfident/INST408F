# Hayden Smedley
# 2/25/20
# INST408F
# Module 5 ICE

# Read csv into data
patient_data <- read.csv("Module 5 ICE/celebrity_patients.csv")
medications <- read.csv("Module 5 ICE/medications.csv")
procedures <- read.csv("Module 5 ICE/procedures.csv")

# Convert IDs to int
medications$ID <- as.integer(as.character(medications$ID))
procedures$ID <- as.integer(as.character(procedures$ID))

# Merge data
pdm <- left_join(patient_data, medications, by = c("Patient_ID" = "ID"))
all_data <- left_join(pdm, procedures, by = c("Patient_ID" = "ID"))

# Get married or separated Males
male_patients <- filter(all_data, MARITAL == "A. MARRIED" | MARITAL   == "D. SEPARATED", SEX == "A. MALE")

# Get married or separated Females
female_patients <- filter(all_data, MARITAL == "A. MARRIED" | MARITAL   == "D. SEPARATED", SEX == "B. FEMALE")

# Sort female patients by HLTHPLN1 (ascending), then by AGE (descending)
female_patients <- arrange(female_patients, HLTHPLN1, desc(AGE))

# Create a new variable in male patients called 'Generation' based on the AGE variable
male_patients <- mutate(male_patients, Generation = ifelse(AGE <= 24, "Gen Z", 
                                          ifelse(AGE %in% 25:39,"Millennial",
                                          ifelse(AGE %in% 40:54, "Gen X",
                                          "Baby Boomer"))))
# Reduce data to Patient_Name, AGE, SEX, Procedure, Medication and Generation in Male data
female_reduced <- select(female_patients, Patient_Name, AGE, SEX, Procedure, Medication)
male_reduced <- select(male_patients, Patient_Name, AGE, SEX, Procedure, Medication, Generation)

# Create CSV files
write.csv(female_reduced, "Module 5 ICE/female_patients.csv")
write.csv(male_reduced, "Module 5 ICE/male_patients.csv")
