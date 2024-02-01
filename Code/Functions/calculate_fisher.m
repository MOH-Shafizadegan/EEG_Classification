function fisher = calculate_fisher(X, X1, X2)

    % Calculate class means
    mu_0 = mean(X);
    mu_1 = mean(X1);
    mu_2 = mean(X2);
    
    % Calculate class variances
    var_1 = var(X1);
    var_2 = var(X2);

    % Calculate Fisher score
    fisher = ((mu_0 - mu_1).^2 + (mu_0 - mu_2).^2) ./ (var_1 + var_2);
    
end
