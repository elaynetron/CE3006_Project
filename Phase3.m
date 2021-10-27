
%bpsk vs ook for linear
N = 1024;

data = randi([0,1], [1,N]);

fc = 10000; %carrier freq
dataRate = 1000;
fs = fc * 16; %sampling freq
encoded_bits=N*7/4

t_enc = 1/(2*fs):1/fs:encoded_bits/dataRate;%sampling time altered to fit encoding
carrier_enc = cos(2*pi*fc*t_enc);
siglength_enc=fs*encoded_bits/dataRate + 1;

%SNR = (10.^(SNR_dB/10));
numSample = fs*N/dataRate + 1;

%dataStream = stretchData(data, numSample, dataRate, fs); 
%OOK_mod_signal = OOK(dataStream, carrier_enc);
%BPSK_mod_signal = BPSK(dataStream, carrier_enc);


%dBSNR = zeros(1,10,'double');
%OOK_error = zeros(1,10,'double');
%BPSK_error = zeros(1,10,'double');

%needed for encoding
poly = cyclpoly(7,4);
parmat=cyclgen(7,poly);
genmat=gen2par(parmat);

%extension_vector = ones(1, fs/dataRate);

%generate linear encoded version of the data, genmat used for linear 
linear_code_bin_en_ook=encode(data,7,4,'linear/binary',genmat);
sampled_input_ook = kron(linear_code_bin_en_ook, extension_vector);

sampled_ook = sampled_input_ook .* carrier_enc;


x=1
for i = 1:10
    dBSNR(i) = (i-1)*5;
    noiseData = noise(numSample,dBSNR(i));
    OOK_rx = sampled_ook +noiseData%insert encoded data
    %BPSK_rx = signalAdd(sampled_bpsk, noiseData);
    OOK_demod_data = demod(OOK_rx, carrier);
    BPSK_demod_data = demod(BPSK_rx, carrier);

    %code_wordlength=7, msg_length=4
    
    linear_code_bin_de_ook=decode(OOK_demod_data,7,4,'linear/binary',genmat)
    linear_code_bin_de_bpsk=decode(BPSK_demod_data,7,4,'linear/binary',genmat)
    
    OOK_error(i) = checkBitErrorRate(OOK_demod_data,dataStream);
    BPSK_error(i) = checkBitErrorRate(BPSK_demod_data,dataStream);
    
    x=x+1;
end









