function [f, amp] = calc_fft(signal, Fs)
    
    N = length(signal);
    sig_fft = fft(signal);
    amp = abs(sig_fft/N);
    amp = amp(1:N/2+1);
    amp(2:end-1) = 2*amp(2:end-1);
    f = Fs*(0:(N/2))/N;

end