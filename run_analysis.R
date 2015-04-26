
## Script that transforms select parts of the UCI HAR Dataset to a tiday data set. 
## Please refer to the README.rmd for details
## Rev0001  2015-04-24,hpj  :Coursera version


##**********************************************************************************************************************
##****  1a. Extract the training, test, subject, activity and variable ID data from the UCI HAR Dataset.zip file   *****
##**********************************************************************************************************************


##  Load data.table package
require(data.table)

##  Fetch the current working directory and create path to the zip archive
zipArchiveFile <- file.path(getwd(), "getdata_projectfiles_UCI HAR Dataset.zip")


##  Extract the training data set and speed up processing by using a given data class
trainDTx  <- as.data.table(read.table(unzip(zipArchiveFile,
                                            files="UCI HAR Dataset/train/X_train.txt",list=F),
                                      header=F,sep="",colClasses="numeric"))


##  Extract training activity type info
trainDTy  <- as.data.table(read.table(unzip(zipArchiveFile,
                                            files="UCI HAR Dataset/train/y_train.txt",list=F),
                                      header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(trainDTy,"V1","Va")


##  Extract training subject info
trainDTsubj  <- as.data.table(read.table(unzip(zipArchiveFile,
                                               files="UCI HAR Dataset/train/subject_train.txt",list=F),
                                         header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(trainDTsubj,"V1","Vs")


##  Extract the test data set and speed up processing by using a given data class
testDTx  <- as.data.table(read.table(unzip(zipArchiveFile,
                                           files="UCI HAR Dataset/test/X_test.txt",list=F),
                                     header=F,sep="",colClasses="numeric"))


##  Extract test activity type info
testDTy  <- as.data.table(read.table(unzip(zipArchiveFile,
                                           files="UCI HAR Dataset/test/y_test.txt",list=F),
                                     header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(testDTy,"V1","Va")


##  Extract test subject info
testDTsubj  <- as.data.table(read.table(unzip(zipArchiveFile,
                                              files="UCI HAR Dataset/test/subject_test.txt",list=F),
                                        header=F,sep="",colClasses="numeric"))
##  Rename default variable name V1 to avoid merging conflicts later
setnames(testDTsubj,"V1","Vs")



##  extract feature label names
featLabels  <- read.table(unzip(zipArchiveFile,
                                              files="UCI HAR Dataset/features.txt",list=F),
                                        header=F,sep="",,stringsAsFactors=F)[,2]

##  extract activity label names
activityLabels  <- read.table(unzip(zipArchiveFile,
                                    files="UCI HAR Dataset/activity_labels.txt",list=F),
                              header=F,sep="",,stringsAsFactors=F)[,2]





##****  1b. Merge the extracted training and the test sets and clean up memory *****************************************

##   Merging done by:
##   Adding Subject and activity type info columns to data frame using cbind
##   vertically merging the training and test data frames using rbind
##   creating a final copy of the dataframe as we are going to delete all the intermediate frames..
mergedDT = copy(rbind(cbind(trainDTsubj,trainDTy,trainDTx),cbind(testDTsubj,testDTy,testDTx)))

##  Remove original table data from memory
rm(list=c("trainDTsubj","trainDTy","trainDTx","testDTsubj","testDTy","testDTx","zipArchiveFile"))


##  List the number of NAs encountered in the extracted and merged dataset
print(paste("Number of NAs in extracted and merged data= ", sum(all(is.na(mergedDT))),sep=""))

##**********************************************************************************************************************
##**********************************************************************************************************************
##**********************************************************************************************************************





##**********************************************************************************************************************
##****  2. Appropriately label the data set with descriptive variable names. *******************************************
##**********************************************************************************************************************

#Convert names into valid column names and get rid of "."
featLabels <- gsub(".","", make.names(featLabels,unique=T),fixed=T)

#And make names more readable..
#Improve ease of reading by using "camelBack" style on mean and std 
featLabels  <- gsub("mean","Mean", featLabels,fixed=T)
featLabels  <- gsub("std","Std", featLabels,fixed=T)

#Improve ease of reading by expanding variable domain abreviations
featLabels  <- gsub("fBody","freqBody", featLabels,fixed=T)
featLabels  <- gsub("tBody","timeBody", featLabels,fixed=T)
featLabels  <- gsub("tGravity","timeGravity", featLabels,fixed=T)
featLabels  <- gsub("angletimeBody","angleTimeBody", featLabels,fixed=T)
#Remove double bodies..
featLabels  <- gsub("BodyBody","Body", featLabels,fixed=T)

#Replace default names in datatable with improved names
setnames(mergedDT,names(mergedDT),c("Subject","Activity",featLabels)) 

##**********************************************************************************************************************
##**********************************************************************************************************************
##**********************************************************************************************************************


##**********************************************************************************************************************
##****  3. Extract only the the mean and standard deviation for each measurement. **************************************
##**********************************************************************************************************************


##  create subset vector to include subject, activity, mean and std.dev columns only 
subsetVect <- c(1,2,grep("([mM]ean)|([sS]td)",names(mergedDT)))
 
##  reduce the data table using the subset vector
mergedDT <- mergedDT[,subsetVect,with=FALSE]

##**********************************************************************************************************************
##**********************************************************************************************************************
##**********************************************************************************************************************




##**********************************************************************************************************************
##****  4. Use descriptive activity names to name the activities in the data set ***************************************
##**********************************************************************************************************************


## Replace activity numbers with literal activity description
## We could use the normal way to replace values in a column:
## mergedDF$Activity <- featLabels[mergedDF$Activity]
## but the := is faster on large data tables
mergedDT[,Activity:=activityLabels[mergedDT$Activity]]



## Remove remaing non needed variables from memory 
rm(list=c("activityLabels", "featLabels","subsetVect"))

##**********************************************************************************************************************
##**********************************************************************************************************************
##**********************************************************************************************************************




##**********************************************************************************************************************
##****  5. From the data set in step 4, create a second, independent tidy data set with the average of each        *****
##****  variable for each activity and each subject                                                                *****
##**********************************************************************************************************************


## Generate an independent tidy data table with mean() for each Activity and Subject grouping
tidyDT <- copy(mergedDT[,lapply(.SD,mean),keyby=c("Activity","Subject"),.SDcols=3:dim(mergedDT)[2]])
    
## Create text file of the tidy dataset
write.table(tidyDT,"tidyDT.txt",row.names = F)

#Final memory clean up
rm(list=c("mergedDT","tidyDT"))


##**********************************************************************************************************************
##**********************************************************************************************************************
##**********************************************************************************************************************

print(paste("Tidy data set saved in file tidyDT.txt in your working directory",sep = ""))

