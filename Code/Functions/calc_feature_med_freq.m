function result = calc_feature_med_freq(data, fs)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    
    result = zeros(n_channels, n_trials);
    
    for i=1:n_trial
       for j=1:n_channels
           result(j,i) = medfreq(data(j, :, i), fs);
       end
    end

end