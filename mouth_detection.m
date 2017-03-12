%--------------------------------------------------------Mouth Detection Module-------------------------------------------------------------------------%

%roi = Region of Interest (B&W)--------------------------------------------------------------------------------------------------------------------------%
roi=face_box(uint8(bbox(1,3)*0.65):uint8(bbox(1,3)*0.65)+uint8(bbox(1,3)*0.25),uint8(bbox(1,3)*0.25):uint8(bbox(1,3)*0.25)+uint8(bbox(1,3)*0.5));

rgb_face_box=zeros(bbox(1,4)+1,bbox(1,3)+1,3);
rgb_face_box(:,:,1)=rgb_I(bbox(1,2):(bbox(1,2)+bbox(1,4)),bbox(1,1):(bbox(1,1)+bbox(1,3)),1); %------rgb_I=RGB Image-----------------------------------------------------%
rgb_face_box(:,:,2)=rgb_I(bbox(1,2):(bbox(1,2)+bbox(1,4)),bbox(1,1):(bbox(1,1)+bbox(1,3)),2);
rgb_face_box(:,:,3)=rgb_I(bbox(1,2):(bbox(1,2)+bbox(1,4)),bbox(1,1):(bbox(1,1)+bbox(1,3)),3);

%----------------------roi2=Color Map -------------------------------------------------------------------------------------------------------------------%

rgb_roi=zeros(uint8(bbox(1,3)*0.25)+1,uint8(bbox(1,3)*0.5)+1,3);
rgb_roi(:,:,1)=rgb_face_box(uint8(bbox(1,3)*0.65):uint8(bbox(1,3)*0.65)+uint8(bbox(1,3)*0.25),uint8(bbox(1,3)*0.25):uint8(bbox(1,3)*0.25)+uint8(bbox(1,3)*0.5),1);
rgb_roi(:,:,2)=rgb_face_box(uint8(bbox(1,3)*0.65):uint8(bbox(1,3)*0.65)+uint8(bbox(1,3)*0.25),uint8(bbox(1,3)*0.25):uint8(bbox(1,3)*0.25)+uint8(bbox(1,3)*0.5),2);
rgb_roi(:,:,3)=rgb_face_box(uint8(bbox(1,3)*0.65):uint8(bbox(1,3)*0.65)+uint8(bbox(1,3)*0.25),uint8(bbox(1,3)*0.25):uint8(bbox(1,3)*0.25)+uint8(bbox(1,3)*0.5),3);
rgb_roi=uint8(rgb_roi);
hsv_roi=rgb2hsv(rgb_roi);

%--------------------thresolding for red color------------------------------------------------------------------------------------------------------------%
hue=hsv_roi(:,:,1);
hue(:,:)=1;
for i=1:uint8(bbox(1,3)*0.25)+1
    for j=1:uint8(bbox(1,3)*0.5)+1
        if hsv_roi(i,j,1)>0.0&&hsv_roi(i,j,1)<0.333&&hsv_roi(i,j,2)<0.7
            hue(i,j)=0;
       end           
    end
end
%------------------- moments---------------------------------------------------------------------------------------------------------------------------%
m00=0; %-----summation(hue(x,y))----------%
m01=0; %-----summation(y*hue(x,y))--------%
m10=0; %-----summation(x*hue(x,y))--------%
a=double(uint8(bbox(1,3)*0.25)+1);
b=double(uint8(bbox(1,3)*0.5)+1);
for i=1:a
    for j=1:b
       m00=m00+hue(i,j);
       m10=m10+ i*hue(i,j); 
       m01=m01+ j*hue(i,j);
    end
end

cx=m10/m00;%Mouth center x
cy=m01/m00;%Mouth center y
mouth_axis=cx+uint8(bbox(1,3)*0.65);%---------------------Mouth Axis-------------------------------------------------------------------------------------------%







