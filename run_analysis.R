##########     First part: Read all necessary files     ########## 

# Read the training dataset from /train/
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read the test dataset from /test/
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read the Activity name from activity_labels.txt and 
# convert y_train and y_test to activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
y_train_activity_labels <- sapply(y_train, function(x) x <- activity_labels$V2[x])
y_test_activity_labels <- sapply(y_test, function(x) x <- activity_labels$V2[x])


# Read the feature name from features.txt
features <- read.table("UCI HAR Dataset/features.txt")

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
write.table(res, file = "resultNoLib.txt", row.names = FALSE)



## If the dplyr library is installed  ##
library(dplyr)
test_dataset <- Final_dataset
test_dataset_tbl <- tbl_df(test_dataset)
test_dataset_tbl_grouped <- group_by(test_dataset_tbl, subject, activity)
res <- summarise_each(test_dataset_tbl_grouped, funs(mean))
# write.csv(res, file="result.csv")
write.table(res, file = "result.txt", row.names = FALSE)

res1 <- test_dataset_tbl %>%
    group_by(subject, activity) %>%
    summarise_each(funs(mean))
