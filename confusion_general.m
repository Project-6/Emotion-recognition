function [res] = confusion_general(no_emotions)
result = [];
correct = [];

for number=1:50
[X Y] = sound_test(number,number);
class = predict_sound(X,no_emotions);
result = [result class];
if(number<=10)
    x = 4;%hsdaSu
elseif(number<=20)
    x = 1;
elseif(number<=30)
    x = 2;
elseif(number<=40)
    x = 5;
elseif(number <=50)
    x = 3;
end
correct = [correct x];
end
[C order] = confusionmat(correct,result);
C