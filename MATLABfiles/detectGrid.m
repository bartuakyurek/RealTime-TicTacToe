%similar to detectBoard.m, this function checks hough transform and image
%segmentation for grid properties

function [croppedGrid, gridBoundingBox] = detectGrid(croppedBoard)

[BW,~] = segmentImage(croppedBoard, 'black',0, false);

se = strel('disk',3);
BW = imdilate(BW, se);
se = strel('line',13,20);
BW = imdilate(BW, se);

threshold = 600; gap = 500;

show = false;
% subplot(2,1,1);
% imshow(BW);
% hold on
[lines0,~] = showHoughLines(BW,'Theta',-90,-80,threshold,gap, show);
[lines90,~] = showHoughLines(BW,'Theta',-10,10,threshold,gap, show);
[lines_90,~] = showHoughLines(BW,'Theta',80,89,threshold,gap, show);
%hold off

if(isempty(lines0) && isempty(lines90) && isempty(lines_90))
    croppedGrid = 0;
    gridBoundingBox = 0;
    
else
    % Connected component analysis
    cc = bwconncomp(BW, 4);
    
    % Region Properties
    tictac_data = regionprops(cc, 'all');
    
    t_en = [tictac_data.EulerNumber];
    t_area = [tictac_data.Area];
    t_major = [tictac_data.MajorAxisLength];
    t_minor = [tictac_data.MinorAxisLength];
    
    % aboveThresholdIndexes = t_area > 70000;
    %  possible_grid = t_area(aboveThresholdIndexes)  %above 10k -> XOs +100k >> grid
    
    flag = 0;
    %  figure, imshow(BW);
  %    imageRegionAnalyzer(BW)
    
    max_area = max(t_area);
    
    for n = 1:cc.NumObjects
        t_a = t_area(n);
        t_e = t_en(n);
        t_min = t_minor(n);
        t_maj = t_major(n);
        
        if t_a > floor(max_area / 5)
           
            if t_e < 1 

                if floor(norm(t_maj - t_min)) < floor(max(t_maj, t_min)/ 3)
                    
                     flag = n;
                 end
            end
            

        end
    end
    
    if(flag == 0)
        croppedGrid = 0;
        gridBoundingBox = 0;
    else
        gridBoundingBox = tictac_data(flag).BoundingBox;
        croppedGrid = imcrop(croppedBoard,gridBoundingBox);
    end
    
    % subplot(2,1,2);
    % rgb = insertObjectAnnotation(croppedBoard, 'rectangle', gridBoundingBox, 'Grid', 'LineWidth',5);
    % imshow(rgb);
end

end