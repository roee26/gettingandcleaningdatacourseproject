# Code Book

## The input dataset
The description of the original fields in the dataset can be found in the file features_info.txt that is part of the input dataset download. The features are normalized and bounded within [-1,1] and each feature vector is a row on the text file.

This is an exerpt from the features_info.txt file:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

## The analyis script run_analysis.R

The script run_analysis.R which combines the test and the train data and selects only the fields with mean and standard deviation. The script changes the variable names to be more descriptive. The table below lists several examples of the original and the transformed variable name.

Original Header        | Descriptive Header
---------------------- | ------------------------
tBodyAcc-mean()-X      | timeBodyAccelerometerMeanX
tGravityAcc-mean()-Y   | timeGravityAccelerometerMeanY
tBodyAccJerk-mean()-Z  | timeBodyAccelerometerJerkMeanZ
tBodyGyro-std()-Y      | timeBodyGyroscopeStandardDevY
tBodyAccMag-mean()-X   | timeBodyAccelerometerMagnitudeMeanX

The output table is calculated by generating an independent data set with the average of each variable for each activity (e.g. sitting, walking) and each subject (30 different persons identified by numbers from 1 to 30). The method used to generate the data set is `aggregate(. ~ subject + action, data=df, FUN = mean)`. The dot notation in the aggregate function means apply the function (i.e. mean) to all fields except the grouping fields (subject, action).
