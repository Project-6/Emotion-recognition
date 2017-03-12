function res = predict_general(probs,no_emotions)
    i = 1;
    class_neutral=0;
    class_happy=0;
    class_sad=0;
    class_disgust=0;
    class_anger=0;
    class_surprise=0;
    class_val = probs(i)<probs(i+1);
    i = i+2;
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_sad=class_sad+1;
    end   
    
    class_val = probs(i)<probs(i+1);
    i = i+2;              
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_disgust=class_disgust+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2;                
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_anger=class_anger+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2; 
    if(class_val==1)
        class_happy=class_happy+1; 
    else
        class_surprise=class_surprise+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2;    
    if(class_val==1)
        class_sad=class_sad+1; 
    else
        class_disgust=class_disgust+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2;    
    if(class_val==1)
        class_sad=class_sad+1; 
    else
        class_anger=class_anger+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2;    
    if(class_val==1)
        class_sad=class_sad+1; 
    else
        class_surprise=class_surprise+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2;  
    if(class_val==1)
        class_disgust=class_disgust+1; 
    else
        class_anger=class_anger+1;
    end 
        
    class_val = probs(i)<probs(i+1);
    i = i+2;  
    if(class_val==1)
        class_disgust=class_disgust+1; 
    else
        class_surprise=class_surprise+1;
    end 
    
    class_val = probs(i)<probs(i+1);
    i = i+2;   
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
    res = e(1);