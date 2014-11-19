
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

# features with mean and std
logic_selected_feature <- grepl("*mean|std*", features$V2)
names_selected_feature <- features$V2[logic_select_feature]

# Row combination for X_train and X_test, as well as subject_train and subject_test
X_dataset = rbind(X_train, X_test)
subject_dataset <- rbind(subject_train, subject_test)
colnames(subject_dataset) <- "subject"
activity_dataset <- rbind(y_train_activity_labels, y_test_activity_labels)
colnames(activity_dataset) <- "activity"

# Select all mean and std columns data
X_dataset_selected_feature <- X_dataset[, logic_selected_feature]
colnames(X_dataset_selected_feature) <- names_selected_feature

# Combine the subject ID and Activity into the selected dataset
Final_dataset <- cbind(subject_dataset, X_dataset_selected_feature, activity_dataset)


# Test the correctness of new dataset 