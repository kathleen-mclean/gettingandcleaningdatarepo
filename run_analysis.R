# One R script called run_analysis.R

setwd("C:/DL/UCI HAR Dataset/")

# Load libraries
library(dplyr)
library(tidyr)

# Load in the datasets

# Train files

subject_train <- read.table(file = "train/subject_train.txt")
X_train <- read.table(file = "train/X_train.txt")
y_train <- read.table(file = "train/y_train.txt")

# Test files

subject_test <- read.table(file = "test/subject_test.txt")
X_test <- read.table(file = "test/X_test.txt")
y_test <- read.table(file = "test/y_test.txt")

# Overall files

activity_labels <- read.table(file = "activity_labels.txt")
names(activity_labels) <- c("activity_id", "activity_name")
features <- read.table(file = "features.txt")

###############################################################################
# Step 1:
# Merge the training and the test sets to create one data set.

# Add subject id to the test data
test <- bind_cols(X_test, subject_test) %>%
  # And activity label numbers
  bind_cols(y_test)

# Add subject id to the train data
train <- bind_cols(X_train, subject_train) %>%
  # And activity label numbers
  bind_cols(y_train)

# Change the field headings
names(test) <- c(as.character(features[,2]), "subject_id", "activity_id")
names(train) <- c(as.character(features[,2]), "subject_id", "activity_id")

# Combine the two datasets

alldata <- rbind(test, train)

###############################################################################
# Step 2:
# Extract only the measurements on the mean and standard deviation for each measurement. 

# Remove columns for which the name is duplicated
# names(alldata)[duplicated(names(alldata))] # None contain "mean" or "std" anyway
alldatasub <- alldata[, -which(duplicated(names(alldata)))]

alldatasub <- select(alldatasub, matches("-mean\\(|-std\\(")) %>%
  # add back the subject and activity ids
  bind_cols(alldata[, c("subject_id", "activity_id")])

###############################################################################
# Step 3:
# Use descriptive activity names to name the activities in the data set

alldatasub <- merge(alldatasub, activity_labels, by = "activity_id", all = T)

###############################################################################
# Step 4:
# Appropriately label the data set with descriptive variable names. 

# Rename some variables
alldatasubclean <- rename(alldatasub, Subject = subject_id, Activity = activity_name) %>%
  # remove activity_id
  select(-activity_id) %>%
  # Make a long dataset instead of wide
  gather(key = "Measurement", "Value", 1:66)

# Make the measurement character strings more descriptive
alldatasubclean$Measurement <- gsub(pattern = "^t", "TimeDomain", alldatasubclean$Measurement)
alldatasubclean$Measurement <- gsub(pattern = "^f", "FastFourierTransformed", alldatasubclean$Measurement)
alldatasubclean$Measurement <- gsub(pattern = "Acc", "Accelerometer", alldatasubclean$Measurement)
alldatasubclean$Measurement <- gsub(pattern = "Gyro", "Gyroscope", alldatasubclean$Measurement)
alldatasubclean$Measurement <- gsub(pattern = "Mag", "Magnitude", alldatasubclean$Measurement)
alldatasubclean$Measurement <- gsub(pattern = "\\(\\)", "", alldatasubclean$Measurement)

###############################################################################
# Step 5:
# From the data set in step 4, create a second, independent tidy data set with the average 
# of each variable for each activity and each subject.

# Columns: Subject, Activity, Measurement, AverageValue 

alldatasubfinal <- group_by(alldatasubclean, Subject, Activity, Measurement) %>%
  summarise(AverageValue = mean(Value))

write.table(alldatasubfinal, file = "finaltidydataset.txt", row.names = F)
