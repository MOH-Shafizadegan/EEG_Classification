function selected_fearue_space = select_features_using_fisherScore(data, fisherScores, n)
    % Create an empty struct to store the selected rows
    selected_fearue_space = [];
    
    % Iterate over the fields of the input struct
    fields = fieldnames(data);
    for i = 1:numel(fields)
        fieldName = fields{i};
        
        % Retrieve the 2D array from the input struct
        array2D = data.(fieldName);
        
        % Select the desired rows based on the given indices
        Indices = fisherScores(i).sortedIndices(1:n);
        selectedCols = array2D(:, Indices);
        
        % Store the selected rows in the new struct
        selected_fearue_space = [selected_fearue_space selectedCols];
    end
end