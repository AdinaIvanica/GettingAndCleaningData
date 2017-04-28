The dataset includes the following files:
=========================================
-	'features_info.txt': Shows information about the variables used on the feature vector.
-	'features.txt': List of all features.
-	'activity_labels.txt': Links the class labels with their activity name.
-	'train/X_train.txt': Training set.
-	'train/y_train.txt': Training labels/activities corresponding to X_train.txt.
-	'test/X_test.txt': Test set.
-	'test/y_test.txt': Test labels/activities corresponding to X_test.txt.
-	subject_train.txt contains information on the subjects from whom data is collected. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Variables:
=========================================
-	activity_labels.txt is read into table activity_labels
-	features.txt is read into table features
-	subject_train.txt is read into table subject_train
-	X_train.txt is read into table x_train
-	y_train.txt is read into table y_train
-	subject_test.txt is read into table subject_test
-	X_test.txt is read into table x_test
-	y_test.txt is read into table y_test
-	train_data contains the merged training data
-	test_data contains the merged test data
-	final_data contains the merged training data (train_data) and tast data (test_data)
-	data_mean_std is a dataset containing the mean and standard deviation for each measurement in the final_data set; descriptive activity and variables names define data_mean_std
-	tidy_data_average  is a tidy data set with the average of each variable for each activity and each subject
