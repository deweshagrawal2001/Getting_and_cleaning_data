library(dplyr)
features <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\features.txt")
activities <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\activity_labels.txt")
subject_test <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\test\\subject_test.txt")
X_test <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\test\\y_test.txt")
subject_train <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\train\\subject_train.txt")
X_train <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("C:\\Users\\dewes\\OneDrive\\Desktop\\probabilitylabs\\UCI HAR Dataset\\train\\y_train.txt")
#Qno.01
X  <- cbind(subject_test, y_test, X_test)
Y <- cbind(subject_train, y_train, X_train)
fullset <- rbind (X,Y)

#Qno.02
allNames <- c("subject", "activity", as.character(features$V2))
meanStdColumns <- grep("subject|activity|[Mm]ean|std", allNames, value = FALSE)
reducedSet <- fullset[ ,meanStdColumns]

#Qno.03
names(activities) <- c("activityNumber", "activityName")
reducedSet$V1.1 <- activities$activityName[reducedSet$V1.1]

#Qno.04
reducedNames <- allNames[meanStdColumns]    # Names after subsetting
reducedNames <- gsub("mean", "Mean", reducedNames)
reducedNames <- gsub("std", "Std", reducedNames)
reducedNames <- gsub("gravity", "Gravity", reducedNames)
reducedNames <- gsub("[[:punct:]]", "", reducedNames)
reducedNames <- gsub("^t", "time", reducedNames)
reducedNames <- gsub("^f", "frequency", reducedNames)
reducedNames <- gsub("^anglet", "angleTime", reducedNames)
names(reducedSet) <- reducedNames

#Qno.05
tidyDataset <- reducedSet %>%
  group_by(activity, subject) %>% 
  summarise_all(funs(mean))

write.table(tidyDataset, file = "tidyDataset.txt", row.names = FALSE)
