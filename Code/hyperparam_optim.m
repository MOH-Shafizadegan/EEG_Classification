clc; clear; close all;

addpath('./Functions')

%% Load Data in feature space

Trainlabels = load('../Data/Project_data.mat').TrainLabels;
Train_data = load('../Data/Train_feature_space.mat').Train_feature_space;
Test_data = load('../Data/Test_feature_space.mat').Test_feature_space;

%%
clc;

n_feature = 50;
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

%%
clc;

k=5;
best_acc = 0;
best_model = [];
for sigma=0.1:0.2:1
   for n_hidden = 50:5:100
       [RBF_net, ~, RBF_accuracy] = train_RBF(n_hidden, sigma, ...
           Train_data.all(:, round(bestFeatureIndicies)), Trainlabels, k);
       if RBF_accuracy > best_acc
          best_acc = RBF_accuracy;
          bestmodel = [RBF_net];
          disp(sigma)
       end
   end
end

%%

% Set up PSO parameters
RBF_options = optimoptions('particleswarm', 'SwarmSize', 50, 'MaxIterations', 100);

% Define the objective function handle with extra parameters (X, k)
RBF_objectiveFunction = @(model_param) RBF_calc_Acc(Train_data.all, model_param, Trainlabels, bestFeatureIndicies);

% Run PSO to find cluster centroids
RBF_numVariables = 2;
RBF_lb = [0.5, 1];
RBF_ub = [5, 1000];

[bestModelParam, RBF_cost] = particleswarm(RBF_objectiveFunction, RBF_numVariables, RBF_lb, RBF_ub, RBF_options);


%%
clc;

n_hidden = 538;
sigma = 0.53;
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

function out = RBF_calc_Acc(data, model_param, Trainlabels, bestFeatureIndicies)

    sigma = model_param(1)
    n_hidden = round(model_param(2))
    
    k = 5;
    [~, ~, RBF_accuracy] = train_RBF(n_hidden, sigma, ...
           data(:, round(bestFeatureIndicies)), Trainlabels, k);

    out = 1/RBF_accuracy;

end
