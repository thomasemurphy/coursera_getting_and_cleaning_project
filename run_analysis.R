library(dplyr)

# createDataFrame makes either a train or test dataframe based on user input.
# the first column is the subject, the second column is the activity number,
# and the remaining columns are the measurements
createDataFrame <- function(directory, train_or_test){
  features <- read.table(paste0(directory,"/features.txt"))[,2]
  activity <- read.table(paste0(directory,"/",train_or_test,"/","y_",train_or_test,".txt"), col.names=c("activity"))
  X <- read.table(paste0(directory,"/",train_or_test,"/","X_",train_or_test,".txt"))
  subject <- read.table(paste0(directory,"/",train_or_test,"/","subject_",train_or_test,".txt"), col.names=c("subject"))
  names(X) <- features
  which_set <- rep(train_or_test, nrow(X))
  X <- cbind(which_set, subject, activity, X)
  X
}

assignActivityLabel <- function(activity_labels, activity_number){
  activity_labels$V2[activity_number]
}

# make train and test dataframes
data_directory <- "UCI HAR Dataset"
df_train <- createDataFrame(data_directory, "train")
df_test <- createDataFrame(data_directory, "test")

# merge the dataframes
df_all <- rbind(df_train, df_test)

rm(df_train)
rm(df_test)

# make unique names for columns
df_all <- setNames(df_all, make.names(names(df_all), unique = TRUE))
df_all <- select(df_all, activity, subject, which_set, matches("std|mean", ignore.case=TRUE))

# assign activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
df_all$activity <- sapply(df_all$activity, assignActivityLabel, activity_labels=activity_labels)

# make the tidy data set consisting of the average value of each column for each subject/activity pair
df_tidy <- df_all %>% group_by(activity, subject, which_set) %>% 
  summarize_all(mean) %>% select(subject, activity, everything())

# write tidy data to file
write.table(df_tidy, file="tidy_data.txt", row.names=FALSE)

