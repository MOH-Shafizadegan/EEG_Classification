function [net, avgMSE, accuracy] = train_RBF(n_hidden, sigma, trainX, trainY, k)
    % Initialize array to store MSE for each fold
    foldMSE = zeros(1, k);
    foldAccuracy = zeros(1, k);

    % Perform k-fold cross-validation
    cv = cvpartition(size(trainX, 1), 'KFold', k);
    for fold = 1:k
        % Get the indices for the current fold
        trainIndices = cv.training(fold);
        valIndices = cv.test(fold);
        
        % Get the training and validation sets for the current fold
        foldTrainX = trainX(trainIndices, :);
        foldValX = trainX(valIndices, :);
        foldTrainY = trainY(trainIndices);
        foldValY = trainY(valIndices);
        
        % Create the MLP model
        net = newrb(foldTrainX', foldTrainY, 0, sigma, n_hidden);

        % Make predictions on the validation sets
        valPred = net(foldValX');
        valPred(valPred >= 0) = 1;
        valPred(valPred < 0) = -1;

        % Calculate the MSE for the validation set
        foldMSE(fold) = mean((valPred - foldValY).^2);
                
        foldAccuracy(fold) = sum(valPred == foldValY) / numel(foldValY)

        fprintf("Step %d / %d ... \n", fold, k)
    end
    
    % Calculate the average MSE across folds
    avgMSE = mean(foldMSE);
    accuracy = mean(foldAccuracy);

end