function resize_replace_rect(hObject,handles)
ah = handles.axes1;
fh = handles.figure1;
rh = findobj(get(handles.axes1,'Children'),'flat','Type','rectangle');
x_bounds = get(ah, 'xlim');  y_bounds = get(ah, 'ylim');
min_w = (x_bounds(2) - x_bounds(1))/100;
min_h = (y_bounds(2) - y_bounds(1))/100;
p = get(ah,'currentpoint');
x1 = p(1,1); y1 = p(1,2);
if ~isempty(rh)
    for c=rh'
        r=get(c,'Position');
        if ( (x1>=r(1)) && (x1<=r(1)+1) && (y1>=r(2)) && (y1<=r(2)+1) )
            set(gcf,'Pointer','topl');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>=r(1)+r(3)-1) && (x1<=r(1)+r(3)) && (y1>r(2)+r(4)-1) && (y1<r(2)+r(4)) )
            set(gcf,'Pointer','botr');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>=r(1)+r(3)-1) && (x1<=r(1)+r(3))  && (y1>=r(2)) && (y1<=r(2)+1)  )
            set(gcf,'Pointer','topr');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>=r(1)) && (x1<=r(1)+1) && (y1>r(2)+r(4)-1) && (y1<r(2)+r(4)) )
            set(gcf,'Pointer','botl');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>=r(1)) && (x1<=r(1)+1) && (y1>r(2)+1) && (y1<r(2)+r(4)-1) )
            set(gcf,'Pointer','left');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>=r(1)+r(3)-1) && (x1<=r(1)+r(3)) && (y1>r(2)+1) && (y1<r(2)+r(4)-1) )
            set(gcf,'Pointer','right');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>r(1)+1) && (x1<r(1)+r(3)-1) && (y1>=r(2)) && (y1<=r(2)+1) )
            set(gcf,'Pointer','top');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>r(1)+1) && (x1<r(1)+r(3)-1) && (y1>r(2)+r(4)-1) && (y1<r(2)+r(4)) )
            set(gcf,'Pointer','bottom');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        elseif ( (x1>r(1)+1) && (x1<r(1)+r(3)-1) && (y1>r(2)+1) && (y1<r(2)+r(4)-1) )
            set(gcf,'Pointer','fleur');
            rh = c;
            set(rh ,'linestyle', ':');
            break
        else
            set(gcf,'Pointer','arrow');
        end
    end
end
set(fh,'WindowButtonMotionFcn',@buttonMove);
set(fh,'WindowButtonUpFcn', @buttonUp);
p_first=p;
current_object_id = get(rh,'UserData');
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
        
        switch (get(fh,'Pointer'))
            case 'topl'
                w = max(min_w,r(3) - (x2 - r(1)));
                h = max(min_h,r(4) - (y2 - r(2)));
                x1 = min(x2,r(1)+r(3)-min_w);
                y1 = min(y2,r(2)+r(4)-min_h);
            case 'botl'
                w = max(min_w,r(3) - (x2 - r(1)));
                x1 = min(x2,r(1)+r(3)-min_w);
                h = max(min_h,(y2 - r(2)));
                y1 = r(2);
            case 'topr'
                w = max(min_w,(x2 - r(1)));
                h = max(min_h,r(4) - (y2 - r(2)));
                x1 = r(1);
                y1 = min(y2,r(2)+r(4)-min_h);
            case 'botr'
                w = max(min_w,(x2 - r(1)));
                h = max(min_h,(y2 - r(2)));
                x1 = r(1);
                y1 = r(2);
            case 'left'
                w = max(min_w,r(3) - (x2 - r(1)));
                h=r(4);
                x1 = min(x2,r(1)+r(3)-min_w);
                y1 = r(2);
            case 'right'
                w = max(min_w,(x2 - r(1)));
                h=r(4);
                x1 = r(1);
                y1 = r(2);
            case 'bottom'
                w=r(3);
                x1 = r(1);
                h = max(min_h,(y2 - r(2)));
                y1 = r(2);
            case 'top'
                w=r(3);
                x1 = r(1);
                h = max(min_h,r(4) - (y2 - r(2)));
                y1 = min(y2,r(2)+r(4)-min_h);
            case 'fleur'
                w=r(3);
                h=r(4);
                x1 = r(1)-p_first(1,1)+x2;
                y1 = r(2)-p_first(1,2)+y2;
            otherwise
        end
        if exist('w','var')
            set(rh, 'Position', [x1, y1, w, h]);
        end
    end

    function buttonUp(fh,dummy)
        set(rh,'linestyle','-');
        ch = double((get(handles.checkbox1,'Value')));
        set(fh, 'WindowButtonMotionFcn', @(hObject,eventdata)basic_annotation_tool('figure1_WindowButtonMotionFcn',hObject,eventdata,guidata(hObject)));
        set(fh, 'WindowButtonUpFcn', '');
        set(fh, 'WindowButtonDownFcn', @(hObject,eventdata)basic_annotation_tool('figure1_WindowButtonDownFcn',hObject,eventdata,guidata(hObject)));
        if ~isempty(current_object_id)
            pos = get(rh, 'Position');
            if ~iscell(pos)
                if any(handles.result.ID==current_object_id & handles.result.FrameNumber == handles.video_framenumber)
                    handles.result(handles.result.ID==current_object_id & handles.result.FrameNumber == handles.video_framenumber,:)=...
                        table(current_object_id,handles.video_framenumber,...
                        {get(handles.nametextbox,'String')},pos(1),pos(2),pos(3),pos(4),ch,...
                        'VariableNames',{'ID','FrameNumber','Class','x','y','w','h','Outside'});
                else
                    handles.result = [handles.result;table(current_object_id,handles.video_framenumber,...
                        {get(handles.nametextbox,'String')},pos(1),pos(2),pos(3),pos(4),ch,...
                        'VariableNames',{'ID','FrameNumber','Class','x','y','w','h','Outside'})];
                end
                handles.result=sortrows(handles.result,{'ID','FrameNumber'},{'ascend','ascend'});
            end
        end
        guidata(hObject, handles);
    end
end