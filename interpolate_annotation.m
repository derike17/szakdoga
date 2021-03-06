function interpolated_annotation_table=interpolate_annotation(annotation_table)
annotation_table=sortrows(annotation_table,{'ID','FrameNumber'},{'ascend','ascend'})
interpolated_annotation_table = table([],[],[],[],[],[],[],[],...
    'VariableNames',{'ID','FrameNumber','Class','x','y','w','h','Outside'});
IDs=annotation_table.ID;
for ID=unique(IDs)'
    object_table = annotation_table(annotation_table.ID==ID,:);
    annotated_frames = object_table.FrameNumber;
    for annotated_frames_number = 1:length(annotated_frames)-1
        frames_to_interpolate=object_table.FrameNumber(annotated_frames_number):...
            object_table.FrameNumber(annotated_frames_number+1)-1;
        pos = interpolate_position_size(table2array(object_table(annotated_frames_number,4:7)),...
            table2array(object_table(annotated_frames_number+1,4:7)),...
            object_table.FrameNumber(annotated_frames_number),...
            object_table.FrameNumber(annotated_frames_number+1),...
            frames_to_interpolate);
        for i = 1:length(frames_to_interpolate)
        interpolated_annotation_table = [interpolated_annotation_table;...
            table(repmat(ID,1,1),...
            frames_to_interpolate(i),...
            repmat(object_table.Class(1),1,1),...
            pos(i,1),pos(i,2),pos(i,3),pos(i,4),object_table.Outside(annotated_frames_number),...
            'VariableNames',{'ID','FrameNumber','Class','x','y','w','h','Outside'})];
    end
    end
    interpolated_annotation_table = [interpolated_annotation_table;object_table(end,:)]
end
end
