##prepare features so only means and std will be read from the files
features = read.table("features.txt", col.names=c("N", "feature"), 
                      colClasses=c("integer","character"))
mycols = ifelse((grepl("-mean()", features$feature, fixed=TRUE)| 
                      grepl("-std()", features$feature, fixed=TRUE))
                ,"numeric", "NULL")
mycolnames = ifelse((grepl("-mean()", features$feature, fixed=TRUE)| 
                      grepl("-std()", features$feature, fixed=TRUE))
                , features$feature, "NULL")
mycolnames = gsub("[()]","",mycolnames)
mycolnames = gsub("-","_",mycolnames)


##read data into R, extracting only means and standard deviation
##and properly label column names
subject_test= read.table("test/subject_test.txt", col.names="Subject", 
                         colClasses = "integer")
X_test=read.table("test/X_test.txt", colClasses = mycols, col.names = mycolnames)
Y_test=read.table("test/Y_test.txt", col.names="Activity_num")
subject_train= read.table("train/subject_train.txt", col.names="Subject", 
                          colClasses = "integer")
X_train=read.table("train/X_train.txt", colClasses = mycols,
                   col.names = mycolnames)
Y_train=read.table("train/Y_train.txt", col.names="Activity_num")


##load plyr lib and merge descriptive activity labels with Y data sets
library(plyr)
activity_label = read.table("activity_labels.txt", 
                            col.names=c("Activity_num", "Activity_name"), 
                            colClasses = c("factor", "factor"))
Y_test = join(Y_test, activity_label, by = "Activity_num")
Y_train = join(Y_train, activity_label, by = "Activity_num")


##merge test and train data
merge_data = rbind(X_test, X_train)
merge_subjects = rbind(subject_test, subject_train)
merge_labels = rbind(Y_test, Y_train)
merge_data = cbind(merge_subjects$Subject, merge_data, 
                    merge_labels$Activity_name)
names(merge_data)[1]="Subject"
names(merge_data)[68]="Activity_name"


##compute mean for each measure, activity and subject
mycolnames=mycolnames[which(mycolnames!="NULL")]
melt_merge=melt(merge_data, id=c("Subject","Activity_name"), 
                measure.vars=mycolnames)
mean_data = dcast(melt_merge, Subject+Activity_name ~ mycolnames, mean)

##write data 
write.fwf(mean_data, "mean_data.txt", colnames=TRUE, width=24)
