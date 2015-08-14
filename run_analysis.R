# source("run_analysis.R")

#----------------------------------------------------------------------
# Merge the training and the test sets to create one data set.
#----------------------------------------------------------------------
# the files have 561 columns of fixed width of 16 chars
wid<- rep(16,561)

# Reducing buffer size to prevent memory limit error (default 2000 lines)
test  <- read.fwf("UCI HAR Dataset/test/X_test.txt"  , header = FALSE, widths = wid, buffersize = 100)
train <- read.fwf("UCI HAR Dataset/train/X_train.txt", header = FALSE, widths = wid, buffersize = 100)

merge <- rbind(test,train)

# getting subject data
subjects <- rbind(read.table("UCI HAR Dataset/test/subject_test.txt"),read.table("UCI HAR Dataset/train/subject_train.txt"))

remove('test','train','wid')

#----------------------------------------------------------------------
# Extract only the measurements on the mean and standard deviation for each measurement. 
#----------------------------------------------------------------------
# Getting the measurments names
headers <- read.table("UCI HAR Dataset/features.txt", header = FALSE, sep="\t")
matches <- grep("mean|std",headers[,1], ignore.case = TRUE)
# getting only the columns that have mean or std in them
df <-merge[,grep("mean|std",headers[,1], ignore.case = TRUE)]
headers <- as.character(headers[matches,])
remove('matches', 'merge')

#----------------------------------------------------------------------
# Uses descriptive activity names to name the activities in the data set
#----------------------------------------------------------------------
# adding activity name as the first column
activity_test  <- read.table("UCI HAR Dataset/test/y_test.txt"  , header = FALSE)
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
activity_code <- rbind(activity_test,activity_train)
remove('activity_test','activity_train')
# 1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS, 4 SITTING, 5 STANDING, 6 LAYING
activity_dic <- c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING','STANDING','LAYING')
df <- cbind(activity_dic[activity_code[,1]],df)
df <- cbind(subjects,df)
remove('activity_code','activity_dic','subjects')

#----------------------------------------------------------------------
# Appropriately labels the data set with descriptive variable names.
#----------------------------------------------------------------------
headers <- gsub("[[:digit:]]+ (.+)","\\1",headers) # removing literal numbers in teh beginning
headers <- make.names(headers)
headers <- gsub("\\.{2,}",".",headers)             # consolidating dots to a singel dot
headers <- gsub("BodyBody","Body",headers) 
headers <- gsub("Acc","Accelerometer",headers)
headers <- gsub("Gyro","Gyroscope",headers)
headers <- gsub("Mag","Magnitude",headers)
headers <- gsub("gravity","Gravity",headers)
headers <- gsub("mean","Mean",headers)
headers <- gsub("std","StandardDev",headers)
headers <- gsub("^t","time",headers)               # t denotes time
headers <- gsub("^f","frequency",headers)          # f denotes frequency
headers <- gsub("\\.","",headers)                  # eliminating the dots, leaving camel case

headers <- c("subject","action",headers)
names(df) <- headers
remove(headers)
#-----------------------------------------------------------------------------------------------------------------------
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#-----------------------------------------------------------------------------------------------------------------------
# using aggregate function with dot notation to get mean of every measure by subject and action
# note: the dot notation take all columns that do not participate in the grouping elements mentioned after the ~
df2 <- aggregate(. ~ subject + action, data=df, FUN = mean)
df2 <- df2[order(df2$subject,df2$action),] 

write.table(df2,"SubjectActionMeanOfMeasure.txt",row.names = FALSE)

# read the table using: data <- read.table('SubjectActionMeanOfMeasure.txt', header = TRUE) 

