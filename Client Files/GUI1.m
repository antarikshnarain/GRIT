function varargout = GUI1(varargin)
% GUI1 MATLAB code for GUI1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI1

% Last Modified by GUIDE v2.5 29-Oct-2015 00:04:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI1_OpeningFcn, ...
    'gui_OutputFcn',  @GUI1_OutputFcn, ...
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


% --- Executes just before GUI1 is made visible.
function GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI1 (see VARARGIN)

% Choose default command line output for GUI1
handles.output = hObject;

global flag bc y chatc chatFlag J modeFlag
axes(handles.axes1);
set(handles.text2,'Visible','off');
cam=webcam;
i=1;
oldbc=0;
flag=1;
modeFlag=0;
set(handles.pushbutton7,'Visible','off');
func='null'
oldx=0;
oldy=0;
startFlag=0;
chatFlag=0;
A=imresize(imread('aa.jpg'),[480,640]);
size(A)
B=imresize(imread('ab.jpg'),[480,640]);
C=imresize(imread('ac.jpg'),[480,640]);
t=[A,B,C];
cursw=2;
cursw = slide(t,size(A),cursw,60);
J=uint8(zeros(480,640,3));
while flag==1
    
    data = fliplr(snapshot(cam));
    %diff_im = imsubtract(data(:,:,1), rgb2gray(data));
    ycbcr=rgb2ycbcr(data);
    diff_im=ycbcr(:,:,3);
    diff_im = medfilt2(diff_im, [3 3]);
    diff_im = im2bw(diff_im,0.65);
    diff_im = bwareaopen(diff_im,300);
    bw = bwlabel(diff_im, 8);
    stats = regionprops(bw, 'BoundingBox', 'Centroid');
    
    if and(cursw==2,modeFlag==1)
        J=J+bw2rgb(diff_im);
    end
    %     img=data+bw2rgb(diff_im);
    %     imshow(img)
    
    
    %This is a loop to bound the red objects in a rectangular box.
    if modeFlag==0
        %hold on
        %for object = 1:length(stats)
        if length(stats)==1
            object=1;
            bb = stats(object).BoundingBox;
            bc = stats(object).Centroid;
            rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
            %plot(bc(1),bc(2), '-ro')
            %func=getButton(bc(1),480-bc(2));
            %         a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
            %         set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
            if startFlag==0
                startFlag=1;
                oldx=bc(1);
                oldy=bc(2);
            end
           % hold off
        elseif and(length(stats)==0,startFlag==1)
                disp('Swipe Detected.');
                hold off
                cursw = slide(t,size(A),cursw,round(oldx-bc(1)))
                round(oldx-bc(1))
                chatFlag=0;
            if and(and(cursw==1,abs(oldy-bc(2))>10),chatFlag==1)
                disp('Scroll Up/Down');
                y=chatscroll(A,chatc,y,round(oldy-bc(2)));
            end
            startFlag=0;
            oldx=0;
        end
        if cursw==3
            set(handles.text2,'Visible','on');
        else
            set(handles.text2,'Visible','off');
        end
    else
        img=J+B;
        imshow(img);
    end
    
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI1_OutputFcn(hObject, eventdata, handles)
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
global t
requestID='4';
fprintf(t,'%s',requestID);
while t.bytesAvailable==0
end
K=fread(t,t.bytesAvailable);
local_sid=get(handles.edit2,'String');
local_message=get(handles.edit1,'String');
if isempty(char(local_sid))==1
    msgbox('No Sid Defined');
    return;
elseif isempty(char(local_message))==1
    msgbox('Message Box Empty');
    return;
end
fprintf(t,local_sid);
while t.bytesAvailable==0
end
K=fread(t,t.bytesAvailable);
fprintf(t,local_message);
disp('Data Sent')

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t
str='Your Unseen Messages';
requestID='2';
fprintf(t,'%s',requestID);
while 1
    while t.bytesAvailable==0
    end
    mystr=fread(t,t.bytesAvailable);
    mystr=char(mystr');
    fprintf(t,'%s','Recv');
    if strcmp(mystr,'NULL')==1
        break
    end
    str=strcat(str,mystr);
end
str
set(handles.text2,'String',str);
disp('Done Getting Data')
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t chatc y chatFlag
str='';
requestID='3';
fprintf(t,'%s',requestID);
while t.bytesAvailable==0
end
K=fread(t,t.bytesAvailable);
local_sid=get(handles.edit2,'String');
uid=get(handles.edit4,'String');
if isempty(char(local_sid))==1
    msgbox('No Sid Defined');
    return;
end
fprintf(t,local_sid);
chatc=[];
pos=0;
oldpos=0;
while 1
    while t.bytesAvailable==0
    end
    id=fread(t,t.bytesAvailable);
    pos=str2num(char(id'))
    fprintf(t,'%s','Recv');
    while t.bytesAvailable==0
    end
    mystr=fread(t,t.bytesAvailable);
    mystr=char(mystr');
    fprintf(t,'%s','Recv');
    if strcmp(mystr,'NULL')==1
        break
    end
    str=strcat(str,mystr);
    chatc=chat(chatc,mystr,pos,~xor(pos,oldpos));
    imshow(chatc);
    oldpos=pos;
end
A=imread('aa.jpg');
[e,y]=chatconcat(A,chatc,0);
imshow(e);
str
set(handles.text2,'String',str);
chatFlag=1;
disp('Done Getting Chat')
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t
requestID='1';
fprintf(t,'%s',requestID);
while t.bytesAvailable==0
end
K=fread(t,t.bytesAvailable);
Id=get(handles.edit4,'String');
Name=get(handles.edit5,'String');
fprintf(t,'%s',Id);
while t.bytesAvailable==0
end
tmp=fread(t,t.bytesAvailable);
fprintf(t,'%s',Name);
while t.bytesAvailable==0
end
ret=fread(t,t.bytesAvailable)-48;
if ret==1
    set(handles.text7,'String','CONNECTED !');
    set(handles.pushbutton1,'Visible','on');
    set(handles.pushbutton2,'Visible','on');
    set(handles.pushbutton3,'Visible','on');
    set(handles.pushbutton6,'Visible','on');
else
    set(handles.text7,'String','DISCONNECTED !');
    return;
end
fprintf('Logged In As %s %s',Id,Name);

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


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider2.
function slider2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t connection flag
flag=0;
requestID='6';
if connection==1
    fprintf(t,'%s',requestID);
    fclose(t);
end
close('GUI1');
disp('Session OVER')
return;
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t connection flag
flag=0;
requestID='5';
if connection==1
    fprintf(t,'%s',requestID);
    fclose(t);
end
close('GUI1');
disp('Session OVER')
return;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J
K=255-J; % complement the image
imwrite(K,'msg.jpg','jpg');
addpath 'ex4';
load wtsn4;
load p;
load c;
str=getWord(K,Theta1,Theta2,plist);
st=get(handles.edit1,'String');
st=strcat(st,' ');
st=strcat(st,str);
set(handles.edit1,'String',st);
J=uint8(zeros(480,640,3));
disp('Image Loaded');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modeFlag
if modeFlag==1
    modeFlag=0;
    set(handles.pushbutton7,'Visible','off');
    J=uint8(zeros(480,640,3));
else
    modeFlag=1;
     J=uint8(zeros(480,640,3));
    set(handles.pushbutton7,'Visible','on');
end
