function result = calc_feature_max_freq(data, fs)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    
    result = zeros(n_trials, n_channels);
    
    for i=1:n_trials
       for j=1:n_channels
           [f, data_fft] = calc_fft(data(j,:,i), fs);
           [~, maxIndex] = max(data_fft);
           result(i,j) = f(maxIndex);
       end
       fprintf("Step %d / %d ... \n", i, n_trials);
    end

end