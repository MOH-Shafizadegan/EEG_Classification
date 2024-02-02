clear; clc; close all;

%% Importing functions

addpath('./Functions')

%% loading data

data = load('../Data/Project_data.mat');
TestData = data.TestData;
TrainData = data.TrainData;
TrainLabels = data.TrainLabels;
fs = data.fs;

%% Mapping data onto feaeture space
clc;

BP_feature = calc_featuer_band_power(TrainData, fs);

%%
clc;

n_bins = 5;
amp_range = [-10, 10];
Amp_hist__feature = calc_feature_amp_hist(TrainData, n_bins, amp_range);

%%
clc;

order = 4;
AR_Coef_feature = calc_feature_AR_Coef(TrainData, order);

%%
clc;

corr_feature = calc_feature_corr(TrainData);

%%
clc;

FF_feature = calc_feature_FF(TrainData);

%%
clc;
m
max_freq_feature = calc_feature_max_freq(TrainData, fs);

%%
clc;

mean_freq_feature = calc_feature_mean_freq(TrainData, fs);

%%
clc;

med_freq_feature = calc_feature_med_freq(TrainData, fs);

%%

var_feature = calc_feature_var(TrainData);

%%
clc;

n_bins = 5;
amp_range = [-10, 10];
order = 4;
Train_feature_space = create_all_feature_space(TrainData, fs, n_bins, amp_range, order);

%%
clc;

featureScores = select_feature_fisher(Train_feature_space, TrainLabels);

%%
clc;

n=10;
selected_feature_space = ...
    select_features_using_fisherScore(Train_feature_space, featureScores, n);

