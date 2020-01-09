# coursera_getting_and_cleaning_project
Files for the course project for the Getting and Cleaning Data course of the Coursera Data Science Specialization

The R script run_analysis.R loads and then manipulates the Human Activity Recognition Using Smartphones Dataset by Reyes-Ortiz et al. according to the instructions in the Coursera Getting and Cleaning Data course project.

The script should be run from a directory that also contains the "UCI HAR Dataset" directory.

First, the script creates the training data frame and the test data frame using the custom function createDataFrame(). The createDataFrame() function uses the read.table() function to make a data frame for which each row is a subject (a person) and each column is a smartphone accelerometer/gyroscope value for that subject performing one of six activities.

The script then combines the training data frame and the test data frame as per the course project instructions.

The script then removes all columns that are not either a mean or standard deviation value, as per the course project instructions.

Then, the script s-applies the custom function assignActivityLabel to the "activity" column of the data frame to replace the activity number with the activity name (walking, running, etc.)

Finally, the script uses the dplyr library to group the data frame by unique subject/activity combinations, and calculates the mean of each value in the data frame for that subject/activity combination.

The tidy data frame is then in the workspace as df_tidy.