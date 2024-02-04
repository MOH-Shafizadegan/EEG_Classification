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
hiddenLayers = [10, 20, 10];
k = 5;
[MLP_net, avgMSE, accuracy] = train_MLP(hiddenLayers, selected_feature_space, Trainlabels, k);

%% Results
clc;

fprintf("Accuracy for MLP network with %f hidden neurons:", accuracy)

%% Preedict test labels

test_selected_feature_space = Test_data.all(:, train_indicies);
Testlabels = MLP_net(test_selected_feature_space');

% save labels

directory = '../Results/MLP_fisher';

if ~exist(directory, 'dir')
    mkdir(directory);
    disp('Directory created successfully.');
else
    disp('Directory already exists.');
end

save(strcat(directory, '/Testlabels.mat'), 'Testlabels');

%% RBF

clc;

n_hidden = 500;
sigma = 1;
k = 5;
[RBF_net, RBF_avgMSE, RBF_accuracy] = train_RBF(n_hidden, sigma, selected_feature_space, Trainlabels, k);

%% Preedict test labels

test_selected_feature_space = Test_data.all(:, train_indicies);
RBF_Testlabels = RBF_net(test_selected_feature_space');

% save labels

directory = '../Results/RBF_fisher';

if ~exist(directory, 'dir')
    mkdir(directory);
    disp('Directory created successfully.');
else
    disp('Directory already exists.');
end

save(strcat(directory, '/RBF_Testlabels.mat'), 'RBF_Testlabels');