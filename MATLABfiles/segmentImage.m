function [BW,maskedImage] = segmentImage(X, str, threshold, process)
%segmentImage Segment image using auto-generated code from imageSegmenter app
%  [BW,MASKEDIMAGE] = segmentImage(X) segments image X using auto-generated
%  code from the imageSegmenter app. The final segmentation is returned in
%  BW, and a masked image is returned in MASKEDIMAGE.

% Auto-generated by imageSegmenter app on 19-Aug-2020
%----------------------------------------------------

if(threshold == 0)
    BW = imbinarize(X);
else
    BW = X > threshold;
end
% Invert mask
if str == 'black'
    BW = imcomplement(BW);
end

if process
  
     radius = 8;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imdilate(BW, se);

 
    % Open mask with disk
    radius = 3;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imopen(BW, se);

    
        % Erode mask with disk
    radius = 4;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imerode(BW, se);

    %     Close mask with disk
    radius = 3;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imclose(BW, se);
   
%     Dilate mask with disk
%     radius = 2;
%     decomposition = 0;
%     se = strel('disk', radius, decomposition);
%     BW = imdilate(BW, se);
    

    
end

% Create masked image.
maskedImage = X;
maskedImage(~BW) = 0;

end

