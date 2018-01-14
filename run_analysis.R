zip <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(zip)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(zip) 
}

#Step 1 
#Merges the training and the test sets to create one data set.
x_train <- read.table("/Users/markboyagi/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("/Users/markboyagi/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("/Users/markboyagi/UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("/Users/markboyagi/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("/Users/markboyagi/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("/Users/markboyagi/UCI HAR Dataset/test/subject_test.txt")

# Loads activity labels and features
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#Assigns column names
colnames(x_train) = features[,2] 
colnames(y_train) = "activityId"
colnames(subject_train) = "subjectId"

colnames(x_test) = features[,2] 
colnames(y_test) = "activityId"
colnames(subject_test) = "subjectId"

colnames(activity_labels) = c('activityId','activityType')

train <- cbind(x_train, y_train, subject_train)
test <- cbind(x_test, y_test, subject_test)

all_set <- rbind(train, test)

columns = colnames(all_set)

#Step 2
# Extracts only the measurements on the mean and standard deviation 
#for each measurement.

mean_and_std = (grepl("activity..",columns) | 
                  grepl("subject..",columns) | 
                  grepl("-mean..",columns) & 
                  !grepl("-meanFreq..",columns) & 
                  !grepl("mean..-",columns) | 
                  grepl("-std..",columns) & 
                  !grepl("-std()..-",columns));

all_set = all_set[mean_and_std == TRUE]

#Step 3
#Uses descriptive activity names to name the activities in the data set
# +
#Step 4
# Appropriately labels the data set with descriptive variable names

set_with_activity_names = merge(all_set, activity_labels,
                              by='activityId',
                              all.x=TRUE)

columns <- colnames(all_set)

for (i in 1:length(columns)) 
{
  columns[i] = gsub("\\()","",columns[i])
  columns[i] = gsub("-std$","StdDev",columns[i])
  columns[i] = gsub("-mean","Mean",columns[i])
  columns[i] = gsub("^(t)","time",columns[i])
  columns[i] = gsub("^(f)","freq",columns[i])
  columns[i] = gsub("AccMag","AccMagnitude",columns[i])
  columns[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columns[i])
  columns[i] = gsub("JerkMag","JerkMagnitude",columns[i])
  columns[i] = gsub("GyroMag","GyroMagnitude",columns[i])
};
colnames(all_set) <- columns

#Step 5
#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

tidy_set <- aggregate(. ~subjectId + activityId, set_with_activity_names, mean)
tidy_set <- tidy_set[order(tidy_set$subjectId, tidy_set$activityId),]
write.table(tidy_set, "tidy_set.txt", row.names = FALSE)