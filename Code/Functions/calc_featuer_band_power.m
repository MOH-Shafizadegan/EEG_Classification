function band_power = calc_featuer_band_power(data, fs)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    n_bands = 5;

    band_power = zeros(n_trials, n_channels, n_bands);
    freq_bands = [[0.1, 3]; [4, 7]; [8, 12]; [12, 30]; [30, 100]];

    for i = 1:n_trials
        for j = 1:n_channels
            for k = 1:n_bands
                band_power(i,j,k) = bandpower(data(j,:,i), fs, freq_bands(k,:));
            end
        end
        fprintf("Step %d / %d ... \n", i, n_trials);
    end
    
    band_power = reshape(band_power, n_trials, []);

end