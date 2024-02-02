function result = calc_feature_amp_hist(data, n_bins, amp_range)

    n_channels = size(data, 1);
    n_trials = size(data, 3);
    
    result = zeros(n_trials, n_channels, n_bins);
    
    for i=1:n_trials
       for j=1:n_channels
           range = amp_range(1) <= data(j,:,i) & data(j,:,i) <= amp_range(2);
           selected_data = data(j, range, i);
           result(i,j,:) = histogram(selected_data, n_bins).Values;
       end
       fprintf("Step %d / %d ... \n", i, n_trials);
    end
    
    result = reshape(result, n_trials, []);
    
    close all;

end