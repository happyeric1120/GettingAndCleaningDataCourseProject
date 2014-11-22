##########     General setting before running    ##########
dataFolderName = "UCI HAR Dataset"

##########     First part: Read all necessary files     ########## 

# Read the training dataset from /train/
X_train <- read.table(paste(dataFolderName, "/train/X_train.txt", sep=""))
y_train <- read.table(paste(dataFolderName, "/train/y_train.txt", sep=""))
subject_train <- read.table(paste(dataFolderName, "/train/subject_train.txt", sep=""))

# Read the test dataset from /test/
X_test <- read.table(paste(dataFolderName, "/test/X_test.txt", sep=""))
y_test <- read.table(paste(dataFolderName, "/test/y_test.txt", sep=""))
subject_test <- read.table(paste(dataFolderName, "/test/subject_test.txt", sep=""))

# Read the Activity name from activity_labels.txt and 
# convert y_train and y_test to activity names
activity_labels <- read.table(paste(dataFolderName, "/activity_labels.txt", sep=""))
y_train_activity_labels <- sapply(y_train, function(x) x <- activity_labels$V2[x])
y_test_activity_labels <- sapply(y_test, function(x) x <- activity_labels$V2[x])


# Read the feature name from features.txt
features <- read.table(paste(dataFolderName, "/features.txt", sep=""))

##########     End of the first part     ########## 

##########     Second part: Merge training and test data     ##########


# Row combination for X_train and X_test, as well as subject_train and subject_test
X_dataset = rbind(X_train, X_test)
subject_dataset <- rbind(subject_train, subject_test)
colnames(subject_dataset) <- "subject"
activity_dataset <- rbind(y_train_activity_labels, y_test_activity_labels)
colnames(activity_dataset) <- "activity"

##########     End of the Second part     ##########

##########     Third part: select only mean and std variables     ##########

# features with mean and std
logic_selected_feature <- grepl("*[Mm]ean|std*", features$V2)
names_selected_feature <- features$V2[logic_selected_feature]

# Select all mean and std columns data
X_dataset_selected_feature <- X_dataset[, logic_selected_feature]
colnames(X_dataset_selected_feature) <- names_selected_feature

# Combine the subject ID and Activity into the selected dataset
Final_dataset <- cbind(subject_dataset, X_dataset_selected_feature, activity_dataset)

##########     End of the third part     ##########

##########     Final part: tidy dataset with the avg of     ##########
##########     each variable and each subject               ##########
dplyrInstalled <- readline("Do you have dplyr package installed? (Yes/No): ")


if (grepl("[Nn][Oo]", dplyrInstalled)) {
    
    ## If the dplyr library is not installed  ##
    
    activity_raw_dataset <- rbind(y_train, y_test)
    colnames(activity_raw_dataset) <- "activity"
    Final_dataset_backup <- cbind(subject_dataset, activity_raw_dataset, X_dataset_selected_feature)
    
    Final_group_data <- data.frame()
    
    for (i in unique(Final_dataset_backup$subject)) {
        for (j in unique(Final_dataset_backup$activity)) {
            subset_data <- subset(Final_dataset_backup, Final_dataset_backup$subject == i &
                                      Final_dataset_backup$activity == j)
            df_colmean <- colMeans(subset_data)
            Final_group_data <- rbind(Final_group_data, df_colmean)
        } 
    }
    colnames(Final_group_data) <- c("subject", "activity", as.character(names_selected_feature))
    Final_group_data$activity <- sapply(Final_group_data$activity, function(x) x <- activity_labels$V2[x])
    Final_group_data <- Final_group_data[order(Final_group_data$subject, Final_group_data$activity),]
    # write.csv(Final_group_data, file = "resNoLib.csv")
    write.table(Final_group_data, file = "tidyDataset.txt", row.names = FALSE)
    
    message("New tidy dataset created! (tidyDataset.txt)")
    
} else if (grepl("[Yy][Ee][Ss]", dplyrInstalled)) {
    
    ## If the dplyr library is not installed  ##
    
    library(dplyr)
    test_dataset <- Final_dataset
    test_dataset_tbl <- tbl_df(test_dataset)
    test_dataset_tbl_grouped <- group_by(test_dataset_tbl, subject, activity)
    res <- summarise_each(test_dataset_tbl_grouped, funs(mean))
    # write.csv(res, file="result.csv")
    write.table(res, file = "tidyDataset.txt", row.names = FALSE)
    
    message("New tidy dataset created! (tidyDataset.txt)")
    
#     res1 <- test_dataset_tbl %>%
#         group_by(subject, activity) %>%
#         summarise_each(funs(mean))
    
} else {
    message("Can't read your answer! Please run the script again!")
}