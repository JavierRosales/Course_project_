setwd("C:/Users/Javier/Documents/UCI HAR Dataset")

# Step 1: Merge the training and test sets to create one data set

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)

# Step 2: Extract only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt")
MS_features <- grep("-(mean|std)\\(\\)", features[, 2])
X <- X[, MS_features]
names(X) <- features[MS_features, 2]

# Step 3: Use descriptive activity names to name the activities in the data set

activity <- read.table("activity_labels.txt")
Y[, 1] <- activities[Y[, 1], 2]
names(Y) <- "activity"


# Step 4: Appropriately label the data set with descriptive variable names

names(Subject) <- "subject"
Complet <- cbind(X, Y, Subject)

# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject

library(plyr)
averages <- ddply(Complet, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages, "tidy_data_averages.txt", row.name=FALSE)


