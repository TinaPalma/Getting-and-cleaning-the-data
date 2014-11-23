#You should create one R script called run_analysis.R that does the following. 
run_analysis <-function()
{
  # Read all dataset into Data frames using read.table
  print("Reading table ...")
  features<-read.table("./UCI HAR Dataset/features.txt")
  activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
  
  X_test = read.table("./UCI HAR Dataset/test/X_test.txt", col.names= features[,2])
  X_train<-read.table("./UCI HAR Dataset/train/X_train.txt", col.names= features[,2])
  
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activity")) 
  y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))
  
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
  subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
  
  
  #1.Merges the training, the test and subjects sets to create one data set and rename dataset's column names
  print("Merging dataset...")
  Test <- cbind(subject_test,y_test,X_test) 
  Train <- cbind(subject_train,y_train,X_train)


  #2. Subset and extracts only the measurements on the mean and standard deviation for each measurement
  print("Subsetting by mean and std ...")
  Test_mean_std <-Test[, grepl("mean\\(\\)|std\\(\\)", names(Test))]
  
  #3. Appropriately labels the data set with descriptive variable names.
  print("Renaming activity's labels ...")
  Test$activity <-activity_labels[Test[,2],2] 
  Train$activity <-activity_labels[Train[,2],2]
  
  #5. Duplicate the data and average of each variable for each activity and each subject
  # Join the data.
  print ("Joining datasets ...")
  all_data <- rbind(Test, Train)
  
  #5.1 Reshape the data.
  print ("Melting ...")
  library("reshape")
  all_data_melt <- melt(all_data, id = c("subject", "activity"))
  
  print ("Dcasting ...")
  all_data_cast <- cast(all_data_melt, subject + activity ~ variable, mean)
  
  #5.2 Set the clean data.
  all_data_clean <-  all_data_cast
  
  #5.3 Save the clean data.
  print ("Saving the clean data ...")
  filename <- file.path(getwd(), "tidy.txt")
  write.table(all_data_clean, filename, row.names = FALSE, quote = FALSE, sep="\t")
  list(data=data, tidy=all_data_clean)
  
}



