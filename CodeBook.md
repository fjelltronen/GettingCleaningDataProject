---
title: "CodeBook for Getting and Cleaning Data Course Project"
author: "fjelltronen"
date: "April 14, 2018"
output: 
  html_document:
    keep_md: true
---

### Introduction

This file details the transformations of the UCI HAR Dataset that using the `run_analysis.R` script.

### Data Set

This data set represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

30 volunteers performed 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on their waist. A total of 10,299 observations were collected and, for each, 561 attributes were meansured/calculated. 

The data was also randomly split into training (70%) and testing (remaining 30%).

### run_analysis.R

The analysis script (`run_analysis.R`) collects, works with and cleans the data set.

First, it downloads and unzips the data .zip file.

Then, the feature and activity names are read from `features.txt` and `activity_labels.txt`.


```r
features <- read.table("./UCI HAR Dataset/features.txt")
head(features)
```

```
##   V1                V2
## 1  1 tBodyAcc-mean()-X
## 2  2 tBodyAcc-mean()-Y
## 3  3 tBodyAcc-mean()-Z
## 4  4  tBodyAcc-std()-X
## 5  5  tBodyAcc-std()-Y
## 6  6  tBodyAcc-std()-Z
```

```r
activities <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("activity_id","activity"))
head(activities)
```

```
##   activity_id           activity
## 1           1            WALKING
## 2           2   WALKING_UPSTAIRS
## 3           3 WALKING_DOWNSTAIRS
## 4           4            SITTING
## 5           5           STANDING
## 6           6             LAYING
```

Then, the training data is read from the files in the `train` directory.


```r
# use the feature names as column names (changed slightly to be valid column names)
train_features<-read.table(file = "./UCI HAR Dataset/train/X_train.txt",col.names = features$V2)
# 7352 obs. of  561 variables
str(train_features,list.len=6) ## display the first 6 variables only
```

```
## 'data.frame':	7352 obs. of  561 variables:
##  $ tBodyAcc.mean...X                   : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ tBodyAcc.mean...Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ tBodyAcc.mean...Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ tBodyAcc.std...X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ tBodyAcc.std...Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ tBodyAcc.std...Z                    : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
##   [list output truncated]
```

```r
train_labels<-read.table(file="./UCI HAR Dataset/train/y_train.txt",col.names = c("activity_id"))
train_labels <- merge(train_labels,activities) ## append activity names
# 7352 obs. of  2 variables
head(train_labels)
```

```
##   activity_id activity
## 1           1  WALKING
## 2           1  WALKING
## 3           1  WALKING
## 4           1  WALKING
## 5           1  WALKING
## 6           1  WALKING
```

```r
# 7352 obs. of  1 variable
train_subjects<-read.table(file="./UCI HAR Dataset/train/subject_train.txt",col.names=c("subject"))
str(train_subjects,list.len=6)
```

```
## 'data.frame':	7352 obs. of  1 variable:
##  $ subject: int  1 1 1 1 1 1 1 1 1 1 ...
```

```r
# 7352 obs. of  564 variables
train<-cbind(train_labels,train_subjects,train_features)
str(train,list.len=9)
```

```
## 'data.frame':	7352 obs. of  564 variables:
##  $ activity_id                         : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity                            : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ subject                             : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ tBodyAcc.mean...X                   : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ tBodyAcc.mean...Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ tBodyAcc.mean...Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ tBodyAcc.std...X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ tBodyAcc.std...Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ tBodyAcc.std...Z                    : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
##   [list output truncated]
```

Then, the testing data is read from the files in the `test` directory.


```r
# use the feature names as column names (changed slightly to be valid column names)
test_features<-read.table(file = "./UCI HAR Dataset/test/X_test.txt",col.names = features$V2)
# 2947 obs. of  561 variables
str(test_features,list.len=6) ## display the first 6 variables only
```

```
## 'data.frame':	2947 obs. of  561 variables:
##  $ tBodyAcc.mean...X                   : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ tBodyAcc.mean...Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##  $ tBodyAcc.mean...Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
##  $ tBodyAcc.std...X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
##  $ tBodyAcc.std...Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
##  $ tBodyAcc.std...Z                    : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
##   [list output truncated]
```

```r
test_labels<-read.table(file="./UCI HAR Dataset/test/y_test.txt",col.names = c("activity_id"))
test_labels <- merge(test_labels,activities) ## append activity names
# 2947 obs. of  2 variables
head(test_labels)
```

```
##   activity_id activity
## 1           1  WALKING
## 2           1  WALKING
## 3           1  WALKING
## 4           1  WALKING
## 5           1  WALKING
## 6           1  WALKING
```

```r
test_subjects<-read.table(file="./UCI HAR Dataset/test/subject_test.txt",col.names=c("subject"))
# 2947 obs. of  1 variable
str(test_subjects,list.len=6)
```

```
## 'data.frame':	2947 obs. of  1 variable:
##  $ subject: int  2 2 2 2 2 2 2 2 2 2 ...
```

```r
test<-cbind(test_labels,test_subjects,test_features)
# 2947 obs. of  564 variables
str(test,list.len=9)
```

```
## 'data.frame':	2947 obs. of  564 variables:
##  $ activity_id                         : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity                            : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ subject                             : int  2 2 2 2 2 2 2 2 2 2 ...
##  $ tBodyAcc.mean...X                   : num  0.257 0.286 0.275 0.27 0.275 ...
##  $ tBodyAcc.mean...Y                   : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
##  $ tBodyAcc.mean...Z                   : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
##  $ tBodyAcc.std...X                    : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
##  $ tBodyAcc.std...Y                    : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
##  $ tBodyAcc.std...Z                    : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
##   [list output truncated]
```

Then, the training data and the testing data are combined into a new data frame `allData`.


```r
allData<-rbind(train,test)
# 10299 obs. of 564 variables
str(allData,list.len=9)
```

```
## 'data.frame':	10299 obs. of  564 variables:
##  $ activity_id                         : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity                            : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ subject                             : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ tBodyAcc.mean...X                   : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ tBodyAcc.mean...Y                   : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ tBodyAcc.mean...Z                   : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ tBodyAcc.std...X                    : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ tBodyAcc.std...Y                    : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ tBodyAcc.std...Z                    : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
##   [list output truncated]
```

`msData` is computed to have only the measurement columns on the mean and standard deviation from `allData` as well as the `activity` and `subject` columns.


```r
# dataset is subset to only certain column names
msData <- subset(allData,select = (grepl("(\\.(mean|std)\\.)|activity|subject",colnames(allData))))
# 10299 obs. of 69 variables
str(msData,list.len=9)
```

```
## 'data.frame':	10299 obs. of  69 variables:
##  $ activity_id                : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ activity                   : Factor w/ 6 levels "LAYING","SITTING",..: 4 4 4 4 4 4 4 4 4 4 ...
##  $ subject                    : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ tBodyAcc.mean...X          : num  0.289 0.278 0.28 0.279 0.277 ...
##  $ tBodyAcc.mean...Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
##  $ tBodyAcc.mean...Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
##  $ tBodyAcc.std...X           : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
##  $ tBodyAcc.std...Y           : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
##  $ tBodyAcc.std...Z           : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
##   [list output truncated]
```

From this data frame, the tidy data set is computed to have the average of each variable for each activity and each subject. The dataset is printed to the `gcd-tidy-data.txt` file.


```r
avgData <- aggregate(msData[,-c(1:3)], msData[,c(1:3)], mean)
# 40 obs. of 69 variables
head(avgData[,1:9])
```

```
##   activity_id         activity subject tBodyAcc.mean...X tBodyAcc.mean...Y
## 1           1          WALKING       1         0.2656969       -0.01829817
## 2           1          WALKING       2         0.2731131       -0.01913232
## 3           1          WALKING       3         0.2734287       -0.01785607
## 4           1          WALKING       4         0.2770345       -0.01334968
## 5           2 WALKING_UPSTAIRS       4         0.2696859       -0.01710851
## 6           1          WALKING       5         0.2791780       -0.01548335
##   tBodyAcc.mean...Z tBodyAcc.std...X tBodyAcc.std...Y tBodyAcc.std...Z
## 1        -0.1078457       -0.5457953       -0.3677162       -0.5026457
## 2        -0.1156500       -0.6055865       -0.4289630       -0.5893601
## 3        -0.1064926       -0.6234136       -0.4800159       -0.6536256
## 4        -0.1059161       -0.6838645       -0.5896093       -0.7419590
## 5        -0.1100534       -0.4811578       -0.3842553       -0.6582857
## 6        -0.1056617       -0.5076910       -0.4027249       -0.6464436
```

### Data decription

The first three columns of the tidy data contains the `activity_id`, `activity`, and `subject`:


```r
names(avgData)[1:3]
```

```
## [1] "activity_id" "activity"    "subject"
```

All other columns contain the **average** values of the features that contain the *mean* or *std* variable for each activity and subject (same units as the original feature values): 


```r
## 66 variables
names(avgData)[-(1:3)]
```

```
##  [1] "tBodyAcc.mean...X"           "tBodyAcc.mean...Y"          
##  [3] "tBodyAcc.mean...Z"           "tBodyAcc.std...X"           
##  [5] "tBodyAcc.std...Y"            "tBodyAcc.std...Z"           
##  [7] "tGravityAcc.mean...X"        "tGravityAcc.mean...Y"       
##  [9] "tGravityAcc.mean...Z"        "tGravityAcc.std...X"        
## [11] "tGravityAcc.std...Y"         "tGravityAcc.std...Z"        
## [13] "tBodyAccJerk.mean...X"       "tBodyAccJerk.mean...Y"      
## [15] "tBodyAccJerk.mean...Z"       "tBodyAccJerk.std...X"       
## [17] "tBodyAccJerk.std...Y"        "tBodyAccJerk.std...Z"       
## [19] "tBodyGyro.mean...X"          "tBodyGyro.mean...Y"         
## [21] "tBodyGyro.mean...Z"          "tBodyGyro.std...X"          
## [23] "tBodyGyro.std...Y"           "tBodyGyro.std...Z"          
## [25] "tBodyGyroJerk.mean...X"      "tBodyGyroJerk.mean...Y"     
## [27] "tBodyGyroJerk.mean...Z"      "tBodyGyroJerk.std...X"      
## [29] "tBodyGyroJerk.std...Y"       "tBodyGyroJerk.std...Z"      
## [31] "tBodyAccMag.mean.."          "tBodyAccMag.std.."          
## [33] "tGravityAccMag.mean.."       "tGravityAccMag.std.."       
## [35] "tBodyAccJerkMag.mean.."      "tBodyAccJerkMag.std.."      
## [37] "tBodyGyroMag.mean.."         "tBodyGyroMag.std.."         
## [39] "tBodyGyroJerkMag.mean.."     "tBodyGyroJerkMag.std.."     
## [41] "fBodyAcc.mean...X"           "fBodyAcc.mean...Y"          
## [43] "fBodyAcc.mean...Z"           "fBodyAcc.std...X"           
## [45] "fBodyAcc.std...Y"            "fBodyAcc.std...Z"           
## [47] "fBodyAccJerk.mean...X"       "fBodyAccJerk.mean...Y"      
## [49] "fBodyAccJerk.mean...Z"       "fBodyAccJerk.std...X"       
## [51] "fBodyAccJerk.std...Y"        "fBodyAccJerk.std...Z"       
## [53] "fBodyGyro.mean...X"          "fBodyGyro.mean...Y"         
## [55] "fBodyGyro.mean...Z"          "fBodyGyro.std...X"          
## [57] "fBodyGyro.std...Y"           "fBodyGyro.std...Z"          
## [59] "fBodyAccMag.mean.."          "fBodyAccMag.std.."          
## [61] "fBodyBodyAccJerkMag.mean.."  "fBodyBodyAccJerkMag.std.."  
## [63] "fBodyBodyGyroMag.mean.."     "fBodyBodyGyroMag.std.."     
## [65] "fBodyBodyGyroJerkMag.mean.." "fBodyBodyGyroJerkMag.std.."
```
