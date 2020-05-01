# Getting-data-Course-project

This project includes a R script, run_analysis.R, that makes all the following:

Download the dataset from web if it does not already exist in my working directory.

Read both the train and test datasets and merge them into x(measurements), y(activity) and subject, respectively.

Load the data feature, activity info and extract columns named "mean" and "standard_dev". 

Also, modify column names to descriptive.

Extract data by selected columns, and merge x, y(activity) and subject data. 

Replace y(activity) column to it's name by refering activity label.

Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. 

The result is shown in the file tidy_data.txt.
