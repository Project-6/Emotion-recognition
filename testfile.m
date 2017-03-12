
no_emotions=5;
no_images=150; %
no_feat=21;
no_images_per_emotion=30;%
no_persons=10;

all_muscle_distance_vectors=zeros(no_feat,no_images);
neutral_muscle_vector=zeros(no_feat,no_persons);
x=0;
for m=1:no_persons
I=imread(sprintf('Feedtum/mix_subjects/0%d.jpg',m)); 
feature_extraction
neutral_muscle_vector(:,m)= muscle_distance_vector(:,1);
x=(m-1)/(no_persons-1);
end

x=0;

 for n=1:no_images
    I=imread(sprintf('Feedtum/mix_subjects/%d.jpg',n)); 
    
   %I=imread('C:\\Users\\Administrator\\Documents\\MATLAB\\Feedtum\\3.jpg');
    feature_extraction %-------------------Features Extraction Module------------------------------------------------------------------------------------%
    
    all_muscle_distance_vectors(:,n) = muscle_distance_vector(:,1); % concatenation of vectors in one matrix.
%     printing_control_points
%     pause(1);
  x=(n-1)/(no_images-1);
 end %end of for loop
 
feature_vectors = zeros(no_feat,no_images); % Initialization of vector variation matrix.
for i=1:no_images
    if(mod(i,10)==0)
        feature_vectors(:,i) = bsxfun(@rdivide, all_muscle_distance_vectors(:,i), neutral_muscle_vector(:,no_persons)); %------difference(seperation) from neutral face-------------%
    else
        feature_vectors(:,i) = bsxfun(@rdivide, all_muscle_distance_vectors(:,i), neutral_muscle_vector(:,mod(i,10))); %------difference(seperation) from neutral face-------------%
    end
    
end
%Training
svm_training_onevsone
% Initializing values for testing
  no_test=50;
no_emotions=5;
 no_test_persons=10;
no_feat=21;
neutral_muscle_vector_test=zeros(no_feat,no_test_persons);

for n=1:no_test_persons;
I=imread(sprintf('Feedtum/mix_subjects1/0%d.jpg',n));
%I=imread(sprintf('Jaffe/0%d.tiff',n));
    feature_extraction
   neutral_muscle_vector_test(:,n)= muscle_distance_vector(:,1);
end
%Testing
%number = 1;
%svm_testing_fusion
%[sound_probs ac Y] = sound_test(number,number);
%final_prob = [];
%for gh = 1:20
%    final_prob(gh) = sound_probs(gh)*face_probs(gh);
%end

%confusion_matrix
%confusion_sound(no_emotions);
confusion_fused;