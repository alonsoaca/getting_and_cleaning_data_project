# getting_and_cleaning_data_project

## Tasks of the project:

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to test:

1. Run by setting the working directory to where the filed: run_analysis.R is located and call the function: source("run_analysis.R")
2. The script reads data files
3. The script merges the test and train data
4. The script joins the multiple files to get descriptions, activities and subjects
5. The script will generate a file calles: tidy_data.txt
