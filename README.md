---
title: "README for run_analysis.R"
output: html_document
---

## General info

This R Markdown document is intended to describe design considerations and use of the script run_analysis.R in transforming 
the UCI HAR data set into a tidy data set. The document is "display only" and the code chunks embedded will not be executed during mark down processing.

The run_analysis.R script performs the following:

1. Extracts and merges the training, test, subject, activity and variable ID data from the UCI HAR Dataset.zip file.
2. Labels data set variables with appropriate descriptive names. 
3. Extracts the mean and standard deviation variables for each measurement.
4. Replaces activity number IDs with descriptive literal names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The UCI HAR data set used, contains data collected from the accelerometers on the Samsung Galaxy S smartphone from a number of subjects observed during a number of different activities. The data comes as training and a test subset each of which further contains both processed and raw data. A full description is available at the UC Irvine Machine Learning Repository site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Using the script
Place the script in your working directory and in the console window enter: source("run_analysis.R")
Depending on the speed of your PC it may take a while, but eventually the the two messages shown after the source command below, should appear

```
source("run_analysis.R")
#>  [1] "Number of NAs in extracted and merged data= 0"
#>  [1] "Tidy data set saved in file tidyDT.txt in your working directory"
```
Alternatively you can open the script in RStudio and execute it step by step...

## The script step by step

#### 1. Extract and merge select data from the UCI HAR Dataset.zip file into a data subset

Since the desired end product is an aggregate tidy data set based upon a subset of the processed UCI HAR data, the raw data found under the "inertial Signal" folders will be ignored. This also avoids the challenge of having to generate appropriate descriptive names for 128 variables of the raw data. 

The combined size of the processed UCI HAR data amounts to 10299 vectors of 561+ variables, and although much larger data sets exist, the approx 50MB size and subsequent processing of the data lends itself to the use of the data.table package, which contains the fread() function. Unfortunately the field separator in the ICU HAR data is one or more spaces (0x20H), which the fread() function in it's current version 1.9.4, does not support. The quite a bit slower read.table will therefor be used for reading the data into memory.  

In preparation of the extraction we first load the data.table package and subsequently set up the full file path the UCI HAR zip data file. For the script to work, the UCI HAR zip data file **must** be named *getdata_projectfiles_UCI HAR Dataset.zip* and **must** be located in the working directory.

```
##  Load data.table package
require(data.table)

##  Fetch the current working directory and create path to zip archive
zipArchiveFile <- file.path(getwd(), "getdata_projectfiles_UCI HAR Dataset.zip")
```

For actual extraction and loading into R memory is done by embedding the unzip() function into the read.table function and finally embedding the latter in a as.data.table coercion. The unzip() function takes the datafile(s) to extract as argument and the list = **F**ALSE ensures activates extraction rather than listing. Besides the output from the unzip() function, the read.table() has colClasses="numeric" to speed up the read, and sep="" which allows for one or more spaces as field separator.   

First we extract the training data (7352 observations of 561 variables)
```
##  Extract the training data set and speed up processing by using a given data class
trainDTx  <- as.data.table(read.table(unzip(zipArchiveFile,
                                            files="UCI HAR Dataset/train/X_train.txt",list=F),
                                      header=F,sep="",colClasses="numeric"))
```


Next we extract the activity data (7352 observations of 1 variable). As no header information is available the variables will be named V1, V2,V3... by default. To facilitate subsequent merging and avoid name conflicts we need to rename the V1 variable. We choose "Va" for "activity". Renaming is done using the setnames() function of the data.table package. 
```
##  Extract training activity type info
trainDTy  <- as.data.table(read.table(unzip(zipArchiveFile,
                                            files="UCI HAR Dataset/train/y_train.txt",list=F),
                                      header=F,sep="",colClasses="numeric"))

##  Rename default variable name V1 to avoid merging conflicts later
setnames(trainDTy,"V1","Va")
```


We are now ready to extract the subject info variable of the training date. 
As mentioned above the default "V1" name must be renamed to "Vs" for "subject".
```
##  Extract training subject info
trainDTsubj  <- as.data.table(read.table(unzip(zipArchiveFile,
                                               files="UCI HAR Dataset/train/subject_train.txt",list=F),
                                         header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(trainDTsubj,"V1","Vs")

```

With the training data extracted and loaded, continue with the test data..


First extract the test data (2947 observations of 561 variables)

```
##  Extract the test data set and speed up processing by using a given data class
testDTx  <- as.data.table(read.table(unzip(zipArchiveFile,
                                           files="UCI HAR Dataset/test/X_test.txt",list=F),
                                     header=F,sep="",colClasses="numeric"))
```


Next extract the activity data (2947 observations of 1 variable) and rename variable "V1" to "Va"
```
##  Extract test activity type info
testDTy  <- as.data.table(read.table(unzip(zipArchiveFile,
                                           files="UCI HAR Dataset/test/y_test.txt",list=F),
                                     header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(testDTy,"V1","Va")
```

..and extract the subject data (2947 observations of 1 variable) and rename variable "V1" to "Vs"
```
##  Extract test subject info
testDTsubj  <- as.data.table(read.table(unzip(zipArchiveFile,
                                              files="UCI HAR Dataset/test/subject_test.txt",list=F),
                                        header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(testDTsubj,"V1","Vs")
```

With both training and test data data extracted and loaded we just need to extract the 561 variable names (called feature labels) of the processed data and the literal activity names, which is done in the same manner as above except that the only interested in the column 2 of the extracted date and thus use [,2] sub-setting

```
##  extract the 561 feature label (variable) names
featLabels  <- read.table(unzip(zipArchiveFile,
                                              files="UCI HAR Dataset/features.txt",list=F),
                                        header=F,sep="",,stringsAsFactors=F)[,2]

##  extract activity label names
activityLabels  <- read.table(unzip(zipArchiveFile,
                                    files="UCI HAR Dataset/activity_labels.txt",list=F),
                              header=F,sep="",,stringsAsFactors=F)[,2]
```

We are now ready to merge the extracted data, which we will do using the cbind() function to horizontally merge the subject, activity and 561 processed feature variables in turn on the training and test objects and the subsequently merge the new training and test set into one 10299 observations by 563 variables data.table object called mergedDT. Although strictly not necessary, we will make an independent copy of the data.table and then remove all the extraction objects not needed for further
processing.

```
##   Merging done by:
##   Adding Subject and activity type info columns to data frame using cbind
##   vertically merging the training and test data frames using rbind
##   creating a final copy of the dataframe as we are going to delete all the intermediate frames..
mergedDT = copy(rbind(cbind(trainDTsubj,trainDTy,trainDTx),cbind(testDTsubj,testDTy,testDTx)))

##  Remove original table data from memory
rm(list=c("trainDTsubj","trainDTy","trainDTx","testDTsubj","testDTy","testDTx","zipArchiveFile"))
```

Let's finalize this step by checking if there are any NAs in the new data since no special steps has been taken to handle these in the subsequent processing

```
##  List the number of NAs encountered in the extracted and merged dataset
print(paste("Number of NAs in extracted and merged data= ", sum(all(is.na(mergedDT))),sep=""))
```
 
 

####  2. Label the data set variables with appropriate descriptive names.

The names of the extracted 561 variables need a bit of cleaning up to be "R-compliant". The exact naming philosophy is however quite "subjective", and besides removing non allowable characters we shall restrict the name-morphing to improve readability to capitalizing the first letter of the name abbreviation sections (aka camelBack), and all done automatically without dealing with individual names.    

First apply the make.names() function to get rid of non compliant name features
```
#Convert names into valid column names and get rid of "."
featLabels <- gsub(".","", make.names(featLabels,unique=T),fixed=T)
```

Next apply camelBack capitalization to names containing the "mean" and "std" 
```
#And make names more readable...
#Improve ease of reading by using "camelBack" style on mean and std 
featLabels  <- gsub("mean","Mean", featLabels,fixed=T)
featLabels  <- gsub("std","Std", featLabels,fixed=T)
```

Then expand the domain abbreviation "f" to "freq" and "t" to "time" and capitalize "t" in angletime.. 
```
#Improve ease of reading by expanding variable domain abreviations
featLabels  <- gsub("fBody","freqBody", featLabels,fixed=T)
featLabels  <- gsub("tBody","timeBody", featLabels,fixed=T)
featLabels  <- gsub("tGravity","timeGravity", featLabels,fixed=T)
featLabels  <- gsub("angletimeBody","angleTimeBody", featLabels,fixed=T)

```
Then replace "BodyBody" with "Body"
```
#Remove double bodies..
featLabels  <- gsub("BodyBody","Body", featLabels,fixed=T)
```

And finally replace the default names with the improved names, manually adding "subject" and "activity" to the original vector.
We again here use the data.table:::setnames() function
```
#Replace default names in datatable with improved names
setnames(mergedDT,names(mergedDT),c("Subject","Activity",featLabels)) 
```

####  3. Extract the mean and standard deviation variables for each measurement.
The UCI HAR processed data contains various forms of averages and standard deviations. Since the target application for the final tidy data set is not known, we shall select the average and standard deviation variables to remain in the data set by a simple search for existence of "mean" or "std" in the variable names.   

First use regular expressions to create a sub-setting vector indicating column positions of variable names including either "mean" or "std". Since we want to retain also the "subject" and "activity" columns we manually append 1,2 to the start of the sub-setting vector
```
##  create subset vector to include subject, activity, mean and std.dev columns only 
subsetVect <- c(1,2,grep("([mM]ean)|([sS]td)",names(mergedDT)))
```

Then use the sub-setting vector as the second argument to mergedDT data.table object to extract only the columns with names matching those in the sub-setting vector. To allow the data.table object to correctly interpret the second argument as  sub-setting vector and not as variables, we need to set the "with" to FALSE. The resulting mergedDT data.table contains 10299 observations of 88 variables 
```
##  reduce the data table using the subset vector
mergedDT <- mergedDT[,subsetVect,with=FALSE]
```

####  4. Replace activity number IDs with descriptive literals. 
The content of the activity variable currently number between 1 and 6 are replaced with more descriptive. One may choose to keep the numeral version and just add another column for the literal version as numbers generally process faster than char vectors. Since two variables with the same information is not tidy however, we will stick with the replacement.
For the replacement we use the ":=" data.table operation along with the numeral activity vector used as an index in the activityLabels vector (look up table).   
After the replacement we remove objects not needed from memory 

```
## Replace activity numbers with literal activity description
## We could use the normal way to replace values in a column:
## mergedDF$Activity <- featLabels[mergedDF$Activity]
## but the := is faster on large data tables
mergedDT[,Activity:=activityLabels[mergedDT$Activity]]


## Remove remaing non needed variables from memory 
rm(list=c("activityLabels", "featLabels","subsetVect"))
```


####  5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
As a final transformation we create a tidy data set consisting of the averages and standard deviations for all the variables for each subject and each activity. We choose to keep the variable names as they are.  
The transformation is performed using the lapply() function to apply the mean() function to .SD (Subset Data.table).The variables i.e. the columns contained in subset .SD is controlled using the .SDcols arguments, which in this case is a numeric vector starting at 3 and ending at the number of columns (88). The grouping is controlled using the keyby = c("Activity","Subject") argument, which further swaps the order of activity and subject in the tidy data.table to the order specified in the assignment description. Using "keyby" rather than "by" will result in the data.table being sorted.

```
## Generate an independent tidy data table with mean() for each Activity and Subject grouping
tidyDT <- copy(mergedDT[,lapply(.SD,mean),keyby=c("Activity","Subject"),.SDcols=3:dim(mergedDT)[2]])
```
We are now ready to save the result using the write table.table() function. The tidy data.table will be saved in the working directory using the name "tidyDT.txt". We are using defaults, i.e. space as field separator, header = TRUE, but with row.names = FALSE.

```
## Create text file of the tidy dataset
write.table(tidyDT,"tidyDT.txt",row.names = F)
```

Perform the final memory clean up and remove all objects from memory

```
#Final memory clean up
rm(list=c("mergedDT","tidyDT"))
```

#### NOTE:
You may use either of the following read formats to read the tidy data file "tidyDT.txt" located in the working directory, back into R:  

```
require(data.table)
tidyDataset <- fread("./tidyDT.txt",header=T,sep=" ")
```
OR
```
tidyDataset <- read.table("./tidyDT.txt",header=T)
```