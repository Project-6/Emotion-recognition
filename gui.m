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

% Last Modified by GUIDE v2.5 27-Feb-2017 20:14:26

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
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
global pathname;
global fullpathname;
[filename, pathname] = uigetfile({'Feedtum/mix_subjects/*.jpg'}, 'Pick a .jpg image');
fullpathname=strcat(pathname, filename);
I=imread([pathname '/' filename]);
x=0.6;
h = waitbar(x,'loading..');
axes(handles.axes1);
imshow(I);
no_feat=21;
feature_extraction
printing_control_points
axes(handles.axes2);
imshow(face_box2);
Printing_distances
axes(handles.axes3);
imshow(face_box2);
close(h);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

guidata(hObject, handles);



% --- Executes on button press in pushbutton4.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname, pathname] = uigetfile({'*.mat'}, 'Pick a .mat file');
fullpathname=strcat(pathname, fname);
feature_vectors=importdata(fname);

[fname_n, pathname] = uigetfile({'*.mat'}, 'Pick a .mat file');
fullpathname=strcat(pathname, fname_n);
neutral_muscle_vector=importdata(fname_n);

handles.fname=feature_vectors;
handles.fname_n=neutral_muscle_vector;
h = msgbox('Loaded');
pause(1);
close(h);
guidata(hObject, handles);


function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
no_emotions=5;
no_images=150; %
no_feat=21;
no_images_per_emotion=30;%
no_persons=10;

all_muscle_distance_vectors=zeros(no_feat,no_images);
neutral_muscle_vector=zeros(no_feat,no_persons);
x=0;
h=waitbar(x,'loading neutral faces...');
for m=1:no_persons
I=imread(sprintf('Feedtum/mix_subjects/0%d.jpg',m)); 
feature_extraction
neutral_muscle_vector(:,m)= muscle_distance_vector(:,1);
x=(m-1)/(no_persons-1);
waitbar(x,h,'loading neutral faces...');
end

close(h);
x=0;
h=waitbar(x,'loading...');

 for n=1:no_images
    I=imread(sprintf('Feedtum/mix_subjects/%d.jpg',n)); 
    
   %I=imread('C:\\Users\\Administrator\\Documents\\MATLAB\\Feedtum\\3.jpg');
    feature_extraction %-------------------Features Extraction Module------------------------------------------------------------------------------------%
    
    all_muscle_distance_vectors(:,n) = muscle_distance_vector(:,1); % concatenation of vectors in one matrix.
%     printing_control_points
%     pause(1);
  x=(n-1)/(no_images-1);
waitbar(x,h,'loading...');  
 end %end of for loop
 close(h);
 
feature_vectors = zeros(no_feat,no_images); % Initialization of vector variation matrix.
for i=1:no_images
    if(mod(i,10)==0)
        feature_vectors(:,i) = bsxfun(@rdivide, all_muscle_distance_vectors(:,i), neutral_muscle_vector(:,no_persons)); %------difference(seperation) from neutral face-------------%
    else
        feature_vectors(:,i) = bsxfun(@rdivide, all_muscle_distance_vectors(:,i), neutral_muscle_vector(:,mod(i,10))); %------difference(seperation) from neutral face-------------%
    end
    
end
handles.filename1=feature_vectors;
handles.filename2=no_images_per_emotion;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton5.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% set(handles.text2,'Visible','on');

feature_vectors=handles.fname;
neutral_muscle_vector=handles.fname_n;
h = msgbox('Trained');
pause(1);
close(h);
handles.fname_n=neutral_muscle_vector;
handles.fname=feature_vectors;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
number2 = str2num(get(handles.edit2,'string'));
axes(handles.axes4);
feature_vectors=handles.fname;

neutral_muscle_vector=handles.fname_n;


imshow(sprintf('inhouse_test/%d.jpg',number2));
% handles.filename3=I;

handles.fname2=number2;
handles.fname=feature_vectors;
handles.fname_n=neutral_muscle_vector;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

feature_vectors=handles.filename1;
no_images_per_emotion=handles.filename2;
svm_training_onevsone
%  handles.filename3=svmStruct_HvS;
%  handles.filename4=svmStruct_HvD; 
%  handles.filename5=svmStruct_HvA ;
%  handles.filename6=svmStruct_HvSu ;
%  handles.filename7=svmStruct_SvD;
%  handles.filename8=svmStruct_SvA ;
%  handles.filename9=svmStruct_SvSu ;
%  handles.filename10=svmStruct_DvA ;
%  handles.filename11=svmStruct_DvSu ;
%  handles.filename12=svmStruct_AvSu;
h = msgbox('Trained');
pause(1);
close(h);
handles.filename1=feature_vectors;
handles.filename2=no_images_per_emotion;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pushbutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

number = str2num(get(handles.edit1,'string'));
axes(handles.axes5);
feature_vectors=handles.filename1;
no_images_per_emotion=handles.filename2;
 handles.filename1=feature_vectors;
handles.filename2=no_images_per_emotion;

handles.filename3=number;
imshow(sprintf('Feedtum/mix_subjects1/%d.jpg',number));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function pushbutton7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in test_inhouse.
function test_inhouse_Callback(hObject, eventdata, handles)
% hObject    handle to test_inhouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

feature_vectors=handles.fname;
number2=handles.fname2;
neutral_muscle_vector=handles.fname_n;
distance_testing2
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function test_inhouse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to test_inhouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in test_feedtum.
function test_feedtum_Callback(hObject, eventdata, handles)
% hObject    handle to test_feedtum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
feature_vectors=handles.filename1;
no_images_per_emotion=handles.filename2;
number=handles.filename3;
svm_training_onevsone
svm_testing_gui
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function test_feedtum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to test_feedtum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3

% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4
% --- Executes during object creation, after setting all properties.

function axes5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



%function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
feature_vectors=handles.filename1;
no_images_per_emotion=handles.filename2;
no_test=50;
no_emotions=5;
no_test_persons=10;
no_feat=21;

neutral_muscle_vector_test=zeros(no_feat,no_test_persons);

for n=1:no_test_persons;
I=imread(sprintf('Feedtum/mix_subjects1/0%d.jpg',n));
    feature_extraction
   neutral_muscle_vector_test(:,n)= muscle_distance_vector(:,1);
end
confusion_matrix
guidata(hObject, handles);    

% --- Executes during object creation, after setting all properties.
function pushbutton13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
