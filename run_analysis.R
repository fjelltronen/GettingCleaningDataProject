# download the data file to local disk
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","./gcd-project.zip")
# extract the data from the .zip archive
unzip(zipfile = "./gcd-project.zip")

# read the names of the features into "features"
features <- read.table("./UCI HAR Dataset/features.txt")
# read the names of the activities into "activities"
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activity_id","activity"))

# read the feature values for the training data, using the feature names from "features"
# (dataset now has descriptive variable names)
train_features<-read.table(file = "./UCI HAR Dataset/train/X_train.txt",col.names = features$V2)

# read the label values for the training data; label the column as "activity_id"
train_labels<-read.table(file="./UCI HAR Dataset/train/y_train.txt",col.names = c("activity_id"))
# merge the activity names into the train_labels data frame
# (dataset now has descriptive activity names)
train_labels <- merge(train_labels,activities)

# read the subject values for the training data; label the column as "subject"
train_subjects<-read.table(file="./UCI HAR Dataset/train/subject_train.txt",col.names=c("subject"))

# column bind all three data frames into "train"
train<-cbind(train_labels,train_subjects,train_features)

# read the feature values for the testing data, using the feature names from "features"
# (dataset now has descriptive variable names)
test_features<-read.table(file = "./UCI HAR Dataset/test/X_test.txt",col.names = features$V2)

# read the label values for the testing data; label the column as "activity_id"
test_labels<-read.table(file="./UCI HAR Dataset/test/y_test.txt",col.names = c("activity_id"))
# merge the activity names into the test_labels data frame
# (dataset now has descriptive activity names)
test_labels <- merge(test_labels,activities)

# read the subject values for the training data; label the column as "subject"
test_subjects<-read.table(file="./UCI HAR Dataset/test/subject_test.txt",col.names=c("subject"))

# column bind all three data frames into "test"
test<-cbind(test_labels,test_subjects,test_features)

# row bind both train and test into allData
# (training and testing sets are now merged)
allData<-rbind(train,test)

# keep only the columns that have the mean or std of measurements; also activity and subject columns
msData <- subset(allData,select = (grepl("(\\.(mean|std)\\.)|activity|subject",colnames(allData))))

# tidy dataset with average of each variable for each activity and each subject
avgData <- aggregate(msData[,-c(1:3)], msData[,c(1:3)], mean)
write.table(avgData,file="./gcd-tidy-data.txt",row.names = FALSE)
