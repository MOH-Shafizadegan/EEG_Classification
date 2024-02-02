function calc_featuer_band_power(data, fs)

    n_trials = size(data, 3);
    n_channels = size(data, 1);
    n_bands = 5;

    band_energy = zeros(n_trials, n_channels, n_bands);
    freq_bands = [[0.5, 4]; [4, 8]; [8, 12]; [12, 35]];

    for i = 1:n_trials
        for j = 1:n_channels
            for k = 1:n_bands
                band_energy(i,j,k) = bandpower(data(j,:,i), fs, freq_bands(k,:));
            end
        end
    end

end