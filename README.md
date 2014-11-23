Getting-and-cleaning-the-data
=============================

1. I merges the training and the test sets to create one data set (data.table)
2. I extracted only the measurements on the mean and standard deviation for each measurement;
3. I use descriptive activity names to name the activities in the data set;
4. I labeled the data set with descriptive variable names;
5. I duplicate the data and average of each variable for each activity and each subject and I reshape the data (melt and dcast) and save the clean data in txt file nammed tidy.data
