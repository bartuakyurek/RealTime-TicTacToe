function state = extractState(croppedGrid)

state = ['b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'];

croppedGrid = imresize(croppedGrid, [800 NaN]); %for consistency

[BW,~] = segmentImage(croppedGrid, 'black',0, true);


cc = bwconncomp(BW, 4);
cc.NumObjects;
tictac_data = regionprops(cc, 'all');

t_en = [tictac_data.EulerNumber];
t_area = [tictac_data.Area];
t_bounding = [tictac_data.BoundingBox];

%imageRegionAnalyzer(BW)

%I2 = croppedGrid;
row_mod = floor(size(croppedGrid,1)/3);
col_mod = floor(size(croppedGrid,2)/3);

for n = 1:cc.NumObjects
    
    t_a = t_area(n);
    t_e = t_en(n);
    t_bb = t_bounding(:,(n-1)*4+1:n*4);
  
    if t_a < 20000 && t_a > 2000
        if t_e == 1
            Shape = 'X';
        else
            Shape = 'O';
        end
        
        t_locX = floor(t_bb(1)/col_mod);
        t_locY = floor(t_bb(2)/row_mod);
        
        k = (t_locX+1) + (t_locY*3);
        
        state(k) = Shape;
        %rgb = insertObjectAnnotation(I2, 'rectangle', tictac_data(n).BoundingBox, Shape, 'Color', 'yellow');
        %imshow(rgb)       
        %I2 = rgb;
    end
    
    if t_a > 300000
        state(10) = 'b';
    end
end

if length(state) > 9
    state = ['b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'];
end

end