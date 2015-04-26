---
title: "Code book for tidyDT.txt"
output: html_document
---

####    ORIGIN

The variables in this data set constitutes the aggregate averages of a select set of features from the UCI HAR data set containing data collected from the accelerometers on the Samsung Galaxy S smartphone. The full original data set including a more detailed description is available at the UC Irvine Machine Learning Repository site: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

####    DATA SET PROCESSING

The original UCI HAR data set upon which this data set is based contains 10299 observations of 561 estimated feature variables. The feature variables represent descriptive statistics and other descriptive mathematical transformations used to characterize 10 time based, 7 frequency based (FFT) and 5 angular variables, which in turn themselves are time filtered and derived versions of the original acceleration and gyro raw signals of the smartphones. 

Among the descriptive statistics used are averages (mean) and standard deviations (std). The averages and standard deviations constitute 86 out of the 561 variables and are those used as basis for this data set.

Each observation is further associated with one of 6 activities and a subject 1 through 30 identifying the person observed.

This data set represents the averages of said 86 feature variables grouped by said activities and subjects and hence has a size of (6 x 30) of (2+6) i.e. 180 observations of 88 variables. The wide and short format has been chosen for output. Although the values for the 86 variables are averages, it has been chosen not to add a another "mean" to the variable names as this is not judged to improve readability  

####    DATA SET VARIABLE DESCRIPTION

Column|Variable|class|Description
------|--------|-----|------
01|Activity|char|WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
02|Subject |int|1-30, identifying the person observed              
03|timeBodyAccMeanX|num|Mean of: time domain, mean body acceleration X direction signal  
04|timeBodyAccMeanY|num|Mean of: time domain, mean body acceleration Y direction signal  
05|timeBodyAccMeanZ|num|Mean of: time domain, mean body acceleration Z direction signal  
06|timeBodyAccStdX|num|Mean of: time domain, std.dev body acceleration X direction signal  
07|timeBodyAccStdY|num|Mean of: time domain, std.dev body acceleration Y direction signal  
08|timeBodyAccStdZ|num|Mean of: time domain, std.dev body acceleration Z direction signal  
09|timeGravityAccMeanX|num|Mean of: time domain, mean gravity acceleration X direction signal  
10|timeGravityAccMeanY|num|Mean of: time domain, mean gravity acceleration Y direction signal  
11|timeGravityAccMeanZ|num|Mean of: time domain, mean gravity acceleration Z direction signal  
12|timeGravityAccStdX|num|Mean of: time domain, std.dev gravity acceleration X direction signal  
13|timeGravityAccStdY|num|Mean of: time domain, std.dev gravity acceleration Y direction signal  
14|timeGravityAccStdZ|num|Mean of: time domain, std.dev gravity acceleration Z direction signal  
15|timeBodyAccJerkMeanX|num|Mean of: time domain, mean body acceleration jerk X direction signal  
16|timeBodyAccJerkMeanY|num|Mean of: time domain, mean body acceleration jerk Y direction signal  
17|timeBodyAccJerkMeanZ|num|Mean of: time domain, mean body acceleration jerk Z direction signal  
18|timeBodyAccJerkStdX|num|Mean of: time domain, std.dev body acceleration jerk X direction signal  
19|timeBodyAccJerkStdY|num|Mean of: time domain, std.dev body acceleration jerk Y direction signal  
20|timeBodyAccJerkStdZ|num|Mean of: time domain, std.dev body acceleration jerk Z direction signal  
21|timeBodyGyroMeanX|num|Mean of: time domain, mean body gyro X direction signal  
22|timeBodyGyroMeanY|num|Mean of: time domain, mean body gyro Y direction signal  
23|timeBodyGyroMeanZ|num|Mean of: time domain, mean body gyro Z direction signal  
24|timeBodyGyroStdX|num|Mean of: time domain, std.dev body gyro X direction signal  
25|timeBodyGyroStdY|num|Mean of: time domain, std.dev body gyro Y direction signal  
26|timeBodyGyroStdZ|num|Mean of: time domain, std.dev body gyro Z direction signal  
27|timeBodyGyroJerkMeanX|num|Mean of: time domain, mean body gyro jerk X direction signal  
28|timeBodyGyroJerkMeanY|num|Mean of: time domain, mean body gyro jerk Y direction signal  
29|timeBodyGyroJerkMeanZ|num|Mean of: time domain, mean body gyro jerk Z direction signal  
30|timeBodyGyroJerkStdX|num|Mean of: time domain, std.dev body gyro jerk X direction signal  
31|timeBodyGyroJerkStdY|num|Mean of: time domain, std.dev body gyro jerk Y direction signal  
32|timeBodyGyroJerkStdZ|num|Mean of: time domain, std.dev body gyro jerk Z direction signal  
33|timeBodyAccMagMean|num|Mean of: time domain, mean body acceleration magnitude signal  
34|timeBodyAccMagStd|num|Mean of: time domain, std.dev body acceleration magnitude signal  
35|timeGravityAccMagMean|num|Mean of: time domain, mean gravity acceleration magnitude signal  
36|timeGravityAccMagStd|num|Mean of: time domain, std.dev gravity acceleration magnitude signal  
37|timeBodyAccJerkMagMean|num|Mean of: time domain, mean body acceleration jerk magnitude signal  
38|timeBodyAccJerkMagStd|num|Mean of: time domain, std.dev body acceleration jerk magnitude signal  
39|timeBodyGyroMagMean|num|Mean of: time domain, mean body gyro magnitude signal  
40|timeBodyGyroMagStd|num|Mean of: time domain, std.dev body gyro magnitude signal  
41|timeBodyGyroJerkMagMean|num|Mean of: time domain, mean body gyro magnitude signal  
42|timeBodyGyroJerkMagStd|num|Mean of: time domain, std.dev body gyro magnitude signal  
43|freqBodyAccMeanX|num|Mean of: frequency domain, mean body acceleration X direction signal  
44|freqBodyAccMeanY|num|Mean of: frequency domain, mean body acceleration Y direction signal  
45|freqBodyAccMeanZ|num|Mean of: frequency domain, mean body acceleration Z direction signal  
46|freqBodyAccStdX|num|Mean of: frequency domain, std.dev body acceleration X direction signal  
47|freqBodyAccStdY|num|Mean of: frequency domain, std.dev body acceleration Y direction signal  
48|freqBodyAccStdZ|num|Mean of: frequency domain, std.dev body acceleration Z direction signal  
49|freqBodyAccMeanFreqX|num|Mean of: frequency domain, body acceleration weighted mean frequency X direction signal  
50|freqBodyAccMeanFreqY|num|Mean of: frequency domain, body acceleration weighted mean frequency Y direction signal  
51|freqBodyAccMeanFreqZ|num|Mean of: frequency domain, body acceleration weighted mean frequency Z direction signal  
52|freqBodyAccJerkMeanX|num|Mean of: frequency domain, mean body acceleration jerk X direction signal  
53|freqBodyAccJerkMeanY|num|Mean of: frequency domain, mean body acceleration jerk Y direction signal  
54|freqBodyAccJerkMeanZ|num|Mean of: frequency domain, mean body acceleration jerk Z direction signal  
55|freqBodyAccJerkStdX|num|Mean of: frequency domain, std.dev body acceleration jerk X direction signal  
56|freqBodyAccJerkStdY|num|Mean of: frequency domain, std.dev body acceleration jerk Y direction signal  
57|freqBodyAccJerkStdZ|num|Mean of: frequency domain, std.dev body acceleration jerk Y direction signal  
58|freqBodyAccJerkMeanFreqX|num|Mean of: frequency domain, body acceleration jerk weighted mean frequency X direction signal  
59|freqBodyAccJerkMeanFreqY|num|Mean of: frequency domain, body acceleration jerk weighted mean frequency Y direction signal  
60|freqBodyAccJerkMeanFreqZ|num|Mean of: frequency domain, body acceleration jerk weighted mean frequency Z direction signal  
61|freqBodyGyroMeanX|num|Mean of: frequency domain, mean body gyro X direction signal  
62|freqBodyGyroMeanY|num|Mean of: frequency domain, mean body gyro Y direction signal  
63|freqBodyGyroMeanZ|num|Mean of: frequency domain, mean body gyro Z direction signal  
64|freqBodyGyroStdX|num|Mean of: frequency domain, std.dev body gyro X direction signal  
65|freqBodyGyroStdY|num|Mean of: frequency domain, std.dev body gyro Y direction signal  
66|freqBodyGyroStdZ|num|Mean of: frequency domain, std.dev body gyro Z direction signal  
67|freqBodyGyroMeanFreqX|num|Mean of: frequency domain, body gyro weighted mean frequency X direction signal  
68|freqBodyGyroMeanFreqY|num|Mean of: frequency domain, body gyro weighted mean frequency Y direction signal  
69|freqBodyGyroMeanFreqZ|num|Mean of: frequency domain, body gyro weighted mean frequency Z direction signal  
70|freqBodyAccMagMean|num|Mean of: frequency domain, mean body acceleration magnitude signal  
71|freqBodyAccMagStd|num|Mean of: frequency domain, std.dev body acceleration magnitude signal  
72|freqBodyAccMagMeanFreq|num|Mean of: frequency domain, body acceleration magnitude weighted mean frequency signal  
73|freqBodyAccJerkMagMean|num|Mean of: frequency domain, mean body acceleration jerk magnitude signal  
74|freqBodyAccJerkMagStd|num|Mean of: frequency domain, std.dev body acceleration jerk magnitude signal  
75|freqBodyAccJerkMagMeanFreq|num|Mean of: frequency domain, body acceleration jerk magnitude weighted mean frequency signal  
76|freqBodyGyroMagMean|num|Mean of: frequency domain, mean body gyro magnitude signal  
77|freqBodyGyroMagStd|num|Mean of: frequency domain, std.dev body gyro magnitude signal  
78|freqBodyGyroMagMeanFreq|num|Mean of: frequency domain, body gyro magnitude weighted mean frequency signal  
79|freqBodyGyroJerkMagMean|num|Mean of: frequency domain, mean body gyro jerk magnitude signal  
80|freqBodyGyroJerkMagStd|num|Mean of: frequency domain, std.dev body gyro jerk magnitude signal  
81|freqBodyGyroJerkMagMeanFreq|num|Mean of: frequency domain, body gyro jerk magnitude weighted mean frequency signal  
82|angleTimeBodyAccMeangravity|num|Mean angle of: time domain, body acceleration mean gravity signal  
83|angleTimeBodyAccJerkMeangravityMean|num|Mean angle of: time domain, mean body acceleration jerk mean gravity signal  
84|angleTimeBodyGyroMeangravityMean|num|Mean angle of: time domain, mean body gyro mean  
85|angleTimeBodyGyroJerkMeangravityMean|num|Mean angle of: time domain, mean body gyro jerk mean gravity signal  
86|angleXgravityMean|num|Mean angle of: time domain, mean gravity X direction signal  
87|angleYgravityMean|num|Mean angle of: time domain, mean gravity Y direction signal  
88|angleZgravityMean|num|Mean angle of: time domain, mean gravity Z direction signal  

####    DATA SET SAVE FORMAT
The data set in the file "tidyDT.txt" contains 181 rows and has been saved in standard text format, with the first row (header) containing the variable names and using white space (0x20H) as field separator. Text data such as variable names and activities in column 1 are embedded in double quotes. The subject variable in column 2 is integer and the remaining variables numeric (floating point) using "." as decimal point

The file can be read into R using one of the following commands (assuming the file is located in the work directory)

```
require(data.table)
tidyDataset <- fread("./tidyDT.txt",header=T,sep=" ")
```
OR
```
tidyDataset <- read.table("./tidyDT.txt",header=T)
```


