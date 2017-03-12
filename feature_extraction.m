% -------------------------------------control points extraction begins------------------------------------------------------------------------%
no_control_points=38;
faceDetector = vision.CascadeObjectDetector(); % -------------face detection-------------------------------------------------------------------%
eyeDetector = vision.CascadeObjectDetector('EyePairBig'); %-------eyes detection---------------------------------------------------------------%
nDetector = vision.CascadeObjectDetector('Nose'); % --------Nose detection---------------------------------------------------------------------%



bbox            = step(faceDetector, I);
bboxe           = step(eyeDetector, I);
bboxn           = step(nDetector, I);

face_box = I(bbox(1,2):(bbox(1,2)+bbox(1,4)),bbox(1,1):(bbox(1,1)+bbox(1,3))); %--------------Face Box-------------------------------------------%


eye_axis = uint8((bboxe(1,2)-bbox(1,2))+ bboxe(1,4)/2); %--------------------------Eyes Axix calculation-----------------------------------------%
symmetric_axis = uint8((bboxn(1,1)-bbox(1,1))+ bboxn(1,3)/2+1);%-------------------------Symmetric Axix calculation------------------------------%
rgb_I=I;
mouth_detection %-----------------------------------Mouth Detection Module--------------------------------------------------------------------------%
 %face_box(:,symmetric_axis)=250;% symetric axis
 % face_box(EA,:)=255;% eye axis
 % face_box(mouth_axis,:)=255;% mouth
 %imshow(face_box);

D=mouth_axis-eye_axis;
box_center=uint8(bbox(1,4)/2);%box center
%----------------points from anthropometric model--------------------------------------------------------------------------------------------------%  
pxy=zeros(38,2); %----all co-ordinates of control points-------------------------------------------------------------------------------------------%
px1=double(symmetric_axis-uint8(0.91*D));  py1=double(box_center-uint8(0.91*D));
px2=double(symmetric_axis-uint8(0.58*D));  py2=double(box_center-uint8(1.17*D));
px3=double(symmetric_axis-uint8(0.26*D));  py3=double(box_center-uint8(1.12*D));
px4=double(symmetric_axis+uint8(0.26*D));  py4=double(box_center-uint8(1.12*D));
px5=double(symmetric_axis+uint8(0.58*D));  py5=double(box_center-uint8(1.17*D));
px6=double(symmetric_axis+uint8(0.91*D));  py6=double(box_center-uint8(0.91*D));
px7=double(symmetric_axis+uint8(1*D));     py7=double(box_center);
px8=double(symmetric_axis+uint8(0.71*D));  py8=double(box_center+uint8(0.91*D)); 
px9=double(symmetric_axis+uint8(0.52*D));  py9=double(box_center+uint8(1.17*D));
px10=double(symmetric_axis+uint8(0.13*D)); py10=double(box_center+uint8(1.3*D));
px11=double(symmetric_axis-uint8(0.13*D)); py11=double(box_center+uint8(1.3*D));
px12=double(symmetric_axis-uint8(0.52*D)); py12=double(box_center+uint8(1.17*D));
px13=double(symmetric_axis-uint8(0.71*D)); py13=double(box_center+uint8(0.91*D));
px14=double(symmetric_axis-uint8(1.04*D)); py14=double(box_center);
px15=double(symmetric_axis-uint8(0.06*D)); py15=double(box_center-uint8(0.26*D));
px16=double(symmetric_axis+uint8(0.06*D)); py16=double(box_center-uint8(0.26*D));
px17=double(symmetric_axis-uint8(0.78*D)); py17=double(box_center-uint8(0.52*D));
px18=double(symmetric_axis-uint8(0.58*D)); py18=double(box_center-uint8(0.58*D));
px19=double(symmetric_axis-uint8(0.26*D)); py19=double(box_center-uint8(0.52*D));
px20=double(symmetric_axis+uint8(0.26*D)); py20=double(box_center-uint8(0.52*D));
px21=double(symmetric_axis+uint8(0.58*D)); py21=double(box_center-uint8(0.58*D));
px22=double(symmetric_axis+uint8(0.78*D)); py22=double(box_center-uint8(0.52*D));
px23=double(symmetric_axis-uint8(0.26*D)); py23=double(box_center+uint8(0.32*D));
px24=double(symmetric_axis+uint8(0.26*D)); py24=double(box_center+uint8(0.32*D));
px25=double(symmetric_axis-uint8(0.45*D)); py25=double(mouth_axis);
px26=double(symmetric_axis-uint8(0.32*D)); py26=double(mouth_axis-uint8(0.1*D));
px27=double(symmetric_axis);               py27=double(mouth_axis-uint8(0.15*D));
px28=double(symmetric_axis+uint8(0.32*D)); py28=double(mouth_axis-uint8(0.1*D));
px29=double(symmetric_axis+uint8(0.45*D)); py29=double(mouth_axis);
px30=double(symmetric_axis+uint8(0.32*D)); py30=double(mouth_axis+uint8(0.1*D));
px31=double(symmetric_axis+uint8(0.19*D)); py31=double(mouth_axis+uint8(0.13*D));
px32=double(symmetric_axis);               py32=double(mouth_axis+uint8(0.15*D));
px33=double(symmetric_axis-uint8(0.19*D)); py33=double(mouth_axis+uint8(0.13*D));
px34=double(symmetric_axis-uint8(0.32*D)); py34=double(mouth_axis+uint8(0.1*D));
px35=double(symmetric_axis-uint8(0.74*D)); py35=double(box_center-uint8(0.26*D));
px36=double(symmetric_axis-uint8(0.58*D)); py36=double(box_center-uint8(0.39*D));
px37=double(symmetric_axis+uint8(0.58*D)); py37=double(box_center-uint8(0.39*D));
px38=double(symmetric_axis+uint8(0.74*D)); py38=double(box_center-uint8(0.26*D));

for q =1:38
    if(eval(sprintf('px%d',q))==0)
        pxy(q,1)=1;
    else
       pxy(q,1)=eval(sprintf('px%d',q)); 
    end
    if(eval(sprintf('py%d',q))==0)
        pxy(q,2)=1;
    else
        pxy(q,2)=eval(sprintf('py%d',q));
    end    
    
end

 corner_points
 %canny_demo

%  imshow(face_box);
 muscle_distance_vector=(zeros(no_feat,1));
 
 muscle_distance_vector(1,1)=sqrt( (pxy(1,1)-pxy(17,1))^2 + (pxy(1,2)-pxy(17,2))^2);
 muscle_distance_vector(2,1)=sqrt( (pxy(2,1)-pxy(18,1))^2 + (pxy(2,2)-pxy(18,2))^2);
 muscle_distance_vector(3,1)=sqrt( (pxy(3,1)-pxy(19,1))^2 + (pxy(3,2)-pxy(19,2))^2);
 muscle_distance_vector(4,1)=sqrt( (pxy(4,1)-pxy(20,1))^2 + (pxy(4,2)-pxy(20,2))^2);
 muscle_distance_vector(5,1)=sqrt( (pxy(5,1)-pxy(21,1))^2 + (pxy(5,2)-pxy(21,2))^2);
 muscle_distance_vector(6,1)=sqrt( (pxy(6,1)-pxy(22,1))^2 + (pxy(6,2)-pxy(22,2))^2);
 muscle_distance_vector(7,1)=sqrt( (pxy(19,1)-pxy(20,1))^2 + (pxy(19,2)-pxy(20,2))^2);
 muscle_distance_vector(8,1)=sqrt( (pxy(35,1)-pxy(36,1))^2 + (pxy(35,2)-pxy(36,2))^2);
 muscle_distance_vector(9,1)=sqrt( (pxy(37,1)-pxy(38,1))^2 + (pxy(37,2)-pxy(38,2))^2);
 muscle_distance_vector(10,1)=sqrt( (pxy(15,1)-pxy(23,1))^2 + (pxy(15,2)-pxy(23,2))^2);
 muscle_distance_vector(11,1)=sqrt( (pxy(16,1)-pxy(24,1))^2 + (pxy(16,2)-pxy(24,2))^2);
 muscle_distance_vector(12,1)=sqrt( (pxy(14,1)-pxy(26,1))^2 + (pxy(14,2)-pxy(26,2))^2);
 muscle_distance_vector(13,1)=sqrt( (pxy(13,1)-pxy(25,1))^2 + (pxy(13,2)-pxy(25,2))^2);
 muscle_distance_vector(14,1)=sqrt( (pxy(12,1)-pxy(34,1))^2 + (pxy(12,2)-pxy(34,2))^2);
 muscle_distance_vector(15,1)=sqrt( (pxy(11,1)-pxy(33,1))^2 + (pxy(11,2)-pxy(33,2))^2);
 muscle_distance_vector(16,1)=sqrt( (pxy(10,1)-pxy(31,1))^2 + (pxy(10,2)-pxy(31,2))^2);
 muscle_distance_vector(17,1)=sqrt( (pxy(9,1)-pxy(30,1))^2 + (pxy(9,2)-pxy(30,2))^2);
 muscle_distance_vector(18,1)=sqrt( (pxy(8,1)-pxy(29,1))^2 + (pxy(8,2)-pxy(29,2))^2);
 muscle_distance_vector(19,1)=sqrt( (pxy(7,1)-pxy(28,1))^2 + (pxy(7,2)-pxy(28,2))^2);
 muscle_distance_vector(20,1)=sqrt( (pxy(25,1)-pxy(29,1))^2 + (pxy(25,2)-pxy(29,2))^2);
 muscle_distance_vector(21,1)=sqrt( (pxy(27,1)-pxy(32,1))^2 + (pxy(27,2)-pxy(32,2))^2);

%  muscle_distance_vector(1,1)=sqrt( (pxy2(1,1)-pxy2(17,1))^2 + (pxy2(1,2)-pxy2(17,2))^2);
%  muscle_distance_vector(2,1)=sqrt( (pxy2(2,1)-pxy2(18,1))^2 + (pxy2(2,2)-pxy2(18,2))^2);
%  muscle_distance_vector(3,1)=sqrt( (pxy2(3,1)-pxy2(19,1))^2 + (pxy2(3,2)-pxy2(19,2))^2);
%  muscle_distance_vector(4,1)=sqrt( (pxy2(4,1)-pxy2(20,1))^2 + (pxy2(4,2)-pxy2(20,2))^2);
%  muscle_distance_vector(5,1)=sqrt( (pxy2(5,1)-pxy2(21,1))^2 + (pxy2(5,2)-pxy2(21,2))^2);
%  muscle_distance_vector(6,1)=sqrt( (pxy2(6,1)-pxy2(22,1))^2 + (pxy2(6,2)-pxy2(22,2))^2);
%  muscle_distance_vector(7,1)=sqrt( (pxy2(19,1)-pxy2(20,1))^2 + (pxy2(19,2)-pxy2(20,2))^2);
%  muscle_distance_vector(8,1)=sqrt( (pxy2(35,1)-pxy2(36,1))^2 + (pxy2(35,2)-pxy2(36,2))^2);
%  muscle_distance_vector(9,1)=sqrt( (pxy2(37,1)-pxy2(38,1))^2 + (pxy2(37,2)-pxy2(38,2))^2);
%  muscle_distance_vector(10,1)=sqrt( (pxy2(15,1)-pxy2(23,1))^2 + (pxy2(15,2)-pxy2(23,2))^2);
%  muscle_distance_vector(11,1)=sqrt( (pxy2(16,1)-pxy2(24,1))^2 + (pxy2(16,2)-pxy2(24,2))^2);
%  muscle_distance_vector(12,1)=sqrt( (pxy2(14,1)-pxy2(26,1))^2 + (pxy2(14,2)-pxy2(26,2))^2);
%  muscle_distance_vector(13,1)=sqrt( (pxy2(13,1)-pxy2(25,1))^2 + (pxy2(13,2)-pxy2(25,2))^2);
%  muscle_distance_vector(14,1)=sqrt( (pxy2(12,1)-pxy2(34,1))^2 + (pxy2(12,2)-pxy2(34,2))^2);
%  muscle_distance_vector(15,1)=sqrt( (pxy2(11,1)-pxy2(33,1))^2 + (pxy2(11,2)-pxy2(33,2))^2);
%  muscle_distance_vector(16,1)=sqrt( (pxy2(10,1)-pxy2(31,1))^2 + (pxy2(10,2)-pxy2(31,2))^2);
%  muscle_distance_vector(17,1)=sqrt( (pxy2(9,1)-pxy2(30,1))^2 + (pxy2(9,2)-pxy2(30,2))^2);
%  muscle_distance_vector(18,1)=sqrt( (pxy2(8,1)-pxy2(29,1))^2 + (pxy2(8,2)-pxy2(29,2))^2);
%  muscle_distance_vector(19,1)=sqrt( (pxy2(7,1)-pxy2(28,1))^2 + (pxy2(7,2)-pxy2(28,2))^2);
%  muscle_distance_vector(20,1)=sqrt( (pxy2(25,1)-pxy2(29,1))^2 + (pxy2(25,2)-pxy2(29,2))^2);
%  muscle_distance_vector(21,1)=sqrt( (pxy2(27,1)-pxy2(32,1))^2 + (pxy2(27,2)-pxy2(32,2))^2);




