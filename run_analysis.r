## Instructions from Coursera :
## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Check if the required packages are installed
print("checking if required packages are installed")
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

require("data.table")
require("dplyr")

print("Loading features table")
## Load features table
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

print("Loading activity labels")
## Load activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

print("Loading subject tables")
## Load subject tables
subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subj_train) <- "subject"
subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subj_test) <- "subject"

print("Loading Training & Test data")
## Load training & test data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train) <- features
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test) <- features
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

print("decoding the activities")
## decode the activities
y_train[,2] <- activity_labels[y_train$V1,2]
names(y_train) <- c("activityid", "activity")
y_test[,2] <- activity_labels[y_test$V1,2]
names(y_test) <- c("activityid", "activity")

print("merging data")
## merge training & test data
merge_train <- cbind(subj_train,select(y_train, activity),x_train)
merge_test <- cbind(subj_test,select(y_test, activity),x_test)

## Combine training and testing data sets
merged_data <- rbind(merge_train, merge_test)

## Remove duplicate columns - they are not mean or std so removal does not affect final result.
merged_data <- merged_data[ !duplicated(names(merged_data)) ]

print("trimming data to contain mean & std only")
## Extracts the mean and std measurements only
trim_data <- merged_data[,grep("mean\\(\\)|std\\(\\)|subject|activity", names(merged_data))]
names(trim_data) <- gsub('mean', 'Mean', names(trim_data))
names(trim_data) <- gsub('std', 'Std', names(trim_data))
names(trim_data) <- gsub('[-()]', '', names(trim_data))

## Summarize the result into tidydata
## summarise_each is used here because there are multiple measure columns to summarize
## It will parse through any columns that were not group_by
print("creating tidy_data")
tidy_data <-
	(trim_data %>%
	group_by(subject, activity) %>%
	summarise_each(funs(mean)))
	
write.table(tidy_data, file = "./tidy_data.txt", row.name = FALSE)