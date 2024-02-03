clc; clear; close all;

addpath('./Functions')

%% Load Data in feature space

Trainlabels = load('../Data/Project_data.mat').TrainLabels;
Train_data = load('../Data/Train_feature_space.mat').Train_feature_space;
Test_data = load('../Data/Test_feature_space.mat').Test_feature_space;

%% Feature selection using Fisher

featureScores = select_feature_fisher(Train_data, Trainlabels);

%% Feature selection regarding all features
clc;

n_feature = 100;
train_indicies = featureScores(10).sortedIndices(1:n_feature);
selected_feature_space = Train_data.all(:, train_indicies);

%% MLP model

clc;
n_hidden = 30;
k = 5;
[MLP_net, avgMSE, accuracy] = train_MLP(n_hidden, selected_feature_space, Trainlabels, k);

%% RBF

clc;

n_hidden = 1000;
sigma = 0.5;
k = 5;
[RBF_net, RBF_avgMSE, RBF_accuracy] = train_RBF(n_hidden, sigma, selected_feature_space, Trainlabels, k);
