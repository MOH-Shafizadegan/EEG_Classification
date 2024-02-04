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
[J1_selected_features, J1_sortedIndices, J1featureScores] = select_feature_Jscores(Train_data, n_feature, n_comb, Trainlabels);

%% MLP

clc;
hiddenLayers = [10, 20, 20, 10];
k = 5;
[MLP_net, avgMSE, accuracy] = train_MLP(hiddenLayers, J1_selected_features, Trainlabels, k);

%% Preedict test labels

indicies = round(bestFeatureIndicies);
indicies(indicies >= 4861) = 4861;
test_selected_feature_space = Test_data.all(:, indicies);
MLP_Testlabels = MLP_net(test_selected_feature_space');

% save labels

directory = '../Results/MLP_JScore';

if ~exist(directory, 'dir')
    mkdir(directory);
    disp('Directory created successfully.');
else
    disp('Directory already exists.');
end

save(strcat(directory, '/MLP_Testlabels.mat'), 'MLP_Testlabels');

%% RBF

clc;

n_hidden = 30;
sigma = 2;
k = 5;
[RBF_net, RBF_avgMSE, RBF_accuracy] = train_RBF(n_hidden, sigma, J1_selected_features, Trainlabels, k);

%% Preedict test labels

RBF_Testlabels = RBF_net(test_selected_feature_space');

% save labels

directory = '../Results/RBF_JScore';

if ~exist(directory, 'dir')
    mkdir(directory);
    disp('Directory created successfully.');
else
    disp('Directory already exists.');
end

save(strcat(directory, '/RBF_Testlabels.mat'), 'RBF_Testlabels');