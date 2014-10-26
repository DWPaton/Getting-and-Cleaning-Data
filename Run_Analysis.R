

##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Duncan Paton
## 26/10/2014

# runAnalysis.r File Description:

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

##########################################################################
#STAGE 1
#Merges the training and the test sets to create one data set.
#clean the workspace
rm(list=ls())
#set working Directory (root directory of unzipped files)
setwd('C:/Coursera Courses/Data Science Specialisation/Getting and Cleaning Data/Homework/Project/UCI HAR Dataset')
features <- read.table('./features.txt',header=FALSE) #imports features.txt
activityType <- read.table('./activity_labels.txt',header=FALSE) #imports activity_labels.txt
names(activityType) <- c("Activity_Id", "Activity")
gactivityType <<- activityType
subjectTrain <- read.table('./train/subject_train.txt',header=FALSE) #imports subject_train.txt
subjectTest <- read.table('./test/subject_test.txt',header=FALSE) #imports subject_test.txt
xTrain <- read.table('./train/x_train.txt',header=FALSE) #imports x_train.txt
yTrain <- read.table('./train/y_train.txt',header=FALSE) #imports y_train.txt
xTest <- read.table('./test/x_test.txt',header=FALSE) #imports x_test.txt
yTest <- read.table('./test/y_test.txt',header=FALSE) #imports y_test.txt
#Assemble the data frame
dftemp <- rbind(xTrain, xTest)
names(dftemp) <- features[,2]

coltemp <- rbind( subjectTrain,subjectTest)
names(coltemp) <- "Subject"
dftemp <- cbind(dftemp,coltemp)

coltemp <- rbind(yTrain, yTest)
names(coltemp) <- "Activity"
dftemp <- cbind(dftemp,coltemp)

##########################################################################
#STAGE 2
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#create a logical vector of the columns containing "-mean()" or "-std()"
num_cols <- ncol(dftemp)
dftempbak <- dftemp
column_names <- colnames(dftemp)
selected_columns <- (grepl("-mean()",column_names, fixed = TRUE) | 
                         grepl("-std()",column_names, fixed = TRUE) )
# retain subject and activity
selected_columns[(num_cols-1)] <- TRUE
selected_columns[num_cols] <- TRUE
#build dataframe
dftemp <- dftemp[,selected_columns]

###########################################################################
#STAGE 3
#Uses descriptive activity names to name the activities in the data set
num_cols <- ncol(dftemp) # the number of coumns has changed, so recalculate
dftemp[,num_cols] <- factor(dftemp[,num_cols] , 
                            levels = activityType[,1], labels = activityType[,2])


##########################################################################
#STAGE 4
#Appropriately labels the data set with descriptive variable names.
# I am only removing anything which may cause the variable names to be
# confused with R code, further down the line

#replace the comma with a dot
column_names <- names(dftemp)
column_names <- gsub(",",".",column_names, fixed = TRUE)
#replace the brackets with a nothing build_factor<-fun
column_names <- gsub("(","",column_names,fixed = TRUE)
column_names <- gsub(")","",column_names,fixed = TRUE)
#replace the minus wih underscore
column_names <- gsub("-","_",column_names,fixed = TRUE)
names(dftemp) <- column_names

#########################################################################
#STEP 5
#From the data set in step 4, creates a second, independent tidy 
#data set with the average of each variable for each activity and each subject.
tempData <- suppressWarnings(aggregate(dftemp[,names(dftemp)
                != c('Activity','Subject')], 
                by=list(Activity=dftemp$Activity, Subject = dftemp$Subject),mean))
#tidy up data by removing extraneous columns and  swapping the subject and 
#activity columns in order that the slowest moving item in a sequence 
#(Subject), is displayed before the faster moving item (Activity)
tempData <- tempData[,1:(ncol(tempData) -2)]
tempData$Activity<-as.character(tempData$Activity)
tmpCol1 <- as.data.frame(tempData[1])
tmpCol2 <- as.data.frame(tempData[2])
tempData <- tempData[,3:ncol(tempData)]

tempData <- cbind(tmpCol1,tempData)
tempData <- cbind(tmpCol2,tempData)
#Finally write the data to file
write.table(tempData, 'tidyData.txt',row.names=FALSE,sep='\t')
message("Processing complete")

##########################################################################
