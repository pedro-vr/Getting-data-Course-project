# Getting-data-Course-project

This project includes the R script "run_analysis.R" that makes all the following:

* Download the dataset from web if it doesn't exist in my working directory.

* Read both the train and test datasets and merge them into one for each name: x(measurements), y(activity) and subject

* Load the data feature, activity info and extract columns named "mean" and "standard_dev". 

* Modify column names to descriptive labels.

* Extract data by selected columns, and merge x, y(activity) and subject data. 

* Replace y(activity) column to it's name by refering activity label.

* And finally, generate the tidy dataset that consists of the average of each variable for each subject and each activity. 

The final result is saved in a text file named "tidy_data.txt".
