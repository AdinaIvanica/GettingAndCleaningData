# The data for the project:
#         
#         https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# "run_analysis.R" does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("C:/Users/User/Documents/Coursera/GettingandCleaningData/Project/UCI HAR Dataset")

# Merge the training data

# read the data 

activity_labels <- read.table("./activity_labels.txt",header=FALSE)
features <- read.table("./features.txt",header=FALSE)

# read training data 

subject_train <- read.table("./train/subject_train.txt", header=FALSE)
x_train <- read.table("./train/X_train.txt", header=FALSE)
y_train <- read.table("./train/y_train.txt", header=FALSE)

# read test data

subject_test <-read.table("./test/subject_test.txt", header=FALSE)
x_test <- read.table("./test/X_test.txt", header=FALSE)
y_test <- read.table("./test/y_test.txt", header=FALSE)

# assign column names 

colnames(activity_labels)<- c("activity_id","activity_type")

colnames(y_train) <- "activity_id"
colnames(subject_train) <- "subject_id"
colnames(x_train) <- features[,2]

colnames(y_test) <- "activity_id"
colnames(subject_test) <- "subject_id"
colnames(x_test) <- features[,2]

# 1. Merge the training and the test data to create one data set

train_data <- cbind(y_test,subject_test,x_test)
test_data <- cbind(y_test,subject_test,x_test)

# final merge - combining the train and test

final_data <- rbind(train_data,test_data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement

data_mean_std <-final_data[,grepl("mean|std|subject|activity_id",colnames(final_data))]

# 3. Use descriptive activity names to name the activities in the data set

library(plyr)

data_mean_std <- join(data_mean_std, activity_labels, by = "activity_id", match = "first")


# 4.Appropriately label the data set with descriptive variable names

#add descriptive names

names(data_mean_std) <- gsub("Acc", "Acceleration", names(data_mean_std))
names(data_mean_std) <- gsub("^t", "Time", names(data_mean_std))
names(data_mean_std) <- gsub("^f", "Frequency", names(data_mean_std))
names(data_mean_std) <- gsub("BodyBody", "Body", names(data_mean_std))
names(data_mean_std) <- gsub("-mean()", "Mean", names(data_mean_std),ignore.case = TRUE)
names(data_mean_std) <- gsub("-std()", "STD", names(data_mean_std),ignore.case = TRUE)
names(data_mean_std) <- gsub("-freq()", "Frequency", names(data_mean_std),ignore.case = TRUE)
names(data_mean_std) <- gsub("Mag", "Magnitude", names(data_mean_std))
names(data_mean_std) <- gsub("Gyro", "Gyroscope", names(data_mean_std))
names(data_mean_std) <- gsub("tBody", "TimeBody", names(data_mean_std))
names(data_mean_std) <- gsub("angle", "Angle", names(data_mean_std))
names(data_mean_std) <- gsub("gravity", "Gravity", names(data_mean_std))

# remove paranthesis
names(data_mean_std) <- gsub("\\(|\\)", "", names(data_mean_std), perl  = TRUE)

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data_average <- ddply(data_mean_std, c("subject_id","activity_id"), numcolwise(mean))
write.table(tidy_data_average, file="tidy_data.txt", row.names = FALSE)

