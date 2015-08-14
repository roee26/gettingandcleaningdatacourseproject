# gettingandcleaningdatacourseproject
Course project for coursera's Getting and Cleaning Data

## Files
* README.md
* codebook.md
* run_analysis.R

## Dataset
The dataset the script is based on is 'Human Activity Recognition Using Smartphones Dataset' downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Running the script
The script run_analysis.R assumes the data has been downloaded and the 'UCI HAR Dataset' folder is in the working directory.
The output of the script will be a new dataset based on the files from the 'UCI HAR Dataset'. It will be a single txt file containing the average of each variable for each activity and each subject in the dataset.

The file can be loaded back using the command:

~~~{r}
data <- read.table('SubjectActionMeanOfMeasure.txt', header = TRUE)
~~~

## Script analysis steps
1. The original dataset is divided into two groups of files that are identical in structure: test data and training data. The script merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. The activity names for each row is located in a separate file as codes from 1 to 6. The script translate the codes to the meaningful activity names found in the file activity_labels.txt and adds the descriptive activity names to the data set. This step also adds the subject column that identifies each individual participant in the experiment using a number from 1 - 30, located in a separate files y_train.txt and y_test.txt
4. Appropriately labels the data set with descriptive variable names using several steps to delete characters like parenthesis and dots, and then replace abbreviations with the actual word.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
