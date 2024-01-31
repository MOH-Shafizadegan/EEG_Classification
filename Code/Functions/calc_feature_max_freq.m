function result = calc_feature_max_freq(data)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    
    result = zeros(n_channels, n_trials);
    
    for i=1:n_trial
       for j=1:n_channels
           [f, data_fft] = calc_fft(data(j,:,i));
           result(j,i) = f(data_fft == max(data_fft));
       end
    end

end