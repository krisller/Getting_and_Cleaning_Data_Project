# Getting and Cleaning Data Course
##Final Project by Rafael Krisller

The R script (run_analysis.R) consist in five steps:

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set.
  4. Appropriately labels the data set with descriptive variable names. 
  5. Creates an independent tidy data set with the average of each variable for each activity and each subject.

In first step, the training and the test data files were read and combined in a new R object. The second step, the columns with mean and standard deviation were extracted in a new R object. The third step, the activities codes were changed to its description. The fourth step, the columns original names were changed with its descriptive variable names. And finally, in the fifth step a new data frame object was created to store the average of each variable for each activity and each subject. So, the file was created with "write.table" command.

All this steps were commented in the "run_analysis.R" file.
