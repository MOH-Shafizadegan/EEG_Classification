clc; clear; close all;

addpath('./Functions')

%% Load Data in feature space

Trainlabels = load('../Data/Project_data.mat').TrainLabels;
Train_data = load('../Data/Train_feature_space.mat').Train_feature_space;
Test_data = load('../Data/Test_feature_space.mat').Test_feature_space;

%%
clc;

n_feature = 200;
n_comb = 5000;
[J1_selected_features, J_featureScores] = select_feature_Jscores(Train_data, n_feature, n_comb, Trainlabels);

%% MLP

clc;
hiddenLayers = [10, 20, 20, 10];
k = 5;
[MLP_net, avgMSE, accuracy] = train_MLP(hiddenLayers, J1_selected_features, Trainlabels, k);

%% RBF

clc;

n_hidden = 30;
sigma = 2;
k = 5;
[RBF_net, RBF_avgMSE, RBF_accuracy] = train_RBF(n_hidden, sigma, J1_selected_features, Trainlabels, k);
