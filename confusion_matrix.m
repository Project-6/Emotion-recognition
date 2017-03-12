result = [];
correct = [];

for number=1:50
svm_testing_onevsone
result = [result e(1)];
if(number<=10)
    x = 1;
elseif(number<=20)
    x = 2;
elseif(number<=30)
    x = 3;
elseif(number<=40)
    x = 4;
elseif(number <=50)
    x = 5;
end
correct = [correct x];
end
[C order] = confusionmat(correct,result);
C