function formant = formant_lpc(frame_modified,fs)
ncoef=2+round(fs/1000);
 a=lpc(frame_modified,ncoef);
% if nargout>2
%     est_x=filter([0 -a(2:end)],a,frame_modified);
%     err_1=y-est_x;
% end;
  r = roots(a);
 r = r(imag(r)>0.01);
 F = sort(atan2(imag(r),real(r))*fs/(2*pi));
 formant=F';
