function [J1, J2, J3] = calc_J_scores(X, X1, X2)

    % Calculate class means
    mu_1 = mean(X1, 1);
    mu_2 = mean(X2, 1);
    mu_0 = mean(X, 1);

    % Calculate between-class scatter matrix (S_b)
    S_b = (mu_1 - mu_0).' * (mu_1 - mu_0) + ...
          (mu_2 - mu_0).' * (mu_2 - mu_0);

    % Calculate within-class scatter matrices (S1 and S2)
    S1 = 1/size(X1, 1) * (X1 - mu_1).' * (X1 - mu_1);
    S2 = 1/size(X2, 1) * (X2 - mu_2).' * (X2 - mu_2);

    % Calculate within-class scatter matrix (S_w)
    S_w = S1 + S2;
    
    % Calculate J scores
    J1 = trace(S_b) / trace(S_w);
    J2 = det(S_b) / det(S_w);
    J3 = (mu_1' - mu_2').' * inv(S_w) * (mu_1' - mu_2');

end