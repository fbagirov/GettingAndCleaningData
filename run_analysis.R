require(plyr)

addSuffix<- function(x, suffix) {
  if (!(x %in% c("Subject","Activity"))) {
    paste(x,suffix, sep="")
  }
  else{
    x
  }
}

pathfile<-file.path(getwd(),"UCI HAR Dataset")

pathfiletest<-file.path(pathfile, "test")
pathfiletrain<-file.path(pathfile, "train")

xtest<-read.table(file.path(pathfiletest,"X_test.txt"))
ytest<-read.table(file.path(pathfiletest,"y_test.txt"))
subjecttest<-read.table(file.path(pathfiletest,"subject_test.txt"))

xtrain<-read.table(file.path(pathfiletrain,"X_train.txt"))
ytrain<-read.table(file.path(pathfiletrain,"y_train.txt"))
subjecttrain<-read.table(file.path(pathfiletrain,"subject_train.txt"))
 
activitylabels<-read.table(file.path(pathfile,
                                     "activity_labels.txt"),
                           col.names = c("Id", "Activity")
)

featurelabels<-read.table(file.path(pathfile,
                                    "features.txt"),
                          colClasses = c("character")
)

traindata<-cbind(cbind(xtrain, subjecttrain), ytrain)
testdata<-cbind(cbind(xtest, subjecttest), ytest)
sensordata<-rbind(traindata, testdata)

sensorlabels<-rbind(rbind(featurelabels, c(562, "Subject")), c(563, "Id"))[,2]
names(sensordata)<-sensorlabels

sensordatameanstd <- sensordata[,grepl("mean\\(\\)|std\\(\\)|Subject|Id", names(sensordata))]

sensordatameanstd <- join(sensordatameanstd, activitylabels, by = "Id", match = "first")
sensordatameanstd <- sensordatameanstd[,-1]

names(sensordatameanstd) <- gsub("([()])","",names(sensordatameanstd))
#norm names
names(sensordatameanstd) <- make.names(names(sensordatameanstd))
 
finaldata<-ddply(sensordatameanstd, c("Subject","Activity"), numcolwise(mean))
finaldataheaders<-names(finaldata)
finaldataheaders<-sapply(finaldataheaders, addSuffix, ".mean")
names(finaldata)<-finaldataheaders

write.table(finaldata, file = "sensordata_avg_by_subject.txt", row.name=FALSE)

