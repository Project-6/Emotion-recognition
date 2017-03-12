% clear;
% clc;
function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 27-Jun-2014 17:13:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global filename;
global pathname;
global fullpathname;
global real;
global predict1;
real = [];
predict1 = [];
pathname='test'
for i = 1:1
    if(i < 11)
        real = [real 1];
    elseif(i < 21)
        real = [real 2];
    elseif(i < 31)
        real = [real 3];
    elseif(i < 41)
        real = [real 4];
    elseif(i < 51)
        real = [real 5];
    end
    filename = i;
    filename=num2str(filename);
i    
%[filename, pathname]=uigetfile({'*.wav'},'File Selector');
t='.wav';
filename = strcat(filename,t);
fullpathname = strcat(pathname,filename);

 [x,fs] = wavread([pathname '/' filename]);
 
 d=size(x);
 if (d(2)>1)
     x=mean(x,2);
 end
handles.x=x;
handles.fs=fs;
axes(handles.axes1);
plot(handles.x);

%play(handles);
modspeech(hObject,handles);
guidata(hObject,handles);
end
c=confusionmat(real,predict1);
c
% sound(input,fs);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
%function pushbutton2_Callback(hObject, eventdata, handles)
%axes

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function modspeech(hObject,handles)
a=mean(handles.x);
handles.x=(handles.x-a);
frame_len=0.02*handles.fs;
N = length(handles.x);
num_frames=floor(N/frame_len);
time_sig=(0:N-1)/handles.fs;
count =1;
for k=1:num_frames
   frame = handles.x((k-1)*frame_len+1: k*frame_len);
    energy_val = sum(frame.*frame);
   if(energy_val>0.08)
   new_sig((count-1)*frame_len+1:count*frame_len)= frame;
    count=count+1;
   end
end;
handles.new_sig=new_sig;
axes(handles.axes2);
plot(new_sig);
new_sig=new_sig';
pitch(hObject,handles);
guidata(hObject,handles);
%guidata(hObject,handles);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function play( handles)
% handles.x;

sound(handles.x,handles.fs);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.

% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)

% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton5.
function pitch(hObject,handles)
number_frames_final=60;
new_sig=handles.new_sig;
num_sample_per_frame=floor(length(new_sig)/number_frames_final);
frame_modified=zeros(num_sample_per_frame,1);
pitch_final= zeros(number_frames_final,1);
for i=1:number_frames_final
    frame_modified=new_sig((i-1)*num_sample_per_frame+1:num_sample_per_frame*i);
frame_modified_trans=(frame_modified)';
len_1=length(frame_modified_trans);

pitch_out = pitch_cepst(frame_modified,handles.fs); %function for pitch calculation
pitch_final(i,1)=pitch_out;

end
handles.pitch_final=pitch_final;
axes(handles.axes3);
plot(pitch_final);
format(hObject,handles);
guidata(hObject,handles);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function format(hObject,handles)

number_frames_final=60;
new_sig=handles.new_sig;
num_sample_per_frame=floor(length(new_sig)/number_frames_final);
formant_final=zeros(number_frames_final,3);
frame_modified=zeros(num_sample_per_frame,1);
for i=1:number_frames_final
    frame_modified=new_sig((i-1)*num_sample_per_frame+1:num_sample_per_frame*i);
frame_modified_trans=(frame_modified)';
len_1=length(frame_modified_trans);

formant = formant_lpc(frame_modified,handles.fs);
formant_final(i,:)=formant(1:3);

end
handles.formant_final=formant_final;
axes(handles.axes4);
plot(formant_final(:,1),'r');
hold on;
plot(formant_final(:,2),'g');
hold on;
plot(formant_final(:,3),'b');
hold off;
MFCC(hObject,handles);
guidata(hObject,handles);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function MFCC(hObject,handles)
number_frames_final=60;
new_sig=handles.new_sig;
num_sample_per_frame=floor(length(new_sig)/number_frames_final);
frame_modified=zeros(num_sample_per_frame,1);
mfcc_final=zeros(12,number_frames_final);
for i=1:number_frames_final
    frame_modified=new_sig((i-1)*num_sample_per_frame+1:num_sample_per_frame*i);
frame_modified_trans=(frame_modified)';
len_1=length(frame_modified_trans);
yy=frame_modified_trans;
len_sample=length(yy);
yy_f=fft(yy);
yy_mag=abs(yy_f);
nfft=2^nextpow2(len_sample);
pxx=periodogram(yy,[],512);
% plot(pxx);
length_pxx=length(pxx);
bank_size=26;
bank_size_1=bank_size+2;
fs=handles.fs;
freq_initial= linspace(0,fs,length_pxx);
lower_limit_freq_mel=0;

upper_limit_freq_mel=1125*log(1+(fs/700));
freq_initial_bank_mel=upper_limit_freq_mel*linspace(0,1,bank_size_1);
freq_final_bank=700*(exp(freq_initial_bank_mel/1125)-1); 
freq_final_bank=freq_final_bank';
freq_initial=freq_initial';
count=zeros(bank_size,2);
for iii=1:bank_size
   count1=0;
   count2=0;flag=0;
    for j=1:length_pxx
       if freq_initial(j,:)<= freq_final_bank(iii,:)
       count1=count1+1;
       else
           if freq_initial(j,:)> freq_final_bank(iii+2,:)
               break;
           else
               if(flag==0)
           
           count1=count1+1;
           count2=count1;
           flag=1;
          else
           count2=count2+1;
               end
           end
       end
    end
   count(iii,1)=count1;
   count(iii,2)=count2;
end

%forming a triangular window of required sizes
tri_win = zeros(bank_size,length_pxx);
for ii=1:bank_size
    len_window=count(ii,2)-count(ii,1)+1;
%     diisplay(len_window);
    if(mod(len_window,2)==0)
       for kk = 1:len_window
           if(kk <= len_window/2)
             tri_win(ii,kk+count(ii,1)-1)=(2*kk-1)/len_window;
           else
               tri_win(ii,kk+count(ii,1)-1)=2-((2*kk-1)/len_window);
           end
       end
     else
        for kkk = 1:len_window
             if (kkk<=(len_window+1)/2)
                 tri_win(ii,kkk+count(ii,1)-1)=2*kkk/(len_window+1);
             else
                 tri_win(ii,kkk+count(ii,1)-1)=2-(2*kkk/(len_window+1));
             end
           
        end
    end
end
%multiplying filterbank with power spectrum
filter_bank_energy=tri_win*pxx; %multiply triangular filter to power spectrum
filter_bank_energy_log=log(filter_bank_energy); 
filter_bank_energy_dct=dct(filter_bank_energy_log);
coefficients_selected=12;
mfcc_final(:,i)=filter_bank_energy_dct(2:coefficients_selected+1);
% plot_mfcc=mfcc_final';
% axes(handles.axes5);
% plot(plot_mfcc);

end;
handles.mfcc_final=mfcc_final;
Energy(hObject,handles);
guidata(hObject,handles);
% plot_mfcc=mfcc_final';
% axes(handles.axes5);
% plot(plot_mfcc);



%end of number of frames final loop
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in pushbutton8.
function Energy(hObject,handles)
number_frames_final=60;
new_sig=handles.new_sig;
num_sample_per_frame=floor(length(new_sig)/number_frames_final);
energy_value=zeros(number_frames_final,1);
frame_modified=zeros(num_sample_per_frame,1);
for i=1:number_frames_final
    frame_modified=new_sig((i-1)*num_sample_per_frame+1:num_sample_per_frame*i);
frame_modified_trans=(frame_modified)';
yy=frame_modified_trans;
energy_value(i,1) = sum(yy.*yy);
end
handles.energy_value=energy_value;
axes(handles.axes6);
plot(energy_value);
Global(hObject,handles);
guidata(hObject,handles);
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
%function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
%function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
 %   set(hObject,'BackgroundColor','white');
%end


% --- Executes on selection change in popupmenu2.
%function popupmenu2_Callback(hObject, eventdata, handles)

%mfcc_final= handles.mfcc_final;
%ii=get(handles.popupmenu2,'Value');
%%axes(handles.axes5);
%plot(mfcc_final(ii,:));


% display(ii);

% ii1=get(handles.popupmenu2,'String');
% display(ii1{ii});
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
%function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
 %   set(hObject,'BackgroundColor','white');
%end


% --- Executes on button press in pushbutton9.
%function pushbutton9_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
%function pushbutton9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
 %   set(hObject,'BackgroundColor','white');
%end


% --- Executes on button press in pushbutton10.
function Global(hObject,handles)
pitch_final=handles.pitch_final;
formant_final=handles.formant_final;
energy_value=handles.energy_value;
mfcc_final=handles.mfcc_final;
global_feature_vector_test=zeros(34,1);
formant_feature_vector = zeros(6,1);
feature_final_formant=zeros(3,2);
for j=1:3
formant_mean = mean(formant_final(j,:));
formant_sd = std(formant_final(j,:));
feature_final_formant(j,1) = formant_mean;
feature_final_formant(j,2) = formant_sd;
end;  
formant_feature_vector(:,1)=reshape(feature_final_formant,[],1);
formant_feature_final = formant_feature_vector';
mean_formant = mean(formant_feature_final);
formant_feature_final=formant_feature_final/mean_formant;

energy_feature_final = zeros(1,2);
energy_feature_final(1,1)= mean(energy_value(:,1));
energy_feature_final(1,2)= std(energy_value(:,1));
mean_energy = mean(energy_feature_final);
energy_feature_final = energy_feature_final/mean_energy;

pitch_feature_final = zeros(1,2);
pitch_feature_final(1,1)=mean(pitch_final(:,1));
pitch_feature_final(1,2)=std(pitch_final(:,1));

mean_pitch = mean(pitch_feature_final);
pitch_feature_final=pitch_feature_final/mean_pitch;

coefficients_selected=12;
feature_final_mfcc=zeros(coefficients_selected,2);

for m=1:coefficients_selected
feature_mean = mean(mfcc_final(m,:));
feature_sd = std(mfcc_final(m,:));
feature_final_mfcc(m,1) = feature_mean;
feature_final_mfcc(m,2) = feature_sd;
end;
feature_final_mfcc_trans=feature_final_mfcc';
mfcc_feature_final = [feature_final_mfcc_trans(1,:),feature_final_mfcc_trans(2,:)];
% end of coefficients_selected loop
% aa1=feature_final_mfcc(;
% mfcc_feature_vector=reshape(feature_final_mfcc,[],1);

mean_mfcc = mean(mfcc_feature_final);
mfcc_feature_final= mfcc_feature_final/mean_mfcc;
% mfcc_feature_final=mfcc_feature_final';


global_feature_final=[energy_feature_final,mfcc_feature_final,formant_feature_final,pitch_feature_final];
global_feature_vector_test(:,1)=global_feature_final';
handles.global_feature_vector_test=global_feature_vector_test;
set(handles.text3,'Visible','on');
SVM(hObject,handles);
guidata(hObject,handles);
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu3.
function SVM( hObject,handles)
global_feature_vector_test=handles.global_feature_vector_test;
%ii_1=get(handles.popupmenu3,'Value');
ii_1=2;
if(ii_1==1)
%back propagation algorithm
number_hidden=34;
number_output=5;
hidden_neuron_value_test = zeros(number_hidden,1);
output_neuron_value_test = zeros(number_output,1);
input_hidden_value_test = zeros(number_hidden,1);
weight_input_hidden=xlsread('weight_input_hidden_efficientindex.xlsx');
weight_hidden_output=xlsread('weight_hidden_output_efficientindex.xlsx');
threshold_hidden=xlsread('threshold_hidden_efficientindex.xlsx');
threshold_output=xlsread('threshold_output_efficientindex.xlsx');


%  weight_input_hidden= evalin('base','weight_input_hidden');
%  threshold_hidden= evalin('base','threshold_hidden');
%  weight_hidden_output= evalin('base','weight_hidden_output');
%  threshold_output= evalin('base','threshold_output');
for m = 1:1
     for hh = 1:number_hidden
      input_hidden_value_test(hh,m)=((global_feature_vector_test(:,m)'*weight_input_hidden(:,hh))-threshold_hidden(hh,1));
      input_hidden_value_test(hh,m)=input_hidden_value_test(hh,m)/10^2;
     hidden_neuron_value_test(hh,m)=(1/(1+exp(-input_hidden_value_test(hh,m))));
     if hidden_neuron_value_test(hh,m)>=1
          hidden_neuron_value_test(hh,m)=0.9999;
      elseif hidden_neuron_value_test(hh,m)==0
          hidden_neuron_value_test(hh,m)=0.0001;
     end
    
     end
end
output_hidden_value_test = zeros(number_output,1);
 for pp = 1:1
     for n = 1: number_output
      output_hidden_value_test(n,pp)=((hidden_neuron_value_test(:,pp)'*weight_hidden_output(:,n))-threshold_output(n,1));
      output_hidden_value_test(n,pp)=output_hidden_value_test(n,pp)/10^2;
       output_neuron_value_test(n,pp)=(1/(1+exp(-output_hidden_value_test(n,pp))));
      if output_neuron_value_test(n,pp)>=1
          output_neuron_value_test(n,pp)=0.9999;
      elseif output_neuron_value_test(n,pp)==0
         output_neuron_value_test(n,pp)=0.0001;
      end
%       display(output_hidden_value_test); 
     end
     
 end

%  index = zeros(test_in_emotion,1);
 for i=1:1
 [val , index] =max(output_neuron_value_test(:,i));
 end
 if(index==1)
     set(handles.text4,'Visible','on');
 end
 if(index==2)
     set(handles.text5,'Visible','on');
 end
 if(index==3)
     set(handles.text6,'Visible','on');
 end
 if(index==4)
     set(handles.text7,'Visible','on');
 end
 if(index==5)
     set(handles.text8,'Visible','on');
 end
else
    global_feature_vector=xlsread('vector_required_20fold.xlsx');
%     global_feature_vector=evalin('base','global_feature_vector');
    %multisvm function to detect emotion 
% test=importdata('info.txt');
%categorizing the classes
file_in_emotion=5;
data_in_emotion=40;
test_in_emotion=1; 
dd=data_in_emotion;
anger= global_feature_vector(:,[1:dd]);
happy= global_feature_vector(:,[dd+1:dd*2]);
sadness= global_feature_vector(:,[dd*2+1:dd*3]);
fear= global_feature_vector(:,[dd*3+1:dd*4]);
disgust= global_feature_vector(:,[dd*4+1:dd*5]);
label_anger=zeros(1,data_in_emotion);
label_happy=zeros(1,data_in_emotion);
label_sadness=zeros(1,data_in_emotion);
label_fear=zeros(1,data_in_emotion);
label_disgust=zeros(1,data_in_emotion);


for i=1:data_in_emotion*file_in_emotion
 %   data_in_emotion
  %  file_in_emotion
    if(i<=dd)
        label_anger(1,i)=1;
    end
    if(i>dd && i<=dd*2)
        label_happy(1,i-dd)=2;
    end
    if(i>dd*2 && i<=dd*3)
        label_sadness(1,i-dd*2)=3;
    end
    if(i>dd*3 && i<=dd*4)
        label_fear(1,i-dd*3)=4;
    end
    if(i>dd*4 && i<=dd*5)
        label_disgust(1,i-dd*4)=5;
    end
end

emotion=zeros(test_in_emotion,1);
for j=1:test_in_emotion
    test_data=global_feature_vector_test(:,j);
    test_data=test_data';

%if(val==2)   
 %train=[happy,fear];
 %label=[label_happy,label_fear];
%elseif(val==3)
 %train=[sad,fear];
 %label=[label_sad,label_fear];
%elseif(val==1)
 train=[happy,anger];
 label=[label_happy,label_anger];  
%end
svmstruct=svmtrain(train,label,'Kernel_function','polynomial');
val=svmclassify(svmstruct,test_data);
i=6;
size(anger)
size(happy)
i
size(happy(2,:))
label_happy
%train=[happy(0,),anger(0,)];
size(train)
size(label)
size(train(2,:))
train=train.';


i
%val
if (val==1)
    train=[anger,happy];
    label=[label_anger,label_happy];
elseif(val==3)
    train=[sadness,happy];
    label=[label_sadness,label_happy];
elseif(val==4)
    train=[fear,happy];
    label=[label_fear,label_happy];
elseif(val==5)
    train=[disgust,happy]
    label=[label_fear,label_happy];
end



svmstruct=svmtrain(train,label,'Kernel_function','polynomial');
val=svmclassify(svmstruct,test_data);

%val

if (val==4)
    train=[fear,anger];
    label=[label_fear,label_anger];
elseif(val==3)
    train=[sadness,anger];
    label=[label_sadness,label_anger];
elseif(val==2)
    train=[happy,anger];
    label=[label_happy,label_anger];
elseif(val==5)
    train=[disgust,anger];
    label=[label_disgust,label_anger];
end

svmstruct=svmtrain(train,label,'Kernel_function','polynomial');
val=svmclassify(svmstruct,test_data);
%val
if (val==1)
    train=[anger,disgust];
    label=[label_anger,label_disgust];
elseif(val==3) 
    train=[sadness,disgust];
    label=[label_sadness,label_disgust];
elseif(val==2) 
    train=[happy,disgust];
    label=[label_happy,label_disgust];
elseif(val==4)
    train=[fear,disgust];
    label=[label_fear,label_disgust];

end

svmstruct=svmtrain(train,label,'Kernel_function','polynomial');
val=svmclassify(svmstruct,test_data);

if(val==2)   
 train=[happy,fear];
 label=[label_happy,label_fear];
elseif(val==3)
 train=[sad,fear];
 label=[label_sad,label_fear];
elseif(val==1)
 train=[anger,fear];
 label=[label_anger,label_fear];  
end
svmstruct=svmtrain(train,label,'Kernel_function','polynomial');
val=svmclassify(svmstruct,test_data);
%val
if (val==1)
    train=[anger,sadness];
    label=[label_anger,label_sadness];
elseif(val==5) 
    train=[disgust,sadness];
    label=[label_disgust,label_sadness];
elseif(val==2) 
    train=[happy,sadness];
    label=[label_happy,label_sadness];
elseif(val==4)
    train=[fear,sadness];
    label=[label_fear,label_sadness];

end
svmstruct=svmtrain(train,label,'Kernel_function','polynomial');
val=svmclassify(svmstruct,test_data);
emotion(1,1)=val;
end


label=[label_anger,label_happy];
train=[anger,happy];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
postp
pii=postp;
result
label=[label_anger,label_sadness];
train=[anger,sadness];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp];
result
label=[label_anger,label_fear];
train=[anger,fear];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp];
result
label=[label_anger,label_disgust];
train=[anger,disgust];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp];
result
label=[label_sadness,label_happy];
train=[sadness,happy];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp]
result
label=[label_disgust,label_happy];
train=[disgust,happy];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp]
result
label=[label_fear,label_happy];
train=[fear,happy];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp]
result
label=[label_fear,label_sadness];
train=[fear,sadness];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp]
result
label=[label_fear,label_disgust];
train=[fear,disgust];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp]
result
label=[label_sadness,label_disgust];
train=[sadness,disgust];
train=train.';
label=label.';
CVSVMModel = fitcsvm(train,label,'Kernelfunction','polynomial');
ScoreSVMModel = fitSVMPosterior(CVSVMModel);
[result postp]=predict(ScoreSVMModel,test_data);
pii=[pii,postp]
result
global predict1;
pii;
if(emotion(1,1)==1)
     disp('angry')
     predict1=[predict1 1];
 end
 if(emotion(1,1)==2)
    disp('happy')
     predict1=[predict1 2];
 end
 if(emotion(1,1)==3)
     disp('sadness')
      predict1=[predict1 3];
 end
 if(emotion(1,1)==4)
     disp('fear')
      predict1=[predict1 4];
 end
 if(emotion(1,1)==5)
     disp('disgust')
      predict1=[predict1 5];
 
 end
 
end
guidata(hObject,handles);
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
%function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
%if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%    set(hObject,'BackgroundColor','white');
%end
