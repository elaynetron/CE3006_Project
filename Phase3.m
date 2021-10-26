%linear block coding
linear_code_bin_en=encode(msg,codeword_length,message_lngth,'linear/binary')
linear_code_bin_de=decode(msg,codeword_length,message_lngth,'linear/binary')

%convulation coding
ham_code_bin_en=encode(msg,codeword_length,message_lngth,'hamming/binary')
ham_code_bin_de=decode(msg,codeword_length,message_lngth,'hamming/binary')

cyclic_code_bin_en=encode(msg,codeword_length,message_lngth,'cyclic/binary')
cyclic_code_bin_de=decode(msg,codeword_length,message_lngth,'cyclic/binary')

%bpsk vs ook for linear
%in here just  sub in the values for ook and bpsk
linear_code_bin_en_ook=encode(msg,codeword_length,message_lngth,'linear/binary')
linear_code_bin_de_ook=decode(msg,codeword_length,message_lngth,'linear/binary')

linear_code_bin_en_bpsk=encode(msg,codeword_length,message_lngth,'linear/binary')
linear_code_bin_de_bpsk=decode(msg,codeword_length,message_lngth,'linear/binary')


plot(linear_code_bin_en_ook, error_rate)
hold on
plot(linear_code_bin_de_ook, error_rate)
hold off
title("plot of biterror against dBSNR")
xlabel("dBSNR");
ylabel("errorRate");
grid on




