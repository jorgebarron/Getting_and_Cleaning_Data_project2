
library(dplyr)

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")
subject_train.txt <- read.table("train/subject_train.txt")
X_train.txt <- read.table("train/X_train.txt")
y_train.txt <- read.table("train/y_train.txt")
subject_test.txt <- read.table("test/subject_test.txt")
X_test.txt <- read.table("test/X_test.txt")
y_test.txt <- read.table("test/y_test.txt")
# add train and test data together
Xdata <- rbind(X_train.txt, X_test.txt)
ydata <- rbind(y_train.txt, y_test.txt)
Xydata <- cbind(Xdata, ydata)

# add subject data
subjectdata <- rbind(subject_train.txt, subject_test.txt)
Xysubjectdata <- cbind(Xydata, subjectdata)

# convert features class to character
features$V2 <- as.character(features$V2)

#tidyDataSet <- group_by(Xysubjectdata, Subject, Activity) %>%  summarise_each(funs(mean))

# insert names to columns
varNames <- c(features[,2], "Subject", "Activity")
names(Xysubjectdata) <- varNames

mean <- grep("mean", names(Xysubjectdata), ignore.case = TRUE)
str <- grep("std", names(Xysubjectdata), ignore.case = TRUE)
MeanStr <- c(mean, str, 562, 563)

# Select data: mean and str columns
Xysubjectdata <- Xysubjectdata[, MeanStr]

# data set with the average of each variable for each activity and each subject
tidyDataSet <- group_by(Xysubjectdata, Subject, Activity) %>% arrange(Subject, Activity) %>% summarise_each(funs(mean))

# write data set 
write.table(tidyDataSet, file = "tidyDataSet.txt", row.name=FALSE)





