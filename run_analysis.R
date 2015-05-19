setwd("C:/My Documents/Company Work/LA County/Getting and Cleaning Data")
getwd()

##Get the data
##Download the file to the Project folder

if (!file.exists("Project")) {
  dir.create("Project")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Project/Dataset.zip",method="curl")

unzip(zipfile="./Project/Dataset.zip",exdir="./Project")

File_path <- file.path("./Project","UCI HAR Dataset")
testFiles <- list.files(File_path,recursive=TRUE)

##Read the data

activityTest <-read.table(file.path(File_path,"test","Y_test.txt"),header=FALSE)
activityTrain <- read.table(file.path(File_path,"train","Y_train.txt"),header=FALSE)

subjectTest <- read.table(file.path(File_path,"test","subject_test.txt"),header=FALSE)
subjectTrain <- read.table(file.path(File_path,"train","subject_train.txt"),header=FALSE)

featuresTest <-read.table(file.path(File_path,"test","X_test.txt"),header=FALSE)
featuresTrain <- read.table(file.path(File_path,"train","X_train.txt"),header=FALSE)

##1.Merges the training and the test sets to create one data set.
##Concatenate the data by row

activityMerge <- rbind(activityTrain,activityTest)
subjectMerge <- rbind(subjectTrain,subjectTest)
featuresMerge <- rbind(featuresTrain,featuresTest)

##Set names to variables

names(subjectMerge) <- c("subject")
names(activityMerge) <- c("activity")
featuresNames <- read.table(file.path(File_path,"features.txt"),head=FALSE)
names(featuresMerge) <- featuresNames$V2

##Merge columns to get the data for all data

act_subj_merge <- cbind(subjectMerge,activityMerge)
final <- cbind(featuresMerge,act_subj_merge)

##2.Extracts only the measurements on the mean and standard deviation for each measurement.

featureNames_msd <- featuresNames$V2[grep("mean\\(\\)|std\\(\\)",featuresNames$V2)]

##Subset the data by selected names of Features

feature_msd <- c(as.character(featureNames_msd),"subject","activity")
final <- subset(final,select=feature_msd)

##3.Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table(file.path(File_path,"activity_labels.txt"),header=FALSE)

##4.Appropriately labels the data set with descriptive variable names.

names(final) <- gsub("^t","time",names(final))
names(final) <- gsub("^f","frequency",names(final))
names(final) <- gsub("Acc","Accelerometer",names(final))
names(final) <- gsub("Gyro","Gyroscope",names(final))
names(final) <- gsub("Mag","Magnitude",names(final))
names(final) <- gsub("BodyBody","Body",names(final))

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(plyr)
tidy <- aggregate(. ~subject+activity,final,mean)
tidy <- tidy[order(tidy$subject,tidy$activity),]

##Output
write.table(tidy,file="tidydata.txt",row.name=FALSE)
