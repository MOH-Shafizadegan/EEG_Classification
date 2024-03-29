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

n=30;
selected_feature_space = ...
    select_features_using_fisherScore(Train_feature_space, featureScores, n);

%% Train MLP model
clc;

n_hidden = 40;
k = 5;
[MLP_net, avgMSE, accuracy] = train_MLP(n_hidden, selected_feature_space, TrainLabels, k);

%%

clc;

n_hidden = 2000;
sigma = 0.5;
k = 5;
[RBF_net, RBF_avgMSE, RBF_accuracy] = train_RBF(n_hidden, sigma, selected_feature_space, TrainLabels, k);

%%
clc;

n_feature = 20;
n_comb = 1000;
[J1_selected_features, J_featureScores] = select_feature_Jscores(Train_feature_space, n_feature, n_comb, TrainLabels);

%%

%% Train MLP model
clc;

n_hidden = 30;
k = 5;
[MLP_net_2, avgMSE_2, accuracy_2] = train_MLP(n_hidden, J1_selected_features, TrainLabels, k);



%%
clc;

n_feature = 100;
max_feature_num = 5643;

% Set up PSO parameters
options = optimoptions('particleswarm', 'SwarmSize', 50, 'MaxIterations', 100);

% Define the objective function handle with extra parameters (X, k)
objectiveFunction = @(feaure_indicies) PSO_calc_Jscore(Train_feature_space.all, feaure_indicies, TrainLabels);

% Run PSO to find cluster centroids
numVariables = n_feature;
lb = repelem(1, n_feature);
ub = repelem(max_feature_num, n_feature);

[bestFeatureIndicies, cost] = particleswarm(objectiveFunction, numVariables, lb, ub, options);

%%
clc;

n_hidden = 10;
sigma = 0.5;
k = 5;
[RBF_net_2, RBF_avgMSE_2, RBF_accuracy_2] = train_RBF(n_hidden, sigma, ...
           Train_feature_space.all(:, round(bestFeatureIndicies)), TrainLabels, k);

%%
function JScore = PSO_calc_Jscore(data, feature_Indicies, labels)

    feature_Indicies = round(feature_Indicies);
    cols = zeros(1, size(data,2));
%     cols(feature_Indicies) = 1;
%     disp(cols);
    % Extract the corresponding columns from the matrix
    selectedFeatureSpace = data(:, feature_Indicies); 
    class1 = selectedFeatureSpace(labels == -1, :);
    class2 = selectedFeatureSpace(labels == 1, :);
        
    [JScore, ~, ~] = calc_J_scores(selectedFeatureSpace, class1, class2);
    
    JScore = 1/JScore;

end
