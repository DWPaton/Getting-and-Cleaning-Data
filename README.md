###Getting and Cleaning Data Course Project - run_analysis.R


Author Duncan Paton
Date 26/10/2014

#Script does the following: 
Imports and merges the training and the test data sets sets to produce a single data set.
Removes any measurement column not related to the mean or standard deviation of the measurements
Column names are tidied up to remove any "R" programming constructs
Descriptive activity names are added to the data set 
A second tidy data set is created with the average of each variable for each activity and each subject.
I have endeavoured to use only standard R functions.
