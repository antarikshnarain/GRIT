function varargout = Client_GUI(varargin)
% CLIENT_GUI MATLAB code for Client_GUI.fig
%      CLIENT_GUI, by itself, creates a new CLIENT_GUI or raises the existing
%      singleton*.
%
%      H = CLIENT_GUI returns the handle to a new CLIENT_GUI or the handle to
%      the existing singleton*.
%
%      CLIENT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLIENT_GUI.M with the given input arguments.
%
%      CLIENT_GUI('Property','Value',...) creates a new CLIENT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Client_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Client_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Client_GUI

% Last Modified by GUIDE v2.5 27-Oct-2015 21:54:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Client_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @Client_GUI_OutputFcn, ...
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


% --- Executes just before Client_GUI is made visible.
function Client_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Client_GUI (see VARARGIN)

% Choose default command line output for Client_GUI
handles.output = hObject;
global flag
axes(handles.axes1);
cam=webcam;
flag=1;
J=snapshot(cam)*0;
func='null'
color=1;
while flag==1
    data = fliplr(snapshot(cam));
    diff_im = imsubtract(data(:,:,color), rgb2gray(data));
    diff_im = medfilt2(diff_im, [3 3]);
    diff_im = im2bw(diff_im,0.18);
    diff_im = bwareaopen(diff_im,300);
    bw = bwlabel(diff_im, 8);
    stats = regionprops(bw, 'BoundingBox', 'Centroid');
    
    if isempty(stats)==1
        if strcmp('Leave',func)==1
            leave();
            fprintf('%s',func);
        elseif strcmp('Login',func)==1
            ret=login();
            if ret==1
                set(handles.text2,'String','CONNECTED !');
            else
                set(handles.text2,'String','DISCONNECTED !');
            end
            fprintf('%s',func);
        elseif strcmp('Exit',func)==1
            fprintf('%s',func);
            exitGUI();
        elseif strcmp('Unread',func)==1
            fprintf('%s',func);
        elseif strcmp('Chat',func)==1
            fprintf('%s',func);
        elseif strcmp('Save',func)==1
            if color==1
                color=3;
            else
                color=1;
            end
            fprintf('%s',func);
        end
    end
    
    % Display the imagae
    J=J+bw2rgb(diff_im);
    img=data+J;
    imshow(img);
    
    hold on
    %This is a loop to bound the red objects in a rectangular box.
    for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        func=getButton(bc(1),480-bc(2));
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    end
    hold off
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Client_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Client_GUI_OutputFcn(hObject, eventdata, handles)
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
login();

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
leave();

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exitGUI();

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
