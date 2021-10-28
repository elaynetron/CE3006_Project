function data = BFSK_demod(rx_signal, carrier1, carrier2, t)
%BFSK_DEMOD Summary of this function goes here
%   Detailed explanation goes here
signal1 = rx_signal .* carrier1;
signal2 = rx_signal .* carrier2;

integral1 = trapz(t,signal1);
integral2 = trapz(t,signal2);

demod_signal = integral2 - integral1;
data = threshold(demod_signal, 0);
end

