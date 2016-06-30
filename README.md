# Getting and Cleaning Data Project Assignment

## Introduction

This repo was created to contain an R script file that processes and cleans the Human Activity Recognition Using Smartphones Data Set project at the UCI Machine Learning Repository. It will output a text file that contains the average mean and standard deviation measurement values for each activity of each subject(volunteer).

## Instructions

1. First set your R `working directory` to desired folder.
2. Then download the data from here -> [Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
3. Unzipped the contents into the `working directory` making sure you have a `UCI HAR Dataset` folder
4. Place run_analysis.R in the `working directory` as well
5. Run `source("run_analysis.R")` on R console and it will generate a tidy data set called `tiny_data.txt` in your `working directory`.

## Dependencies

The packages data.table and dplyr are used in the analysis. If packages are not installed, the script will do so. 

__Dataset extracted must be in the same folder as R script__

## Extras
More information on dataset can be found here:   
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)



