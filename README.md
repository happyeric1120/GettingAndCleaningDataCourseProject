GettingAndCleaningDataCourseProject
===================================

Getting and cleaning data course project
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The data is from Human Activity Recognition Using Smartphone Data Set, UCI Machine Learning Repository. (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


This repoitory includes the following files:
============================================
- 'README.md'

- 'run_analysis.R': This script combines all the training and test dataset including the labels. It extracts only the features with mean and std (standard deviation) and the class labels has already been changed to activity name. (The orignal class is labeled as number.)

Notes:
======
- The 'run_analysis.R' provide two methods to clean the dataset, and create a tidy dataset. One method does not require the dplyr library installed. It uses looping to group and average the original data for each subject and each activity. The other method uses dplyr library to create the tidy dataset. Either method is working and it only depends on if the dplyr package has been installed.
