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
##            V1       V2      V3                V4                  V5
## 1 activity_id activity subject tBodyAcc.mean...X   tBodyAcc.mean...Y
## 2           1  WALKING       1 0.265696920582133 -0.0182981725176081
## 3           1  WALKING       2 0.273113115788079 -0.0191323183174834
## 4           1  WALKING       3 0.273428719636364  -0.017856067384956
## 5           1  WALKING       4 0.277034464752577 -0.0133496817746907
##                   V6                 V7                 V8
## 1  tBodyAcc.mean...Z   tBodyAcc.std...X   tBodyAcc.std...Y
## 2  -0.10784573454611 -0.545795331328326 -0.367716218227378
## 3 -0.115649958175497 -0.605586497159271 -0.428962986589404
## 4 -0.106492632429097 -0.623413602046921 -0.480015920697654
## 5 -0.105916135927835  -0.68386446609433 -0.589609330539691
##                   V9                  V10                  V11
## 1   tBodyAcc.std...Z tGravityAcc.mean...X tGravityAcc.mean...Y
## 2 -0.502645746562824    0.744867411573487  -0.0825562579855908
## 3 -0.589360062210596    0.660782866688742   -0.147219886910411
## 4 -0.653625579293255    0.707814353343108  -0.0260590480328739
## 5 -0.741959040257732    0.731456509896907    0.072347989306416
##                    V12                 V13                 V14
## 1 tGravityAcc.mean...Z tGravityAcc.std...X tGravityAcc.std...Y
## 2    0.072339870389049  -0.959859435936599  -0.951150627458213
## 3    0.134865335090728  -0.963015508245033  -0.960033560165563
## 4   0.0480937904190616  -0.966457565630499    -0.9445645371261
## 5    0.193993433768041  -0.967576704329897   -0.94170652321134
##                   V15                   V16                   V17
## 1 tGravityAcc.std...Z tBodyAccJerk.mean...X tBodyAccJerk.mean...Y
## 2  -0.925817590867435    0.0770930495126801    0.0165908438802305
## 3  -0.945365383907285    0.0785353156747351   0.00708771249764901
## 4  -0.926966278211144    0.0701731261988856    0.0144664329060411
## 5  -0.936724233273196    0.0780162237953608   -0.0010311298138299
##                     V18                  V19                  V20
## 1 tBodyAccJerk.mean...Z tBodyAccJerk.std...X tBodyAccJerk.std...Y
## 2  -0.00910758730117003   -0.524721922818732   -0.470412403511239
## 3  0.000755760748377483   -0.557809603123841   -0.491875889831788
## 4 -0.000526818872875366   -0.635484688041056    -0.55721186773783
## 5  -0.00737070069603093   -0.701066737438144   -0.670976701376289
##                    V21                 V22                 V23
## 1 tBodyAccJerk.std...Z  tBodyGyro.mean...X  tBodyGyro.mean...Y
## 2   -0.717322274881844 -0.0208764064320173 -0.0880722729400576
## 3   -0.741885388311258 -0.0517030657821192 -0.0568420186817881
## 4   -0.796066240234604 -0.0248490682828446 -0.0743565308442815
## 5   -0.859502524793814 -0.0298726752979381 -0.0750086556675258
##                  V24                V25                V26
## 1 tBodyGyro.mean...Z  tBodyGyro.std...X  tBodyGyro.std...Y
## 2 0.0862641666597983 -0.686555715201729 -0.450979810499568
## 3 0.0872599422291391 -0.710648927815894 -0.722943674337748
## 4 0.0866875497119062 -0.699262195705865  -0.76302218170088
## 5 0.0956607416628866 -0.750915960835052 -0.828888294742268
##                  V27                    V28                    V29
## 1  tBodyGyro.std...Z tBodyGyroJerk.mean...X tBodyGyroJerk.mean...Y
## 2 -0.597496136795101    -0.0971120197265994    -0.0417164808293948
## 3 -0.634888927843046    -0.0875587491668874    -0.0433986835453642
## 4 -0.709483440322581    -0.0991554609633431    -0.0401923943695015
## 5 -0.745904225824742      -0.10509869233866    -0.0410624426912371
##                      V30                   V31                   V32
## 1 tBodyGyroJerk.mean...Z tBodyGyroJerk.std...X tBodyGyroJerk.std...Y
## 2    -0.0471393985477522    -0.637812687210375    -0.634472244550432
## 3    -0.0557541828188742    -0.671679103311258    -0.783595466728477
## 4    -0.0521178264170088    -0.689328428607038    -0.842659862111437
## 5     -0.060866534304433    -0.778479585721649    -0.911436316752577
##                     V33                V34                V35
## 1 tBodyGyroJerk.std...Z tBodyAccMag.mean..  tBodyAccMag.std..
## 2    -0.664591977786455 -0.453632943768818 -0.497096402038329
## 3    -0.674611933293046 -0.535281800541722 -0.552812545643709
## 4    -0.743028500565982 -0.563140802770059 -0.591224780306452
## 5    -0.790578254329897 -0.637532979814948 -0.670122122716495
##                     V36                  V37                    V38
## 1 tGravityAccMag.mean.. tGravityAccMag.std.. tBodyAccJerkMag.mean..
## 2    -0.453632943768818   -0.497096402038329     -0.545431612066571
## 3    -0.535281800541722   -0.552812545643709      -0.58777744543543
## 4    -0.563140802770059   -0.591224780306452     -0.650182434328446
## 5    -0.637532979814948   -0.670122122716495      -0.72234055742268
##                     V39                 V40                V41
## 1 tBodyAccJerkMag.std.. tBodyGyroMag.mean.. tBodyGyroMag.std..
## 2    -0.515922167555159  -0.475404785802305 -0.499839593745821
## 3    -0.512115278415232  -0.614771054893146 -0.680584887880795
## 4    -0.607658214170381  -0.643150121648094 -0.674010290979472
## 5     -0.71024608685567  -0.708221087886598 -0.749105473365979
##                       V42                    V43                V44
## 1 tBodyGyroJerkMag.mean.. tBodyGyroJerkMag.std..  fBodyAcc.mean...X
## 2      -0.639517432642651     -0.652050770910663 -0.531895161258213
## 3      -0.746559539039735     -0.740088733655629  -0.57377091142947
## 4      -0.784056656246334      -0.80366136372434 -0.625733289873607
## 5      -0.849581355824742     -0.870579517938144 -0.698994344226804
##                  V45                V46                V47
## 1  fBodyAcc.mean...Y  fBodyAcc.mean...Z   fBodyAcc.std...X
## 2 -0.406435448904438 -0.596411165253602 -0.553060616663401
## 3 -0.432566581302351 -0.630081222124834 -0.619788102803311
## 4 -0.501779938505279 -0.699656828592375 -0.623805015199413
## 5 -0.610966605674742 -0.784964119020619 -0.679316495457474
##                  V48                V49                   V50
## 1   fBodyAcc.std...Y   fBodyAcc.std...Z fBodyAccJerk.mean...X
## 2 -0.390150939647061 -0.498583091676081    -0.547348892435764
## 3 -0.464723862913245 -0.600678614835099    -0.561682049622185
## 4 -0.502753639795894 -0.657443765803519    -0.645893496630499
## 5  -0.60587907902268 -0.739920171907216    -0.717973724971649
##                     V51                   V52                  V53
## 1 fBodyAccJerk.mean...Y fBodyAccJerk.mean...Z fBodyAccJerk.std...X
## 2    -0.507343617969859    -0.695305113832853   -0.543979776127867
## 3     -0.50890379901457    -0.715745330403973   -0.595105612895033
## 4    -0.582949919157742    -0.780101644193548   -0.657844055881525
## 5    -0.684648403917526    -0.845383895412371   -0.710952957814433
##                    V54                  V55                V56
## 1 fBodyAccJerk.std...Y fBodyAccJerk.std...Z fBodyGyro.mean...X
## 2   -0.466251676533372   -0.737861932680115 -0.623219182311527
## 3   -0.509147543673841   -0.767087015496689 -0.638717694593046
## 4   -0.559851186088408    -0.81080601659824 -0.642097719778592
## 5   -0.679116699128866   -0.872348615876289 -0.708097003278351
##                  V57                V58                V59
## 1 fBodyGyro.mean...Y fBodyGyro.mean...Z  fBodyGyro.std...X
## 2 -0.505309434070029 -0.553529065425648 -0.708263420861671
## 3 -0.722068978635762 -0.601594889654305 -0.734588540182119
## 4 -0.775144985073314 -0.670734708996481 -0.719276622702346
## 5 -0.851859241237113 -0.723913683350515 -0.765931837365979
##                  V60                V61                V62
## 1  fBodyGyro.std...Y  fBodyGyro.std...Z fBodyAccMag.mean..
## 2 -0.429825832648703 -0.650476162132565 -0.478448523354179
## 3  -0.72716774102649 -0.683114494539735 -0.514569861316887
## 4 -0.758505287214076 -0.751008875659824 -0.579076453758064
## 5 -0.818105282886598 -0.778863649278351 -0.668273665958763
##                  V63                        V64                       V65
## 1  fBodyAccMag.std.. fBodyBodyAccJerkMag.mean.. fBodyBodyAccJerkMag.std..
## 2 -0.589710231217867         -0.499075765624092        -0.541823079570029
## 3 -0.646662308457285         -0.509746432970861        -0.518800797709272
## 4 -0.663079838985044         -0.604752108072727        -0.615643694857361
## 5 -0.724979750463917         -0.702045896773196        -0.723261097164948
##                       V66                    V67
## 1 fBodyBodyGyroMag.mean.. fBodyBodyGyroMag.std..
## 2      -0.535002770337752     -0.566576670397695
## 3      -0.699742945221854     -0.725310337688742
## 4      -0.716822144279179     -0.703839403007038
## 5      -0.785172936701031     -0.769330760360825
##                           V68                        V69
## 1 fBodyBodyGyroJerkMag.mean.. fBodyBodyGyroJerkMag.std..
## 2          -0.645970655298847         -0.685811262634006
## 3          -0.751615078360927         -0.744194981440397
## 4          -0.810085498651026         -0.810032718739003
## 5           -0.86760194427835         -0.884187806804124
```
