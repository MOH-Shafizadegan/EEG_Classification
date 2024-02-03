function result = calc_feature_var(data)

    % result = matrix of size trials by channel
    % calculating the variance of each channel
    ch_var = var(data, 0, 2);
    result = squeeze(ch_var)';

end