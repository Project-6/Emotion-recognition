%-----------------------------------testing SVM----------------------------------------------------------------------------------------------%
%cd('Feedtum/mix_subjects1');

%  emotion_classified=zeros(no_test,1);
%     for r=1:no_test
rng(2);
global svmStruct_HvS;
 global svmStruct_HvD;
 global svmStruct_HvA;
 global svmStruct_HvSu;
 global svmStruct_SvD;
 global svmStruct_SvA;
 global svmStruct_SvSu;
 global svmStruct_DvA;
 global svmStruct_DvSu;
 global svmStruct_AvSu;
    class_neutral=0;
    class_happy=0;
    class_sad=0;
    class_disgust=0;
    class_anger=0;
    class_surprise=0;
    %For feedtum
    I=imread(sprintf('Feedtum/mix_subjects1/%d.jpg',number));
    %For JAFFE
    %I=imread(sprintf('Jaffe/%d.tiff',number));
%        I=imread('C:\\Users\\Administrator\\Documents\\MATLAB\\Feedtum\\mix_subjects1\\number.jpg');
    feature_extraction
    test_vector = zeros(no_feat,1); 
    test_vector(:,1) = muscle_distance_vector(:,1);
    r=number;
    if(mod(r,no_test_persons)==0)
        test_vector(:,1) = bsxfun(@rdivide, test_vector(:,1), neutral_muscle_vector_test(:,no_test_persons)); %------difference(seperation) from neutral face-------------%
    else
        test_vector(:,1) = bsxfun(@rdivide, test_vector(:,1), neutral_muscle_vector_test(:,mod(r,no_test_persons))); %------difference(seperation) from neutral face-------------%
    end
  
%     test_vector(:,1) = bsxfun(@rdivide, test_vector(:,1), neutral_muscle_vector(:,1));
   
    test_vector=test_vector';
    
    class_val = predict(svmStruct_HvS,test_vector);
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_sad=class_sad+1;
    end   
    
    class_val= predict(svmStruct_HvD,test_vector);                  
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_disgust=class_disgust+1;
    end 
    
    class_val= predict(svmStruct_HvA,test_vector);                  
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_anger=class_anger+1;
    end 
    
    class_val= predict(svmStruct_HvSu,test_vector);  
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_surprise=class_surprise+1;
    end 
    
    class_val= predict(svmStruct_SvD,test_vector);  
    if(class_val==1)
        class_sad=class_sad+1; 
    else
        class_disgust=class_disgust+1;
    end 
    
    class_val= predict(svmStruct_SvA,test_vector);  
    if(class_val==1)
        class_sad=class_sad+1; 
    else
        class_anger=class_anger+1;
    end 
    
    class_val= predict(svmStruct_SvSu,test_vector);  
    if(class_val==1)
        class_sad=class_sad+1; 
    else
        class_surprise=class_surprise+1;
    end 
    
    class_val= predict(svmStruct_DvA,test_vector);  
    if(class_val==1)
        class_disgust=class_disgust+1; 
    else
        class_anger=class_anger+1;
    end 
        
    class_val= predict(svmStruct_DvSu,test_vector);  
    if(class_val==1)
        class_disgust=class_disgust+1; 
    else
        class_surprise=class_surprise+1;
    end 
    
    class_val= predict(svmStruct_AvSu,test_vector);  
    if(class_val==1)
        class_anger=class_anger+1; 
    else
        class_surprise=class_surprise+1;
    end    
    
    temp=zeros(no_emotions:1);
    temp(1,1)=class_happy;
    temp(2,1)=class_sad;
    temp(3,1)=class_disgust;
    temp(4,1)=class_anger;
    temp(5,1)=class_surprise;
    
    [ID, e]=sort( temp, 'descend');
%      display(e(1));
%    if(e(1)==1)
%         h = msgbox('HAPPY');
%    elseif(e(1)==2)
%         h = msgbox('SAD');
%   elseif(e(1)==3)
%        h = msgbox('DISGUST');
%   elseif(e(1)==4)
%       h = msgbox('ANGER');
%   elseif(e(1)==5)
%         h = msgbox('SURPRISE');
%    end   
%    pause(2);
%     close(h);
%     emotion_classified(r,1) = e(1);
%   end
