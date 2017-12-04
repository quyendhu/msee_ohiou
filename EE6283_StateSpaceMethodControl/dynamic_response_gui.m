function varargout = dynamic_response_gui(varargin)
% DYNAMIC_RESPONSE_GUI M-file for dynamic_response_gui.fig
%      DYNAMIC_RESPONSE_GUI, by itself, creates a new DYNAMIC_RESPONSE_GUI or raises the existing
%      singleton*.
%
%      H = DYNAMIC_RESPONSE_GUI returns the handle to a new DYNAMIC_RESPONSE_GUI or the handle to
%      the existing singleton*.
%
%      DYNAMIC_RESPONSE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DYNAMIC_RESPONSE_GUI.M with the given input arguments.
%
%      DYNAMIC_RESPONSE_GUI('Property','Value',...) creates a new DYNAMIC_RESPONSE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dynamic_response_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dynamic_response_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dynamic_response_gui

% Last Modified by GUIDE v2.5 15-Mar-2014 14:08:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dynamic_response_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @dynamic_response_gui_OutputFcn, ...
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


% --- Executes just before dynamic_response_gui is made visible.
function dynamic_response_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dynamic_response_gui (see VARARGIN)

dynamic_response_gui_init(handles)

% Choose default command line output for dynamic_response_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dynamic_response_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dynamic_response_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function damping_ratio_slider_Callback(hObject, eventdata, handles)
% hObject    handle to damping_ratio_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
zeta        = get(handles.damping_ratio_slider, 'Value');
set(handles.damping_ratio_editText, 'String', num2str(zeta, '%3.2f'));

dynamic_response_gui_update(handles)

% --- Executes during object creation, after setting all properties.
function damping_ratio_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damping_ratio_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function damping_ratio_editText_Callback(hObject, eventdata, handles)
% hObject    handle to damping_ratio_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damping_ratio_editText as text
%        str2double(get(hObject,'String')) returns contents of damping_ratio_editText as a double
zeta        = str2double( get(handles.damping_ratio_editText, 'String') );

if (isempty(zeta) || zeta < 0.1 || zeta > 0.8 )
    set(handles.damping_ratio_slider, 'Value', 0.1);
    set(handles.damping_ratio_editText, 'String', '0.1');
else
    set(handles.damping_ratio_slider, 'Value', zeta)
    set(handles.damping_ratio_editText, 'String', num2str(zeta, '%3.2f'))
end

dynamic_response_gui_update(handles)

% --- Executes during object creation, after setting all properties.
function damping_ratio_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damping_ratio_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function natural_frequency_slider_Callback(hObject, eventdata, handles)
% hObject    handle to natural_frequency_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
omega_n         = get(handles.natural_frequency_slider, 'Value');
set(handles.natural_frequency_editText, 'String', num2str(omega_n, '%3.2f'));

dynamic_response_gui_update(handles)

% --- Executes during object creation, after setting all properties.
function natural_frequency_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to natural_frequency_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function natural_frequency_editText_Callback(hObject, eventdata, handles)
% hObject    handle to natural_frequency_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of natural_frequency_editText as text
%        str2double(get(hObject,'String')) returns contents of natural_frequency_editText as a double
omega_n     = str2double( get(handles.natural_frequency_editText, 'String') );

if (isempty(omega_n) || omega_n < 1.0 || omega_n > 5.0 )
    set(handles.natural_frequency_slider, 'Value', 1.0);
    set(handles.natural_frequency_editText, 'String', '1.0');
else
    set(handles.natural_frequency_slider, 'Value', omega_n)
    set(handles.natural_frequency_editText, 'String', num2str(omega_n, '%3.2f'))
end

dynamic_response_gui_update(handles)

% --- Executes during object creation, after setting all properties.
function natural_frequency_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to natural_frequency_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Tp_editText_Callback(hObject, eventdata, handles)
% hObject    handle to Tp_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tp_editText as text
%        str2double(get(hObject,'String')) returns contents of Tp_editText as a double


% --- Executes during object creation, after setting all properties.
function Tp_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tp_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PO_editText_Callback(hObject, eventdata, handles)
% hObject    handle to PO_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PO_editText as text
%        str2double(get(hObject,'String')) returns contents of PO_editText as a double


% --- Executes during object creation, after setting all properties.
function PO_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PO_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tr_editText_Callback(hObject, eventdata, handles)
% hObject    handle to Tr_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tr_editText as text
%        str2double(get(hObject,'String')) returns contents of Tr_editText as a double


% --- Executes during object creation, after setting all properties.
function Tr_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tr_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ts_editText_Callback(hObject, eventdata, handles)
% hObject    handle to Ts_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ts_editText as text
%        str2double(get(hObject,'String')) returns contents of Ts_editText as a double


% --- Executes during object creation, after setting all properties.
function Ts_editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ts_editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dynamic_response_gui_init(handles)

%
% Parameters and arrays to define once
%
msize       = 20;
lwidth      = 1.5;
fsize       = 14;

angle       = (1:0.001:3)*pi/2;

%
% Initialize plots
%
zeta        = get(handles.damping_ratio_slider, 'Value');
omega_n     = get(handles.natural_frequency_slider, 'Value');

beta        = sqrt(1 - zeta^2);
pole        = -zeta*omega_n + j*beta*omega_n;

pole_x      = -zeta*omega_n * [1 1];
pole_y      = beta*omega_n * [1 -1];
semi_x      = omega_n * cos(angle);
semi_y      = omega_n * sin(angle);
line_x      = real(pole)*[0 1];
line_y_top  = imag(pole)*[0 1];
line_y_bot  = imag(pole)*[0 -1];

%
% Initialize text displays
%
[Tp, PO, Tr, Ts] = step_params(zeta, omega_n);

set(handles.Tp_editText, 'String', num2str(Tp, '%5.3f'));
set(handles.PO_editText, 'String', num2str(PO, '%3.1f'));
set(handles.Tr_editText, 'String', num2str(Tr, '%5.3f'));
set(handles.Ts_editText, 'String', num2str(Ts, '%5.3f'));

%
% Plot 1: Pole locations in the complex plane
%
p1          = plot(handles.axes1, pole_x, pole_y, 'xb', semi_x, semi_y, '--r', line_x, line_y_top, '--r',  line_x, line_y_bot, '--r');
%
% p1(4) : pole locations                    Why does it switch handles?????
% p1(2) : semi-circle
% p1(3) : top radial line
% p1(1) : bottom radial line
%
axis(handles.axes1, 'square')
grid(handles.axes1)
xlabel(handles.axes1, 'Real', 'FontSize', fsize)
ylabel(handles.axes1, 'Imag', 'FontSize', fsize)
set(p1(1), 'MarkerSize', msize)
set(p1(1), 'LineWidth', lwidth)
set(p1(2), 'LineWidth', lwidth)
set(p1(3), 'LineWidth', lwidth)
set(p1(4), 'LineWidth', lwidth)

%
% Plot 2: Unit step response vs time
%
t           = 0:0.001:10;
y           = 1 - exp(-zeta*omega_n * t) .* ( cos(beta*omega_n * t) + zeta/beta * sin(beta*omega_n * t) );


p2          = plot(handles.axes2, t, y);

grid(handles.axes2)
xlabel(handles.axes2, 'Time (s)', 'FontSize', fsize)
ylabel(handles.axes2, 'Output', 'FontSize', fsize)
set(p2, 'LineWidth', lwidth)

function dynamic_response_gui_update(handles)

%
% Read values
%
zeta        = get(handles.damping_ratio_slider, 'Value');
omega_n     = get(handles.natural_frequency_slider, 'Value');

%
% Update text displays
%
[Tp, PO, Tr, Ts] = step_params(zeta, omega_n);

set(handles.Tp_editText, 'String', num2str(Tp, '%5.3f'));
set(handles.PO_editText, 'String', num2str(PO, '%3.1f'));
set(handles.Tr_editText, 'String', num2str(Tr, '%5.3f'));
set(handles.Ts_editText, 'String', num2str(Ts, '%5.3f'));
%
% Set up handles to GUI axes
%
p1          = get(handles.axes1, 'Children');
p2          = get(handles.axes2, 'Children');

%
% Update plots
%
angle       = (1:0.001:3)*pi/2;
beta        = sqrt(1 - zeta^2);
pole        = -zeta*omega_n + j*beta*omega_n;

pole_x      = -zeta*omega_n * [1 1];
pole_y      =  beta*omega_n * [1 -1];
semi_x      = omega_n * cos(angle);
semi_y      = omega_n * sin(angle);
line_x      = real(pole)*[0 1];
line_y_top  = imag(pole)*[0 1];
line_y_bot  = imag(pole)*[0 -1];

set(p1(4), 'XDataSource', 'pole_x');
set(p1(4), 'YDataSource', 'pole_y');
refreshdata(p1(4), 'caller')              % Change 'base' to 'caller' inside functions

set(p1(2), 'XDataSource', 'semi_x');
set(p1(2), 'YDataSource', 'semi_y');
refreshdata(p1(2), 'caller')

set(p1(3), 'XDataSource', 'line_x');
set(p1(3), 'YDataSource', 'line_y_top');
refreshdata(p1(3), 'caller')

set(p1(1), 'XDataSource', 'line_x');
set(p1(1), 'YDataSource', 'line_y_bot');
refreshdata(p1(1), 'caller')

t           = 0:0.001:10;
y           = 1 - exp(-zeta*omega_n * t) .* ( cos(beta*omega_n * t) + zeta/beta * sin(beta*omega_n * t) );
set(p2, 'YDataSource', 'y');
refreshdata(p2, 'caller');

function [Tp, PO, Tr, Ts] = step_params(zeta, omega_n)

beta        = sqrt(1 - zeta^2);
Tp          = pi / beta / omega_n;
PO          = exp( -pi*zeta / beta) * 100;
%Tr          = (2.16*zeta + 0.6) / omega_n;
Tr          = (1.76*zeta^3 - 0.417*zeta + 1.039*zeta + 1) / omega_n;
Ts          = 4 / zeta / omega_n;
