Introduction
============
The original dataset is from Human Activity Recognition Using Smartphone Data Set, UCI Machine Learning Repository (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This code book mainly describes the transformations performed to clean up the data. In addition, the variables and the data for the tidy dataset are addressed. For more information about how the experiment has been conducted and the original data has been collected, please find the "README.txt" in the folder of the dataset (https://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).

Dataset transformation to tidy dataset
======================================
Please first refer to the README.md to know more about the dataset folder structure. The process of transforming the tidy dataset is as follow:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To achieve this process, the run_analysis.R includes five parts.
* General setting before running: This part allows you to set up the data file folder, if your folder name is not the default name (UCI HAR Dataset).

* First part: Read all necessary files: This part reads all the neccessary files, which include: (You can also refer to the README.txt in the dataset.)
    * 'train/X_train.txt': Training set.
    * 'train/y_train.txt': Training labels.
    * 'test/X_test.txt': Test set.
    * 'test/y_test.txt': Test labels.
    * 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
    * 'test/subject_test.txt': Same with subject_train.txt.
    * 'activity_labels.txt': Links the class labels with their activity name.
    * 'features.txt': List of all features.
After loading necessary files into R, it converts the data in y_train and y_test to the activity names. Since the original dataset codes the labels as numbers. 
    
* Second part: Merge training and test data: This part perform the row combination for:
    * X_train + X_test
    * y_train + y_test
    * subject_train + subject_test

* Third part: select only mean and std variables: Because this tidy dataset only extracts the mean and std data of all variables from the original dataset. In order to select the variables with the name mean or std in the variables' names, the grepl function is used with regular expression. ex: grepl("mean[()]|std[()]", features$V2). The last step of this part is to perform column combination of subject dataset, selected X dataset and activity dataset (y dataset).

* Final part: tidy dataset with the average of each variable and each subject: The run_analysis.R provides two options to perform this task. It is prefered that the dplyr package is installed in the R, since the computation speed is faster and the dplyr package provides very clean and powerful functions to do this task such as group_by() and summarise_each(). If the dplyr package is not installed, the regular codes first divide the dataset chunk by chunk by using the loop function. It subsets the data by subject first, then the activity to perform the average.

The variables
=============
This information are from the original features_info.txt in the dataset.

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

Please note that we only select mean value(mean()) and standard deviation (std()) for all variables, so the Weighted average of the frequency components to obtain a mean frequency (meanFreq()) and angle between two vectors(such as angle(tBodyAccJerkMean),gravityMean)) will not be selected. There are 66 variables plus subject and activity in the tidyDataset.txt (total 68 variables). 

* subject: 1 variable
* activity: 1 variable
* tBodyAcc-XYZ: 3 axes * 2 variables (mean + std) 
* tGravityAcc-XYZ: 3 axes * 2 variables (mean + std) 
* tBodyAccJerk-XYZ: 3 axes * 2 variables (mean + std) 
* tBodyGyro-XYZ: 3 axes * 2 variables (mean + std) 
* tBodyGyroJerk-XYZ: 3 axes * 2 variables (mean + std) 
* tBodyAccMag: 2 variables (mean + std)  
* tGravityAccMag: 2 variables (mean + std) 
* tBodyAccJerkMag: 2 variables (mean + std) 
* tBodyGyroMag: 2 variables (mean + std) 
* tBodyGyroJerkMag: 2 variables (mean + std) 
* fBodyAcc-XYZ: 3 axes * 2 variables (mean + std) 
* fBodyAccJerk-XYZ: 3 axes * 2 variables (mean + std)
* fBodyGyro-XYZ: 3 axes * 2 variables (mean + std)
* fBodyAccMag: 2 variables (mean + std) 
* fBodyAccJerkMag: 2 variables (mean + std) 
* fBodyGyroMag: 2 variables (mean + std) 
* fBodyGyroJerkMag: 2 variables (mean + std) 