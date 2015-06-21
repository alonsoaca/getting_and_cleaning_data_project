
## Set WD

setwd("/Users/alonso/Dropbox/Aprendizaje/Coursera/Data Scientist Specialization/03. Getting and Cleaning Data/week_3/getting_and_cleaning_data_project")

## Column Names

features_names <- read.table("features_names.txt")[['V1']]

## load libraries

if (!require("reshape2")) {
  install.packages("reshape2")
}

library(dplyr)
library(reshape2)

## Read the activitties descriptions and rename variables:

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c("activity_id","activity_desc"))

## Read observations and activities 


test_data <- read.table("UCI HAR Dataset/test/X_test.txt",col.names = features_names)
test_data_activities <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("activity_id"))
test_data_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))

train_data <- read.table("UCI HAR Dataset/train/X_train.txt",col.names = features_names)
train_data_activities <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity_id"))
train_data_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))


## Merge train and test

activities_vector <- c(test_data_activities[["activity_id"]],train_data_activities[["activity_id"]])

data <- merge(test_data, train_data, all = T)
#data_activities <- dim(merge(test_data_activities, train_data_activities, all = T))
data_activities <- data.frame(activity_id = activities_vector)
data_subjects <- merge(test_data_subjects, train_data_subjects, all = T)

## Select only mean and Std

data  <- data[ , grepl("(mean|std)", names( data ),ignore.case=T)]

## Add sequence so we can join both datasets

observations_seq = seq(along = data[,1])
data <- mutate(data , observation_id = observations_seq)
data_activities <- mutate(data_activities , observation_id = observations_seq)
data_subjects <- mutate(data_subjects , observation_id = observations_seq)

## Join obeservations with activities and their desc

data <- merge(data, data_activities,by="observation_id")
data <- merge(data, data_subjects,by="observation_id")
data <- merge(data, activity_labels,by="activity_id")
data <- select(data,-activity_id)
data <- select(data,-observation_id)


id_labels <- c("subject", "activity_desc")
data_labels <- setdiff(colnames(data), id_labels)

melt_data = melt(data, id = id_labels, measure.vars = data_labels)

tidy_data <- dcast(melt_data, subject + activity_desc ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt",row.names = F)

