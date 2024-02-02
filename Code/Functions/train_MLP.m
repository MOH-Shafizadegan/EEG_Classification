function [net, avgMSE, accuracy] = train_MLP(n_hidden, trainX, trainY, k)
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
        net = fitnet(n_hidden, 'trainlm');

        % Set the training parameters
        net.trainParam.showWindow = false;  % Disable training window display
        net.divideParam.trainRatio = 100/100;
        net.divideParam.testRatio = 0/100;
        net.divideParam.valRatio = 0/100;

        % Train the MLP model
        net = train(net, foldTrainX', foldTrainY);

        % Make predictions on the validation sets
        valPred = net(foldValX');

        % Calculate the MSE for the validation set
        foldMSE(fold) = mean((valPred - foldValY).^2);
        
        foldAccuracy(fold) = sum(round(valPred) == foldValY) / numel(foldValY);

        fprintf("Step %d / %d ... \n", fold, k)
    end
    
    % Calculate the average MSE across folds
    avgMSE = mean(foldMSE);
    accuracy = mean(foldAccuracy);

end