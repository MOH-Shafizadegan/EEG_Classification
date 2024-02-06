function result = calc_feature_med_freq(data, fs)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    
    result = zeros(n_trials, n_channels);
    
    for i=1:n_trials
       for j=1:n_channels
           result(i,j) = medfreq(data(j, :, i), fs);
       end
       fprintf("Step %d / %d ... \n", i, n_trials);
    end

end