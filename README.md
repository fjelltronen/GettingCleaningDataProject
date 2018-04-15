---
title: "Getting and Cleaning Data Course Project"
author: "fjelltronen"
date: "April 14, 2018"
output: 
  html_document:
    keep_md: true
---

### Introduction

This Github repo contains the required scripts to collect, work with, and clean the UCI HAR Dataset.

This `README` file explains the analysis files:

* The `CodeBook.md` file describes the variables, the data, and the transformations that are performed on this dataset when using the `run_analysis.R` script.

* The `gcd-tidy-data.txt` contains the tidy data set with the average of each variable for each activity and each subject.

### UCI HAR Dataset

The data used for this project represents data collected from the accelerometers from the Samsung Galaxy S smartphone for the purpose of recognizing human activity using smartphones. More information can be found in `CodeBook.md` or, directly, from the site that hosts the data set (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### run_analysis.R

This script contains all the steps need to collect, work with, and clean the UCI HAR Dataset.

1. it downloads the .zip archive from the data URL and unzips the downloaded file
2. reads the feature and activity names from `features.txt` and `activity_labels.txt`
3. reads the training data
    * the feature values from `train/X_train.txt` (uses feature names to set column names)
    * the activity ids from `train/y_train.txt`; then merges with activity_labels to have activity names as well
    * the subject information from `train/subject_train.txt`
    * column binds all these data frames into `train`
3. reads the testing data
    * the feature values from `train/X_test.txt` (uses feature names to set column names)
    * the activity ids from `train/y_test.txt`; then merges with activity_labels to have activity names as well
    * the subject information from `train/subject_test.txt`
    * column binds all these data frames into `test`
4. row combines `train` and `test` into `allData`
5. selects from `allData` only the columns that have *mean* or *std* of measurements; also *activity* and *subject* columns
6. computes the average of each variable for each activity and each subject into `avgData` and writes this data frame to `gdc-tidy-data.txt`

For more information, check the `CodeBook.md` document.

### gdc-tidy-data.txt

This file contains the final data frame computed to contains the average of each variable for each activity and each subject.


```r
read.table(file="./gcd-tidy-data.txt",nrows = 5)
```

```
##   activity_id         activity subject tBodyAcc.mean...X tBodyAcc.mean...Y
## 1           1          WALKING       1         0.2656969       -0.01829817
## 2           1          WALKING       2         0.2731131       -0.01913232
## 3           1          WALKING       3         0.2734287       -0.01785607
## 4           1          WALKING       4         0.2770345       -0.01334968
## 5           2 WALKING_UPSTAIRS       4         0.2696859       -0.01710851
##   tBodyAcc.mean...Z tBodyAcc.std...X tBodyAcc.std...Y tBodyAcc.std...Z
## 1        -0.1078457       -0.5457953       -0.3677162       -0.5026457
## 2        -0.1156500       -0.6055865       -0.4289630       -0.5893601
## 3        -0.1064926       -0.6234136       -0.4800159       -0.6536256
## 4        -0.1059161       -0.6838645       -0.5896093       -0.7419590
## 5        -0.1100534       -0.4811578       -0.3842553       -0.6582857
##   tGravityAcc.mean...X tGravityAcc.mean...Y tGravityAcc.mean...Z
## 1            0.7448674          -0.08255626           0.07233987
## 2            0.6607829          -0.14721989           0.13486534
## 3            0.7078144          -0.02605905           0.04809379
## 4            0.7314565           0.07234799           0.19399343
## 5            0.6673775           0.17606422           0.11703063
##   tGravityAcc.std...X tGravityAcc.std...Y tGravityAcc.std...Z
## 1          -0.9598594          -0.9511506          -0.9258176
## 2          -0.9630155          -0.9600336          -0.9453654
## 3          -0.9664576          -0.9445645          -0.9269663
## 4          -0.9675767          -0.9417065          -0.9367242
## 5          -0.9548459          -0.9409598          -0.9487836
##   tBodyAccJerk.mean...X tBodyAccJerk.mean...Y tBodyAccJerk.mean...Z
## 1            0.07709305           0.016590844         -0.0091075873
## 2            0.07853532           0.007087712          0.0007557607
## 3            0.07017313           0.014466433         -0.0005268189
## 4            0.07801622          -0.001031130         -0.0073707007
## 5            0.08020059           0.010681219         -0.0073785632
##   tBodyAccJerk.std...X tBodyAccJerk.std...Y tBodyAccJerk.std...Z
## 1           -0.5247219           -0.4704124           -0.7173223
## 2           -0.5578096           -0.4918759           -0.7418854
## 3           -0.6354847           -0.5572119           -0.7960662
## 4           -0.7010667           -0.6709767           -0.8595025
## 5           -0.5226868           -0.4469801           -0.8178820
##   tBodyGyro.mean...X tBodyGyro.mean...Y tBodyGyro.mean...Z
## 1        -0.02087641        -0.08807227         0.08626417
## 2        -0.05170307        -0.05684202         0.08725994
## 3        -0.02484907        -0.07435653         0.08668755
## 4        -0.02987268        -0.07500866         0.09566074
## 5        -0.02747357        -0.08458137         0.09580699
##   tBodyGyro.std...X tBodyGyro.std...Y tBodyGyro.std...Z
## 1        -0.6865557        -0.4509798        -0.5974961
## 2        -0.7106489        -0.7229437        -0.6348889
## 3        -0.6992622        -0.7630222        -0.7094834
## 4        -0.7509160        -0.8288883        -0.7459042
## 5        -0.6232957        -0.7498895        -0.6955707
##   tBodyGyroJerk.mean...X tBodyGyroJerk.mean...Y tBodyGyroJerk.mean...Z
## 1            -0.09711202            -0.04171648            -0.04713940
## 2            -0.08755875            -0.04339868            -0.05575418
## 3            -0.09915546            -0.04019239            -0.05211783
## 4            -0.10509869            -0.04106244            -0.06086653
## 5            -0.11221347            -0.03843447            -0.05298637
##   tBodyGyroJerk.std...X tBodyGyroJerk.std...Y tBodyGyroJerk.std...Z
## 1            -0.6378127            -0.6344722            -0.6645920
## 2            -0.6716791            -0.7835955            -0.6746119
## 3            -0.6893284            -0.8426599            -0.7430285
## 4            -0.7784796            -0.9114363            -0.7905783
## 5            -0.6375281            -0.8884120            -0.6817954
##   tBodyAccMag.mean.. tBodyAccMag.std.. tGravityAccMag.mean..
## 1         -0.4536329        -0.4970964            -0.4536329
## 2         -0.5352818        -0.5528125            -0.5352818
## 3         -0.5631408        -0.5912248            -0.5631408
## 4         -0.6375330        -0.6701221            -0.6375330
## 5         -0.4417897        -0.5062974            -0.4417897
##   tGravityAccMag.std.. tBodyAccJerkMag.mean.. tBodyAccJerkMag.std..
## 1           -0.4970964             -0.5454316            -0.5159222
## 2           -0.5528125             -0.5877774            -0.5121153
## 3           -0.5912248             -0.6501824            -0.6076582
## 4           -0.6701221             -0.7223406            -0.7102461
## 5           -0.5062974             -0.5516651            -0.5478902
##   tBodyGyroMag.mean.. tBodyGyroMag.std.. tBodyGyroJerkMag.mean..
## 1          -0.4754048         -0.4998396              -0.6395174
## 2          -0.6147711         -0.6805849              -0.7465595
## 3          -0.6431501         -0.6740103              -0.7840567
## 4          -0.7082211         -0.7491055              -0.8495814
## 5          -0.5743852         -0.6399158              -0.7712592
##   tBodyGyroJerkMag.std.. fBodyAcc.mean...X fBodyAcc.mean...Y
## 1             -0.6520508        -0.5318952        -0.4064354
## 2             -0.7400887        -0.5737709        -0.4325666
## 3             -0.8036614        -0.6257333        -0.5017799
## 4             -0.8705795        -0.6989943        -0.6109666
## 5             -0.8025599        -0.5181034        -0.3915613
##   fBodyAcc.mean...Z fBodyAcc.std...X fBodyAcc.std...Y fBodyAcc.std...Z
## 1        -0.5964112       -0.5530606       -0.3901509       -0.4985831
## 2        -0.6300812       -0.6197881       -0.4647239       -0.6006786
## 3        -0.6996568       -0.6238050       -0.5027536       -0.6574438
## 4        -0.7849641       -0.6793165       -0.6058791       -0.7399202
## 5        -0.7083463       -0.4685884       -0.4223346       -0.6596235
##   fBodyAccJerk.mean...X fBodyAccJerk.mean...Y fBodyAccJerk.mean...Z
## 1            -0.5473489            -0.5073436            -0.6953051
## 2            -0.5616820            -0.5089038            -0.7157453
## 3            -0.6458935            -0.5829499            -0.7801016
## 4            -0.7179737            -0.6846484            -0.8453839
## 5            -0.5480034            -0.4708611            -0.7932489
##   fBodyAccJerk.std...X fBodyAccJerk.std...Y fBodyAccJerk.std...Z
## 1           -0.5439798           -0.4662517           -0.7378619
## 2           -0.5951056           -0.5091475           -0.7670870
## 3           -0.6578441           -0.5598512           -0.8108060
## 4           -0.7109530           -0.6791167           -0.8723486
## 5           -0.5400025           -0.4593776           -0.8419271
##   fBodyGyro.mean...X fBodyGyro.mean...Y fBodyGyro.mean...Z
## 1         -0.6232192         -0.5053094         -0.5535291
## 2         -0.6387177         -0.7220690         -0.6015949
## 3         -0.6420977         -0.7751450         -0.6707347
## 4         -0.7080970         -0.8518592         -0.7239137
## 5         -0.5374453         -0.7994596         -0.6347291
##   fBodyGyro.std...X fBodyGyro.std...Y fBodyGyro.std...Z fBodyAccMag.mean..
## 1        -0.7082634        -0.4298258        -0.6504762         -0.4784485
## 2        -0.7345885        -0.7271677        -0.6831145         -0.5145699
## 3        -0.7192766        -0.7585053        -0.7510089         -0.5790765
## 4        -0.7659318        -0.8181053        -0.7788636         -0.6682737
## 5        -0.6520627        -0.7273362        -0.7485191         -0.4977235
##   fBodyAccMag.std.. fBodyBodyAccJerkMag.mean.. fBodyBodyAccJerkMag.std..
## 1        -0.5897102                 -0.4990758                -0.5418231
## 2        -0.6466623                 -0.5097464                -0.5188008
## 3        -0.6630798                 -0.6047521                -0.6156437
## 4        -0.7249798                 -0.7020459                -0.7232611
## 5        -0.5908825                 -0.5293018                -0.5769917
##   fBodyBodyGyroMag.mean.. fBodyBodyGyroMag.std..
## 1              -0.5350028             -0.5665767
## 2              -0.6997429             -0.7253103
## 3              -0.7168221             -0.7038394
## 4              -0.7851729             -0.7693308
## 5              -0.6833150             -0.6746316
##   fBodyBodyGyroJerkMag.mean.. fBodyBodyGyroJerkMag.std..
## 1                  -0.6459707                 -0.6858113
## 2                  -0.7516151                 -0.7441950
## 3                  -0.8100855                 -0.8100327
## 4                  -0.8676019                 -0.8841878
## 5                  -0.7934581                 -0.8298315
```
