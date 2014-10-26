###Getting and Cleaning Data Course Project - run_analysis.R - Code Book

The project involved downloading the UCI HAR Dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 
The data consisted of training, test and descriptive data(subject and activity)

These data sets were merged to create an initial data frame.

All measurement columns, not pertaining to the mean and standard deviation were removed

With regard to meaningful variable names I feel that the creation of variable names is best left to the 
people working in the field, using their domain expertise. who will be 
aware of common abbreviations and jargon and if I subject the data 
to my conventions, I may give an innacurate interpretation. 

The only aspect that I changed is variable names which contain R 
programming constructs (e.g. "(),"-") which will cause confusion in anybody 
trying to perform subsequent analysis on the Tidy data

A second data frame was the produced by creating avaerage values for each subject by each activity.

This data frame was subsequently printed as the tab delimited file "tidyData"
Finally a message is displayed to show that the run is complete

