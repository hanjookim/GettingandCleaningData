About the raw data
------------------

The features (561 of them) are unlabeled and can be found in the x_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The same holds for the training set.

About the script and the tidy dataset
-------------------------------------
The script, run_analysis.R, will merge the test and training sets together.
Prerequisites for this script:

1. The UCI HAR Dataset must be extracted and
2. The UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"

After merging testing and training, labels are added and only columns that have to do with mean and standard deviation are kept.

The script will create a tidy data set containing the means of all the columns per test subject and per activity.
This tidy dataset will be written to a tab-delimited file called tidydata.txt, which can also be found in this repository.

About the Code Book
-------------------
The codeBook.md file explains the resulting data and variables.
