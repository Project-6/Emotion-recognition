function pitch_out = pitch_cepst(frame_modified,fs)
yy = frame_modified;
freq_yy=fft(yy);
mag_freq_yy=abs(freq_yy);
log_mag=log(mag_freq_yy);
yy_out=ifft(log_mag);

yy_out1=abs(yy_out(32:320));
[val index] =max(yy_out1);
index_actual=index+32;
pos_pitch=index_actual;
pitch_out=fs/(pos_pitch-1);