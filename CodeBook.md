Introduction:
=============
The original dataset is from Human Activity Recognition Using Smartphone Data Set, UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This code book mainly describes the transformations performed to clean up the data. In addition, the variables and the data for the tidy dataset are addressed. For more information about how the experiment has been conducted and the original data has been collected, please find the "README.txt" in the folder of the dataset (https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).

Dataset transformation to tidy dataset
======================================
Please first refer to the README.md to know more about the dataset folder structure. The process of transforming the tidy dataset is as follow:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


