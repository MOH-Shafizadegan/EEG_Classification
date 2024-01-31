function cov_mat = calc_feature_corr(data)

    n_trials = size(data, 3);
    n_channels = size(data, 0);
    
    cov_mat = zeros(n_channels, n_channels, n_trials);
    
    for i=1:n_trials
       for j=1:n_channels
           for k=1:n_channels
              data1 = data(j,:,i);
              data2 = data(k,:,i);
              covariance = cov(data1, data2);
              cov_mat(j,k,i) = covariance(1,2);
           end
       end
    end

end