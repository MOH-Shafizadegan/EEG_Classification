function feature_space = create_all_feature_space(data, fs, n_bins, amp_range, order)
    
    BP_feature = calc_featuer_band_power(data, fs);
    
    Amp_hist_feature = calc_feature_amp_hist(data, n_bins, amp_range);

    AR_Coef_feature = calc_feature_AR_Coef(data, order);

    corr_feature = calc_feature_corr(data);

    FF_feature = calc_feature_FF(data);

    max_freq_feature = calc_feature_max_freq(data, fs);

    mean_freq_feature = calc_feature_mean_freq(data, fs);

    med_freq_feature = calc_feature_med_freq(data, fs);

    var_feature = calc_feature_var(data);
    
    all_features = [BP_feature Amp_hist_feature AR_Coef_feature ...
        corr_feature FF_feature max_freq_feature mean_freq_feature ...
        med_freq_feature med_freq_feature];

    feature_space = struct(...
        'BP', zscore(BP_feature, 0, 2), ...
        'Amp_hist', zscore(Amp_hist_feature, 0, 2), ...
        'AR_Coef', zscore(AR_Coef_feature, 0, 2), ...
        'corr', zscore(corr_feature, 0, 2), ...
        'FF', zscore(FF_feature, 0, 2), ...
        'max_freq', zscore(max_freq_feature, 0, 2), ...
        'mean_freq', zscore(mean_freq_feature, 0, 2), ...
        'med_freq', zscore(med_freq_feature, 0, 2), ...
        'var', zscore(var_feature, 0, 2), ...
        'all', zscore(all_features, 0, 2) ...
        );

end