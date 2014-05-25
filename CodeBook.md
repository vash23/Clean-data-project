Clean-data-project
==================

Coursera: Cleaning and Obtaining Data Course Project

The script does the following to produce the new tidy data with the means of each 
measure variables for each activity and each subject

1. From the "feature.txt", all the features/variable names are extracted and from this data
   the relevant variables are extracted by searching for mean() and std() on the feature name
   and this information is used to identify the right columns and column names to use while
   reading the X_train and X_test files. The "()" and "-" are removed from variable names to 
   avoid any issues.
   
   "features" variable is the data frame for reading "feature.txt"
   "mycols" is contains the classes of the columns to be read from X_train and X_test. It was
   also used to screen out variables by setting the class to "NULL"
   
   "mycolnames" is the variable containing the variable names for the relevant mean and 
   standard deviation.
   
2. By using the information extracted from 1st step the train and test data were read to data 
   frames.
   
   "X_test" contains "X_test.txt" data
   "Y_test" contains "Y_test.txt" data
   "subject_test" contains "subject_test.txt"
   "X_train" contains "X_train.txt" data
   "Y_train" contains "Y_train.txt" data
   "subject_train" contains "subject_train.txt"
   
3. Next step is to use the "join" function "plyr" library to apply the descriptive activity name
   as the Y labels. Both "Y_test.txt" and "Y_train.txt" files were joined with the "activity_name.txt"
   to extract the descriptive activity names.
   
   "activity_label" contains "activity_label.txt"
   
4. After preparing the data, test and train data were combined together using rbind and cbind.

   "merge_subjects" contains merged "subject_test" and "subject_train" data.
   "merge_labels" contains merged "Y_train" and "Y_test" data
   "merge_data" merged all "X_train", "X_train", "merge_subjects" and "merge_labels"

5. To compute the mean of each activity for each subject, the merged data was melted and mean was 
   computed using dcast.
   
   "melt_merge" melts the merged data for computing the mean.
   "mean_data" computes the mean from "melt_merge"
   
6. Data is then written to "mean_data.txt" using write.fwf.
