function [res] = confusion_sound(no_emotions)
result = [];
correct = [];

for number=1:50
[X Y Z] = sound_test(number,number);
class = predict_general(X,no_emotions);
result = [result class];
if(number<=10)
    x = 1;%hsdaSu
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