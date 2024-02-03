clear; clc; close all;

addpath('./Functions')

%% loading data

data = load('../Data/Project_data.mat');
TestData = data.TestData;
TrainData = data.TrainData;
TrainLabels = data.TrainLabels;
fs = data.fs;

%% Feature Extraction

n_bins = 5;
amp_range = [-10, 10];
order = 4;

Train_feature_space = create_all_feature_space(TrainData, fs, n_bins, amp_range, order);
Test_feature_space = create_all_feature_space(TestData, fs, n_bins, amp_range, order);

%% Save data

save('../Data/Train_feature_space.mat', 'Train_feature_space');
save('../Data/Test_feature_space.mat', 'Test_feature_space');

