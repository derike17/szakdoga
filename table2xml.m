function docNode=table2xml(matlabTable)
matlabTable=interpolate_annotation(matlabTable);
docNode = com.mathworks.xml.XMLUtils.createDocument('annotations');
countValue=max(matlabTable.ID);
annotations = docNode.getDocumentElement;
annotations.setAttribute('count',num2str(countValue));
IDs=matlabTable.ID;
for ID=unique(IDs)'
    objectTable = matlabTable(matlabTable.ID==ID,:);
    trackElement = docNode.createElement('track');
    trackElement.setAttribute('id',num2str(ID-1));
    trackElement.setAttribute('label',objectTable.Class{1});
    annotatedFrames = objectTable.FrameNumber;
    for annotated_frames_number = 1:length(annotatedFrames)
       boxElement = docNode.createElement('box');
       boxElement.setAttribute('frame',num2str(annotatedFrames(annotated_frames_number)));
       boxElement.setAttribute('xtl',num2str(objectTable.x(annotated_frames_number)));
       boxElement.setAttribute('ytl',num2str(objectTable.y(annotated_frames_number)));
       boxElement.setAttribute('xbr',num2str(objectTable.x(annotated_frames_number)+...
           objectTable.w(annotated_frames_number)));
       boxElement.setAttribute('ybr',num2str(objectTable.h(annotated_frames_number)+...
           objectTable.y(annotated_frames_number)));
       boxElement.setAttribute('outside',num2str(objectTable.Outside(annotated_frames_number)));
       boxElement.setAttribute('occluded','0');
       trackElement.appendChild(boxElement);
    end
    annotations.appendChild(trackElement);
end
end