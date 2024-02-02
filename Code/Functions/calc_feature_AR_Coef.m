function AR_coef = calc_feature_AR_Coef(data, order)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    
    AR_coef = zeros(n_trials, n_channels, order+1);
    
    for i=1:n_trials
       for j=1:n_channels
           AR_coef(i,j,:) = ar(data(j,:,i), order).A;
       end
       fprintf("Step %d / %d ... \n", i, n_trials);
    end
    
    AR_coef = reshape(AR_coef, n_trials, []);

end