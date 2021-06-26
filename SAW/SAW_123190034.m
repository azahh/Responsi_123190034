function varargout = SAW_123190034(varargin)
% SAW_123190034 MATLAB code for SAW_123190034.fig
%      SAW_123190034, by itself, creates a new SAW_123190034 or raises the existing
%      singleton*.
%
%      H = SAW_123190034 returns the handle to a new SAW_123190034 or the handle to
%      the existing singleton*.
%
%      SAW_123190034('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_123190034.M with the given input arguments.
%
%      SAW_123190034('Property','Value',...) creates a new SAW_123190034 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_123190034_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_123190034_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW_123190034

% Last Modified by GUIDE v2.5 25-Jun-2021 22:02:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_123190034_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_123190034_OutputFcn, ...
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


% --- Executes just before SAW_123190034 is made visible.
function SAW_123190034_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW_123190034 (see VARARGIN)

% Choose default command line output for SAW_123190034
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW_123190034 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_123190034_OutputFcn(hObject, eventdata, handles) 
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
%data = xlsread('data_saw.xlsx','C2:H21');
%set(handles.uitable1,'data',data);    
opts = spreadsheetImportOptions("NumVariables", 8);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:H21";

% Specify column names and types
opts.VariableNames = ["NO", "Var2", "HARGA", "LB", "LT", "KT", "KM", "GRS"];
opts.SelectedVariableNames = ["NO", "HARGA", "LB", "LT", "KT", "KM", "GRS"];
opts.VariableTypes = ["double", "char", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "Var2", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "Var2", "EmptyFieldRule", "auto");

% Import the data
datasaw = readmatrix("data_saw.xlsx", opts);
set(handles.uitable1,'data',datasaw);  

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w = [0.3,0.2,0.23,0.1,0.07,0.1];
k = [0,1,1,1,1,1];
x = xlsread('data_saw.xlsx','C2:H1011');

[m,n]=size (x); 
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n
    if k(j)==1 %statement untuk kriteria dengan atribut benefit
        R(:,j)=x(:,j)./max(x(:,j));
    else %statement untuk kriteria dengan atribut cost
        R(:,j)=min(x(:,j))./x(:,j);
    end
end

for i=1:m
    V(i)= sum(w.*R(i,:)); %proses perhitungan nilai   
end



[peringkat, index] = sort(V, 'descend'); %mencari nilai maksimum beserta index dari nomor rumahnya
disp(index);
B = peringkat.'; %mentranpose bentuk matrik supaya menjadi vertikal
C = index.'; %mentranspose bentuk matrik supaya menjadi vertikal

hasil = [ C(1:20,:) B(1:20,:)]; %membatasi hasil output sebanyak 20 baris teratas



set(handles.uitable2, 'data', hasil); %menampilkan data yang telah diurutkan ke tabel
