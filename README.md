The function requires plyr package


addSuffix - creates a suffix, used in the finaldataheaders to add ".mean"

First step is to get the data. The assumption is that "UCI HAR Dataset" folder is in the working directory. Get data files X_test.txt and Y_test.txt and subject_test.txt from both "test" and "train" subfolders into one file. 

activitylabels - Creates activity labels to be used in the sensordatameanstd to name the activities in the dataset.

featurelabels - get the features labels from the features.txt

1. merge the training and test datasets 
2. extract measurements on the mean and standard deviation
3. name the activities in the dataset (uses activitylabels)
4. label the dataset with the descriptive names (uses addSuffix)
5. create a tidy dataset with the average of each variable for each activity and each subject. 
