function [selected_features, J1_sortedIndices, featureScores] = select_feature_Jscores(data, n_feature, n_comb, labels)
    fields = fieldnames(data);
    numFields = numel(fields);
    
    All_features = [];
    for i=1:numFields
        featureName = fields{i};
        featureValue = data.(featureName);
        All_features = [All_features featureValue];
    end
        
    % Initialize struct to store feature names and Fisher scores
    featureScores = struct('combination', zeros(n_comb, n_feature), ...
                           'J1Score', zeros(1, n_comb), ...
                           'J2Score', zeros(1, n_comb), ...
                           'J3Score', zeros(1, n_comb));
    
    for i = 1:n_comb
       
        random_features = randperm(size(All_features, 2));
        currentCombination = random_features(:, 1:n_feature);
    
        % Extract the corresponding columns from the matrix
        selectedFeatureSpace = All_features(:, currentCombination); 
        class1 = selectedFeatureSpace(labels == -1, :);
        class2 = selectedFeatureSpace(labels == 1, :);
        
        [J1, J2, J3] = calc_J_scores(selectedFeatureSpace, class1, class2);
        featureScores.combination(i,:) = random_features(1:n_feature);
        featureScores.J1Score(i) = J1;
        featureScores.J2Score(i) = J2;
        featureScores.J3Score(i) = J3;
        
        fprintf("Step %d / %d ... \n", i, n_comb);

    end
    
    [~, J1_sortedIndices] = sort(featureScores.J1Score, 'descend');
    selected_features = All_features(:, featureScores.combination(J1_sortedIndices(1), :));
    
end