function varargout = basic_annotation_tool(varargin)
% BASIC_ANNOTATION_TOOL MATLAB code for basic_annotation_tool.fig
%      BASIC_ANNOTATION_TOOL, by itself, creates a new BASIC_ANNOTATION_TOOL or raises the existing
%      singleton*.
%
%      H = BASIC_ANNOTATION_TOOL returns the handle to a new BASIC_ANNOTATION_TOOL or the handle to
%      the existing singleton*.
%
%      BASIC_ANNOTATION_TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASIC_ANNOTATION_TOOL.M with the given input arguments.
%
%      BASIC_ANNOTATION_TOOL('Property','Value',...) creates a new BASIC_ANNOTATION_TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before basic_annotation_tool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to basic_annotation_tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help basic_annotation_tool

% Last Modified by GUIDE v2.5 22-Apr-2018 11:37:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @basic_annotation_tool_OpeningFcn, ...
	'gui_OutputFcn',  @basic_annotation_tool_OutputFcn, ...
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

% --- Executes just before basic_annotation_tool is made visible.
function basic_annotation_tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to basic_annotation_tool (see VARARGIN)

% Choose default command line output for basic_annotation_tool
handles.output = hObject;


% UIWAIT makes basic_annotation_tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);
handles.result = table([],[],[],[],[],[],[],[],'VariableNames',{'ID','FrameNumber','Class','x','y','w','h','Outside'});
set(findobj('Enable','on'),'Enable','off')
set(handles.openbutton,'enable','on');
imshow(0.94)
handles.last_object_id = 1;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = basic_annotation_tool_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
	open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
	['Close ' get(handles.figure1,'Name') '...'],...
	'Yes','No','Yes');
if strcmp(selection,'No')
	return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on slider movement.
function videoslider_Callback(hObject, eventdata, handles)
% hObject    handle to videoslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(hObject,'Value',round(get(hObject,'Value')));
handles.video_framenumber = get(hObject,'Value');
display_data(hObject, handles);
guidata(hObject, handles);
drawnow


% --- Executes during object creation, after setting all properties.
function videoslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to videoslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% try
[handles.video_filename, handles.video_pathname]=uigetfile({'*.avi';'*.wmv';'*.mp4';'*.*'},'Open Video File');
handles.video_obj = VideoReader([handles.video_pathname '\' handles.video_filename]);
handles.video_framenumber = 1;
handles.last_frame_number = get(handles.video_obj,'NumberOfFrames');
set(handles.videoslider,'Value',1,'Min',1,'Max',handles.last_frame_number,'SliderStep',[1/handles.last_frame_number 1/handles.last_frame_number*10]);
display_data(hObject, handles);
guidata(hObject, handles);
set(findobj('Enable','off'),'Enable','on')
% catch
% end



% --- Executes on button press in playpausebutton.
function playpausebutton_Callback(hObject, eventdata, handles)
% hObject    handle to playpausebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
set(handles.rewindbutton,'Value',0)
while get(hObject,'Value') && handles.last_frame_number > handles.video_framenumber
	handles.video_framenumber = handles.video_framenumber+1;
	set(handles.videoslider,'Value',handles.video_framenumber)
	handles.video_framenumber
	handles.last_frame_number
	display_data(hObject, handles);
	guidata(hObject, handles);
	drawnow
	pause(1/25)
end
set(handles.playpausebutton,'Value',0)
catch
end


% --- Executes on button press in rewindbutton.
function rewindbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rewindbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.playpausebutton,'Value',0)
while get(hObject,'Value') && 1 < handles.video_framenumber
	handles.video_framenumber = handles.video_framenumber-1;
	set(handles.videoslider,'Value',handles.video_framenumber)
	display_data(hObject, handles);
	guidata(hObject, handles);
	drawnow
	pause(1/25)
end
set(handles.rewindbutton,'Value',0)

% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
annotation_table=handles.result;
name=[handles.video_filename(1:end-4) '_' datestr(now,'yyyymmddHHMMSS')];
uisave('annotation_table',name);


function nametextbox_Callback(hObject, eventdata, handles)
% hObject    handle to nametextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nametextbox as text
%        str2double(get(hObject,'String')) returns contents of nametextbox as a double


% --- Executes during object creation, after setting all properties.
function nametextbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nametextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in objectspopupmenu.
function objectspopupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to objectspopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns objectspopupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from objectspopupmenu


% --- Executes during object creation, after setting all properties.
function objectspopupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to objectspopupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
	set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addbutton.
function addbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% rectangle_drawn =
% handles.objects{end+1}={imrect(handles.axes1),handles.video_framenumber};
zoom off
pan off
datacursormode off
draw_rect(hObject, handles);

% --- Executes on button press in removethisbutton.
function removethisbutton_Callback(hObject, eventdata, handles)
% hObject    handle to removethisbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.objectspopupmenu,'String'));
IDs=get(handles.objectspopupmenu,'UserData');
ID_to_remove = get(handles.objectspopupmenu,'Value');
new_indices=[1:ID_to_remove-1 ID_to_remove+1:length(contents)];
if ~isempty(new_indices)
Framenumber = handles.video_framenumber;
array = handles.result(handles.result.ID==IDs(ID_to_remove),:);
array2 = array.FrameNumber;
firstset = array2(1);

if firstset ~= Framenumber
if Framenumber ~= 1
handles.result(handles.result.ID==IDs(ID_to_remove) & handles.result.FrameNumber==Framenumber,:)=[];
display_data(hObject, handles);
guidata(hObject, handles);
end
else
    warndlg('On the first frame, you can use the Remove Selected Object button!','Warning');
end
else
warndlg('Fail, object list is empty!','Warning');
end

% --- Executes on button press in removebutton.
function removebutton_Callback(hObject, eventdata, handles)
% hObject    handle to removebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.objectspopupmenu,'String'));
IDs=get(handles.objectspopupmenu,'UserData');
if ~isempty(IDs)
ID_to_remove = get(handles.objectspopupmenu,'Value');
handles.result(handles.result.ID==IDs(ID_to_remove),:)=[];
new_indices=[1:ID_to_remove-1 ID_to_remove+1:length(contents)];
if ~isempty(new_indices)
	set(handles.objectspopupmenu,'String',char(contents(new_indices)));
	set(handles.objectspopupmenu,'UserData',IDs(new_indices));
else
	set(handles.objectspopupmenu,'String',' ');
	set(handles.objectspopupmenu,'UserData',[]);
end
display_data(hObject, handles);
guidata(hObject, handles);
else
 warndlg('Fail, object list is empty!','Warning');
end

% --- Executes on button press in restartvideobutton.
function restartvideobutton_Callback(hObject, eventdata, handles)
% hObject    handle to restartvideobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.rewindbutton,'Value',0)
set(handles.playpausebutton,'Value',0)
handles.video_framenumber = 1;
set(handles.videoslider,'Value',handles.video_framenumber)
display_data(hObject, handles);
drawnow
guidata(hObject, handles);


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Modify mouse pointer over axes
if iscell(get(handles.figure1,'WindowButtonDownFcn'))
	return
end
fig = matlab.ui.internal.getPointerWindow();
if fig~=0
	point=get(handles.axes1, 'CurrentPoint');
	x=point(1,1);
	y=point(1,2);
	if x>=0 && y>=0
		rects = findobj(get(handles.axes1,'Children'),'flat','Type','rectangle');
		if ~isempty(rects)
			for c=rects'			
				r=get(c,'Position');
				if ( (x>=r(1)) && (x<=r(1)+1) && (y>=r(2)) && (y<=r(2)+1) )
					set(handles.figure1,'Pointer','topl');
					break
				elseif ( (x>=r(1)+r(3)-1) && (x<=r(1)+r(3)) && (y>r(2)+r(4)-1) && (y<r(2)+r(4)) )
					set(handles.figure1,'Pointer','botr');
					break
				elseif ( (x>=r(1)+r(3)-1) && (x<=r(1)+r(3))  && (y>=r(2)) && (y<=r(2)+1)  )
					set(handles.figure1,'Pointer','topr');
					break
				elseif ( (x>=r(1)) && (x<=r(1)+1) && (y>r(2)+r(4)-1) && (y<r(2)+r(4)) )
					set(handles.figure1,'Pointer','botl');
					break
				elseif ( (x>=r(1)) && (x<=r(1)+1) && (y>r(2)+1) && (y<r(2)+r(4)-1) )
					set(handles.figure1,'Pointer','left');
					break
				elseif ( (x>=r(1)+r(3)-1) && (x<=r(1)+r(3)) && (y>r(2)+1) && (y<r(2)+r(4)-1) )
					set(handles.figure1,'Pointer','right');
					break
				elseif ( (x>r(1)+1) && (x<r(1)+r(3)-1) && (y>=r(2)) && (y<=r(2)+1) )
					set(handles.figure1,'Pointer','top');
					break
				elseif ( (x>r(1)+1) && (x<r(1)+r(3)-1) && (y>r(2)+r(4)-1) && (y<r(2)+r(4)) )
					set(handles.figure1,'Pointer','bottom');
					break
				elseif ( (x>r(1)+1) && (x<r(1)+r(3)-1) && (y>r(2)+1) && (y<r(2)+r(4)-1) )
					set(handles.figure1,'Pointer','fleur');
					break
				else
					set(handles.figure1,'Pointer','arrow');
				end
			end
		end
	end
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resize_replace_rect(hObject,handles)


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
framenum=round(get(handles.videoslider,'Value'));
switch(eventdata.Key)
	case 'a'
		framenum=max(framenum-1,1);
	case 'd'
		framenum=min(framenum+1,handles.last_frame_number);
	case 'w'
		framenum=min(framenum+10,handles.last_frame_number);
	case 's'
		framenum=max(framenum-10,1);
end
set(handles.videoslider,'Value',framenum);
videoslider_Callback(handles.videoslider, eventdata, handles)

% --- Executes on button press in openannotationbutton.
function openannotationbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openannotationbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% try
[handles.annotation_filename, handles.annotation_pathname]=uigetfile({'*.mat';'*.*'},'Open Annotation File');
load([handles.annotation_pathname '\' handles.annotation_filename]);
handles.result = annotation_table;
handles.last_object_id = max(handles.result.ID)+1;
[IDs, indices]=unique(handles.result.ID);
objectspopupmenu_contents=cell(length(IDs),1);
for ind=1:length(IDs)
	objectspopupmenu_contents{ind}=sprintf('%s_%02d',char(handles.result.Class(indices(ind))),IDs(ind));
end
set(handles.objectspopupmenu,'String',char(objectspopupmenu_contents));
set(handles.objectspopupmenu,'UserData',IDs);
display_data(hObject, handles);
guidata(hObject, handles);
% catch
% end


% --- Executes on button press in exportbutton.
function exportbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exportbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
name=[handles.video_filename(1:end-4) '_' datestr(now,'yyyymmddHHMMSS')];
[filename, pathname] = uiputfile({'*.xml','Vatic XML';...
          '*.*','All Files' },'Save Results to Vatic XML format',...
          [name '.xml']);
interpolated_annotation_table=interpolate_annotation(handles.result);
xmlDocument=table2xml(interpolated_annotation_table);
if ~isequal(filename,0) && ~isequal(pathname,0)
    xmlwrite([pathname,'\',filename],xmlDocument);
    struct = xml2struct([pathname,'\',filename]);
    json = jsonencode(struct);
    fid = fopen(strcat(name,'.json'), 'w');
    if fid == -1, error('Cannot create JSON file'); end
    fwrite(fid, json, 'char');
    fclose(fid); 
end





% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkboxvalue = get(handles.checkbox1,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox1
