function featureScores = select_feature_fisher(data, labels)
    fields = fieldnames(data);
    numFields = numel(fields);
    
    % Initialize struct to store feature names and Fisher scores
    featureScores = struct('featureName', cell(1, numFields), 'fisherScore', zeros(1, numFields));
    
    for i = 1:numFields
        featureName = fields{i};
        featureValue = data.(featureName);
        
        % Calculate Fisher score for each column of the featureValue matrix
        fisherScores = zeros(1, size(featureValue, 2));
        for j = 1:size(featureValue, 2)
            column = featureValue(:, j);
            class1 = column(labels == -1);
            class2 = column(labels == 1);
            fisherScores(j) = calculate_fisher(class1, class2, column);
        end
        
        % Store feature name and Fisher scores in the struct
        featureScores(i).featureName = featureName;
        fisherScores(isnan(fisherScores)) = 0;
        featureScores(i).fisherScore = fisherScores;
        
%         featureScores(i).fisherScore(isnan(featureScores(i).fisherScore)) = 0;

        % Sort the Fisher scores within each category (field)
        [~, sortedIndices] = sort(fisherScores, 'descend');
        featureScores(i).fisherScore = fisherScores(sortedIndices);
        featureScores(i).sortedIndices = sortedIndices;

        % Display the field name
        disp(['Field name: ', featureName]);
    end
    
end