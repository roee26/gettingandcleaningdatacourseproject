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
