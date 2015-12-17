---
title: "Codebook for Human Activity Recognition Using Smartphones Data Set"
subtitle: "Version 1.0"
author: "Kathleen McLean"
date: "December 17, 2015"
output: html_document
---

# Introduction

The following data dictionary describes the variables in a secondary data set created from the Human Activity Recognition Using Smartphones Data Set, a publicly available data set found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Set Description

This dataset consists of a single space-delimited text file with average measurements by subject and activity for 30 volunteers who participated in the experiments. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist and acceleration and angular velocity measurements were recorded from the embedded accelerometer and gyroscope in the device. More details about the experiment and data processing steps can be found at the link above.

To create this secondary dataset, the original training and test data sets were combined (containing data for 70% and 30% of the volunteers, respectively). Then only measurements on the mean and standard deviation for each measurement were kept. 

# List of Variables and Definitions

**Subject**
Unique identifier for each subject (a number from 1-30).

**Activity**
The activity performed by the subject (one of WALKING, WALKING\_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING).

**Measurement**
The type of measurement, as either the mean or standard deviation (std) estimated from the original signals. There are several different options for the type of measurement:

* The measurements come from the accelerometer or gyroscope.
* Measurements are time domain signals or Fast Fourier Transformed signals. 
* The acceleration signals were separated into body and gravity acceleration signals. 
* The body linear acceleration and angular velocity were derived in time to obtain Jerk signals. 
* The magnitude of these three-dimensional signals were calculated using the Euclidean norm.
* Signals are in the X, Y or Z axial directions. 

These options are reflected in the character strings contained in the Measurement variable. 

**AverageValue**
This is the value of each measurement, averaged for each subject and activity. 
