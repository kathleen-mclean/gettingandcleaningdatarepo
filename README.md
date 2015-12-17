# gettingandcleaningdatarepo
Repository for Coursera Getting and Cleaning Data course

This repository includes two files pertaining to the course project: run_analysis.R and Codebook.md. 

run_analysis.R includes all code needed to produce the tidy data set as specified for this project. The script performs the following steps: 

1. Sets the working directory, loads packages and reads in the required data files using read.table
2. Combines the training and test sets to create one data set using rbind, puts the subject id numbers and activity id numbers together with the measurement data using bind_cols, and assigns column names from the features file. 
3. Removes duplicate column names and keeps only those columns with "mean(" or "std(" in the column name (in addition to the subject and activity id numbers). 
4. Merges the activity labels with the data set so that descriptive activity names are used instead of id numbers. 
5. Appropriately labels the data set with descriptive variable names using rename and gsub. 
6. Transforms the data set to a long format with the following variable names: Subject, Activity, Measurement, AverageValue. The AverageValue is the mean of all measurements of the same type for the same subject and activity. 
7. Writes the data set to a .txt file. 

Codebook.md describes the resulting dataset and the variables included. 
