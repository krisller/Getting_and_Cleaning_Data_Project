#**********************************************************************************************
# Author        : Rafael Krisller
# Date          : Feb 22, 2015
# Description   : Final project (Getting and Cleaning Data)
#**********************************************************************************************

#**********************************************************************************************
# 1. Merges the training and the test sets to create one data set.
# 4. Appropriately labels the data set with descriptive variable names. 
#**********************************************************************************************

# Changing work directory to where files are stored.
setwd("c:/projeto/coursera/getdata/project/Dataset")

# Read the train files
x_train <- read.table('./train/X_train.txt')
subject_train <- read.table('./train/subject_train.txt')
y_train <- read.table('./train/y_train.txt')

# Read the test files
x_test <- read.table('./test/X_test.txt')
subject_test <- read.table('./test/subject_test.txt')
y_test <- read.table('./test/y_test.txt')

# Combining subject, y and x objects in new one
datatrain <- cbind(subject_train, y_train, x_train)
datatest <- cbind(subject_test, y_test, x_test)

# Combining datatrain and datatest in new one object
data <- rbind(datatrain, datatest)

# Read features data
features <- read.table("features.txt", quote="\"")
columnsName <- as.character(features$V2)

#Changing column names with descriptive variable names
colnames(data) = c("subject", "activity", columnsName)

#**********************************************************************************************
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#**********************************************************************************************

#Create a logical vector for mean and standard deviation columns
vectColNames <- grepl("mean\\(\\)|std\\(\\)",features$V2, ignore.case = TRUE)

#Create a character vector to store filtered columns name
filteredColNames <- vector("character", length = sum(vectColNames))

#Index starting in 1, used to fill out filteredColNames vector
i <- 1

#FOR statements used to fill out filteredColNames vector
for( j in 1:561){
        if(vectColNames[j]){
                filteredColNames[i] <- as.character(features[j,2])
                i <- i + 1
        }
        
}

#Extracting the measurements on the mean and SD.
extData <- data[c("subject", "activity", filteredColNames)]


#**********************************************************************************************
# 3. Uses descriptive activity names to name the activities in the data set
#**********************************************************************************************

#Changing activities code for name 
data$activity[which(data$activity == 1)] <- "Walking"
data$activity[which(data$activity == 2)] <- "Walking upstairs"
data$activity[which(data$activity == 3)] <- "Walking downstairs"
data$activity[which(data$activity == 4)] <- "Sitting"
data$activity[which(data$activity == 5)] <- "Standing"
data$activity[which(data$activity == 6)] <- "Laying"

#Making sure if all was filled out.
unique(data[2])

#**********************************************************************************************
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
#**********************************************************************************************

#Create sumdata data.frame object with first interation
sumdata <- aggregate(data[,3] ~ subject + activity, data = data, FUN = 'mean')

#Calculate mean for rest columns
for (i in 4:ncol(data)) {
        sumdata[,i] <- aggregate(data[,i] ~ subject + activity, data = data, FUN = 'mean')[,3]
}

#Rename columns in sumdata object
colnames(sumdata) <- colnames(data)

#Create tidy data file
write.table(sumdata, 'tidydata.txt', row.names = FALSE)
