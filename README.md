Getting And Cleaning Data Course Project
========================================

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The data is from Human Activity Recognition Using Smartphone Data Set, UCI Machine Learning Repository. (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)


This repoitory includes the following files:
============================================
- 'README.md'

- 'run_analysis.R': This script combines all the training and test dataset including the labels. It extracts only the features with mean and std (standard deviation) and the class labels has already been changed to activity name. (The orignal class is labeled as number.)


How to run the run_analysis.R:
==============================
The run_analysis.R fetches the files from (archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).

This script has to place at the same folder with the data folder where you extract your downloaded file.

Folder setup:
The default folder name is "UCI HAR Dataset". If you name the folder of dataset with different name, you can change the variable "dataFolderName" at the very first beginning of the script.
Please do not change any files' names or folders' names within the dataset folder. Please keep the folder structure. The folder structure is described as bellow:

| /UCI HAR Dataset
------------------
|activity_labels.txt
--------------------
|features.txt
-------------
|features_info.txt
------------------
|README.txt
-----------
/train
subject_train.txt
X_train.txt
y_train.txt
/Inertial Signals
/test
subject_test.txt
X_test.txt
y_test.txt
Inertial Signals
           
The script will also ask you if the dplyr package is installed in your R. If so, you can answer "yes" and the speed of creating the tidy data will be faster. 

Notes:
======
- The 'run_analysis.R' provide two methods to clean the dataset, and create a tidy dataset. One method does not require the dplyr library installed. It uses looping to group and average the original data for each subject and each activity. The other method uses dplyr library to create the tidy dataset. Either method is working and it only depends on if the dplyr package has been installed.
