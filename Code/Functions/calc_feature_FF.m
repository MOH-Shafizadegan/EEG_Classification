function FF = calc_feature_FF(data)

    sig_derivative_1 = diff(data, 1, 2);
    sig_derivative_2 = diff(sig_derivative_1, 1, 2);
    
    std_s_2 = squeeze(std(sig_derivative_2, 0, 2));
    std_s_1 = squeeze(std(sig_derivative_1, 0, 2));
    std_s_0 = squeeze(std(data, 0, 2));
    
    FF = (std_s_2 ./ std_s_1) ./ (std_s_1 ./ std_s_0);
    FF = FF';

end