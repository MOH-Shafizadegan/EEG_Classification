function result = calc_feature_amp_hist(data, n_bins, amp_range)

    n_channels = size(data, 1);
    n_trials = size(data, 3);
    
    result = zeros(n_channels, n_trials, n_bins);
    
    for i=1:n_channels
       for j=1:n_trials
           range = amp_range(1) <= data(i,:,j) & ...
                        data(i,L,j) <= amp_range(2);
           selected_data = data(i, range, j);
           result(i,j,:) = histogtam(selected_data, n_bins).Values;
       end
    end
    
    close all;

end