function draw_rect(hObject,handles)
ah = handles.axes1;
fh = handles.figure1;
x_bounds = get(ah, 'xlim');  y_bounds = get(ah, 'ylim');
min_w = (x_bounds(2) - x_bounds(1))/100;
min_h = (y_bounds(2) - y_bounds(1))/100;
set(fh, 'WindowButtonDownFcn', @buttonDown);
    function buttonDown(fh, dummy)
        p = get(ah,'currentpoint');
        x1 = p(1,1); y1 = p(1,2);
        rh = rectangle('position', [x1,y1, min_w, min_h],'linestyle', ':');
        set(fh,'WindowButtonMotionFcn',@buttonMove);
        set(fh,'WindowButtonUpFcn', @buttonUp);
        
        function buttonMove(fh, dummy)
            
            p = get(ah,'currentpoint');
            x2 = p(1,1); y2 = p(1,2);
            
            % check and make sure they are within the bounds
            if x2 < x_bounds(1)
                x2 = x_bounds(1);
            elseif x2 > x_bounds(2);
                x2 = x_bounds(2);
            end
            
            if y2 < y_bounds(1)
                y2 = y_bounds(1);
            elseif y2 > y_bounds(2)
                y2 = y_bounds(2);
            end
            
            if x2 > x1 && y2 > y1
                x = x1; y = y1; w = x2 - x1; h = y2 - y1; 
            elseif x2 > x1 && y2 < y1
                x = x1; y = y2; w = x2 - x1; h = y1 - y2; 
            elseif x2 < x1 && y2 > y1
                x = x2; y = y1; w = x1 - x2; h = y2 - y1; 
            else
                x = x2; y = y2; w = x1 - x2; h = y1 - y2; 
            end
            if w < min_w
                w = min_w;
            end
            if h < min_h
                h = min_h;
            end
            set(rh, 'Position', [x, y, w, h]);			
        end
        
        function buttonUp(fh,dummy)
            get(handles.checkbox1,'Value');
            set(rh,'linestyle','-','UserData',handles.last_object_id);
            set(fh, 'WindowButtonMotionFcn', @(hObject,eventdata)basic_annotation_tool('figure1_WindowButtonMotionFcn',hObject,eventdata,guidata(hObject)));
            set(fh, 'WindowButtonUpFcn', '');
			set(fh, 'WindowButtonDownFcn', @(hObject,eventdata)basic_annotation_tool('figure1_WindowButtonDownFcn',hObject,eventdata,guidata(hObject)));
			pos = get(rh, 'Position');
			handles.result = [handles.result;table(handles.last_object_id,handles.video_framenumber,...
				{get(handles.nametextbox,'String')},pos(1),pos(2),pos(3),pos(4),get(handles.checkbox1,'Value'),...
				'VariableNames',{'ID','FrameNumber','Class','x','y','w','h','Outside'})];
            handles.result=sortrows(handles.result,{'ID','FrameNumber'},{'ascend','ascend'});
			if isempty(get(handles.objectspopupmenu,'String')) || strcmp(get(handles.objectspopupmenu,'String'),' ')
				objectspopupmenu_contents = {};
			else
				objectspopupmenu_contents = cellstr(get(handles.objectspopupmenu,'String'));
			end
			objectspopupmenu_contents{end+1}=sprintf('%s_%02d',get(handles.nametextbox,'String'),handles.last_object_id);
			IDs=get(handles.objectspopupmenu,'UserData');
			IDs=[IDs;handles.last_object_id];
			set(handles.objectspopupmenu,'String',char(objectspopupmenu_contents))
			set(handles.objectspopupmenu,'UserData',IDs)
			handles.last_object_id = handles.last_object_id+1;
			guidata(hObject, handles);
        end
    end
end