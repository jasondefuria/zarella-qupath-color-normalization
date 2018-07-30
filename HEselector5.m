function varargout = HEselector5(varargin)
% HESELECTOR5 MATLAB code for HEselector5.fig
%      HESELECTOR5, by itself, creates a new HESELECTOR5 or raises the existing
%      singleton*.
%
%      H = HESELECTOR5 returns the handle to a new HESELECTOR5 or the handle to
%      the existing singleton*.
%
%      HESELECTOR5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HESELECTOR5.M with the given input arguments.
%
%      HESELECTOR5('Property','Value',...) creates a new HESELECTOR5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HEselector5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HEselector5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HEselector5

% Last Modified by GUIDE v2.5 04-Jun-2014 14:19:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HEselector5_OpeningFcn, ...
                   'gui_OutputFcn',  @HEselector5_OutputFcn, ...
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


% --- Executes just before HEselector5 is made visible.
function HEselector5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HEselector5 (see VARARGIN)

% Choose default command line output for HEselector5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Parse input structures
global img cmap

img = varargin{1};
cmap = varargin{2};

% Display image
axes(handles.axes1);
imagesc(img);
colormap(cmap);

% Modify panel colors
for i = 1:10
    h = eval(['handles.uipanel' num2str(i)]);
    set(h,'BackgroundColor',cmap(i,:));
end

% UIWAIT makes HEselector5 wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HEselector5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

options = {'White','Nuclei','Stroma','Cytoplasm','RBC','No response'};

for i = 1:10
    h = eval(['handles.uipanel' num2str(i)]);
    str = get(get(h(end),'SelectedObject'),'String');
    varargout{1}(i) = find(ismember(options,str));
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton5

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton6

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton7

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton8.
function togglebutton8_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton8

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton9.
function togglebutton9_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton9

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in togglebutton10.
function togglebutton10_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton10

global cmap old_val

% determine which button
tag = get(hObject,'Tag');
which_button = str2double(tag(end-1:end));

%error trap
toggles = 0;
for i = 1:10
    h = eval(['handles.togglebutton' num2str(i)]);
    toggles = toggles + get(h,'Value');
end
if sum(toggles)>1
    h = eval(['handles.togglebutton' num2str(which_button)]);
    set(h,'Value',0);
    return
end

if get(hObject,'Value')
    old_val = cmap(which_button,:);
    cmap(which_button,:) = [0 1 0];
    colormap(cmap);
else
    cmap(which_button,:) = old_val;
    colormap(cmap);
end   


% --- Executes on button press in pushbutton1.

function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uiresume(handles.figure1);
