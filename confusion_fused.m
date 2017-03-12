result = [];
correct = [];

for number=1:50
svm_testing_fusion
[sound_probs ac Y] = sound_test(number,number);
final_prob = [];
for gh = 1:20
    final_prob(gh) = 0.3*sound_probs(gh)+0.7*face_probs(gh);
end
result = [result predict_general(final_prob,no_emotions)];
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