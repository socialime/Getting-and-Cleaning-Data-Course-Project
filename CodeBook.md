About R script

run_analysis.R performs 5 steps:

1.Merges the training and the test sets to create one data set.
-Downloads and unzips the dataset
-Merges the training and the test sets 
-Loads activity labels and features
-Assigns column names
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names.
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Variables created:


x_train
y_train
subject_train
x_test
y_test
and subject_test contain data from downloaded files

activity_labels contains the activity labels
features contains the features
fileURL contains the link to the zip archive
train contains the merged data from the training
test contains the merged data from the tests
all_set contains complete data merged together
columns contains all the columns names for the merged data 

tidy_set contains the independent tidy data set


The source data used: Human Activity Recognition Using Smartphones Data Set. 
A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
