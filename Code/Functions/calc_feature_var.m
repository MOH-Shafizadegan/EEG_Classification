function ch_var = calc_feature_var(data)

    % input: epoched data (channel by time by trial)
    % output: variance feature matrix (channel by trial)
    % calculating the variance of each channel
    ch_var = var(data, 0, 2);

end