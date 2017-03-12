no_images_per_emotion=30;
rng(2);
Groups=zeros(2*no_images_per_emotion:1);
Groups(1:no_images_per_emotion,1)=1;
Groups(no_images_per_emotion+1:2*no_images_per_emotion,1)=-1;
xData=feature_vectors';
xData_happy=xData(1:no_images_per_emotion,:);
xData_sad=xData(no_images_per_emotion+1:no_images_per_emotion*2,:);
xData_disgust=xData(no_images_per_emotion*2+1:no_images_per_emotion*3,:);
xData_anger=xData(no_images_per_emotion*3+1:no_images_per_emotion*4,:);
xData_surprise=xData(no_images_per_emotion*4+1:no_images_per_emotion*5,:);

 xData_HvS=[xData_happy; xData_sad];
 xData_HvD=[xData_happy; xData_disgust];
 xData_HvA=[xData_happy; xData_anger];
 xData_HvSu=[xData_happy; xData_surprise];
 xData_SvD=[xData_sad; xData_disgust];
 xData_SvA=[xData_sad; xData_anger];
 xData_SvSu=[xData_sad; xData_surprise];
 xData_DvA=[xData_disgust; xData_anger];
 xData_DvSu=[xData_disgust; xData_surprise];
 xData_AvSu=[xData_anger; xData_surprise];
 
 %svmStruct_HvS = svmtrain(xData_HvS,Groups,'Kernel_Function','rbf');   %happy   vs. sad
 %svmStruct_HvD = svmtrain(xData_HvD,Groups,'Kernel_Function','rbf');   %happy   vs. disgust
 %svmStruct_HvA = svmtrain(xData_HvA,Groups,'Kernel_Function','rbf');   %happy   vs. anger
 %svmStruct_HvSu = svmtrain(xData_HvSu,Groups,'Kernel_Function','rbf'); %happy   vs. ssurprise
 %svmStruct_SvD = svmtrain(xData_SvD,Groups,'Kernel_Function','rbf');   %sad     vs. disgust
 %svmStruct_SvA = svmtrain(xData_SvA,Groups,'Kernel_Function','rbf');   %sad     vs. anger
 %svmStruct_SvSu = svmtrain(xData_SvSu,Groups,'Kernel_Function','rbf'); %sad     vs. surprise
 %svmStruct_DvA = svmtrain(xData_DvA,Groups,'Kernel_Function','rbf');   %disgust vs. anger
 %svmStruct_DvSu = svmtrain(xData_DvSu,Groups,'Kernel_Function','rbf'); %disgust vs. surprise
 %svmStruct_AvSu = svmtrain(xData_AvSu,Groups,'Kernel_Function','rbf'); %anger   vs. surprise
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
 svmStruct_HvS = fitcsvm(xData_HvS,Groups,'Standardize',true,'KernelFunction','RBF');   %happy   vs. sad
 svmStruct_HvD = fitcsvm(xData_HvD,Groups,'Standardize',true,'KernelFunction','RBF');   %happy   vs. disgust
 svmStruct_HvA = fitcsvm(xData_HvA,Groups,'Standardize',true,'KernelFunction','RBF');   %happy   vs. anger
 svmStruct_HvSu = fitcsvm(xData_HvSu,Groups,'Standardize',true,'KernelFunction','RBF'); %happy   vs. ssurprise
 svmStruct_SvD = fitcsvm(xData_SvD,Groups,'Standardize',true,'KernelFunction','RBF');   %sad     vs. disgust
 svmStruct_SvA = fitcsvm(xData_SvA,Groups,'Standardize',true,'KernelFunction','RBF');   %sad     vs. anger
 svmStruct_SvSu = fitcsvm(xData_SvSu,Groups,'Standardize',true,'KernelFunction','RBF'); %sad     vs. surprise
 svmStruct_DvA = fitcsvm(xData_DvA,Groups,'Standardize',true,'KernelFunction','RBF');   %disgust vs. anger
 svmStruct_DvSu = fitcsvm(xData_DvSu,Groups,'Standardize',true,'KernelFunction','RBF'); %disgust vs. surprise
 svmStruct_AvSu = fitcsvm(xData_AvSu,Groups,'Standardize',true,'KernelFunction','RBF'); %anger   vs. surprise
 %Posterior probability
 svmStruct_HvS = fitSVMPosterior(svmStruct_HvS);
 svmStruct_HvS = compact(svmStruct_HvS);
 svmStruct_HvD = fitSVMPosterior(svmStruct_HvD);
 svmStruct_HvD = compact(svmStruct_HvD);
 svmStruct_HvA = fitSVMPosterior(svmStruct_HvA);
 svmStruct_HvA = compact(svmStruct_HvA);
 svmStruct_HvSu = fitSVMPosterior(svmStruct_HvSu);
 svmStruct_HvSu = compact(svmStruct_HvSu);
 svmStruct_SvD = fitSVMPosterior(svmStruct_SvD);
 svmStruct_SvD = compact(svmStruct_SvD);
 svmStruct_SvA = fitSVMPosterior(svmStruct_SvA);
 svmStruct_SvA = compact(svmStruct_SvA);
 svmStruct_SvSu = fitSVMPosterior(svmStruct_SvSu);
 svmStruct_SvSu = compact(svmStruct_SvSu);
 svmStruct_DvA = fitSVMPosterior(svmStruct_DvA);
 svmStruct_DvA = compact(svmStruct_DvA);
 svmStruct_DvSu = fitSVMPosterior(svmStruct_DvSu);
 svmStruct_DvSu = compact(svmStruct_DvSu);
 svmStruct_AvSu = fitSVMPosterior(svmStruct_AvSu);
 svmStruct_AvSu = compact(svmStruct_AvSu);
 