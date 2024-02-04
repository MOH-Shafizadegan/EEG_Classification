
clc; clear; close all;

addpath('./Functions')

%% Load Data in feature space

Trainlabels = load('../Data/Project_data.mat').TrainLabels;
Train_data = load('../Data/Train_feature_space.mat').Train_feature_space;
Test_data = load('../Data/Test_feature_space.mat').Test_feature_space;

%%
clc;

n_feature = 200;
max_feature_num = 5643;

% Set up PSO parameters
options = optimoptions('particleswarm', 'SwarmSize', 50, 'MaxIterations', 100);

% Define the objective function handle with extra parameters (X, k)
objectiveFunction = @(feaure_indicies) PSO_calc_Jscore(Train_data.all, feaure_indicies, Trainlabels);

% Run PSO to find cluster centroids
numVariables = n_feature;
lb = repelem(1, n_feature);
ub = repelem(max_feature_num, n_feature);

[bestFeatureIndicies, cost] = particleswarm(objectiveFunction, numVariables, lb, ub, options);

%% MLP

clc;
hiddenLayers = [10, 20, 10];
k = 5;
[MLP_net, avgMSE, accuracy] = train_MLP(hiddenLayers, Train_data.all(:, round(bestFeatureIndicies)), Trainlabels, k);

%% RBF
clc;

n_hidden = 30;
sigma = 2;
k = 5;
[RBF_net_2, RBF_avgMSE_2, RBF_accuracy_2] = train_RBF(n_hidden, sigma, ...
           Train_data.all(:, round(bestFeatureIndicies)), Trainlabels, k);

%%
function out = PSO_calc_Jscore(data, feature_Indicies, labels)

    feature_Indicies = round(feature_Indicies);
    selectedFeatureSpace = data(:, feature_Indicies); 
    class1 = selectedFeatureSpace(labels == -1, :);
    class2 = selectedFeatureSpace(labels == 1, :);
        
    [JScore, ~, ~] = calc_J_scores(selectedFeatureSpace, class1, class2);
    
    out = 1/JScore;

end
