% clc
% clear
% no_feat=21;
% 
% I=imread(sprintf('C:\\Users\\Administrator\\Documents\\MATLAB\\Feedtum\\mix_subjects1\\010.jpg',i));
% feature_extraction
pxy2=pxy;
BW=edge(face_box,'canny');
C = corner(BW);
  [IDX,D] = knnsearch(C,pxy(17:38,:));
  
 pxy(17,:)=C(IDX(1),:);
 pxy(19,:)=C(IDX(3),:);
 pxy(20,:)=C(IDX(4),:);
 pxy(22,:)=C(IDX(6),:);
 pxy(25,:)=C(IDX(9),:);
 pxy(29,:)=C(IDX(13),:);
 pxy(36,:)=C(IDX(20),:);
 pxy(38,:)=C(IDX(22),:);

%  imshow(face_box);
%  hold on
%  plot(pxy(:,1), pxy(:,2), 'r*');
%  plot(pxy(:,1), pxy(:,2), 'b.');
%  pause(1);
