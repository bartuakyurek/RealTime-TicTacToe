function [croppedBoard, boardBoundingBox] = detectBoard(Ig)

K = wiener2(Ig,[13 13]); %noise filtering

BN = edge(K,'prewitt'); % canny/sobel/prewitt edge detection --> best results: sobel and prewitt

%we can also threshold this edge detection.. https://www.uio.no/studier/emner/matnat/ifi/INF4300/h09/undervisningsmateriale/hough09.pdf

%x1 = 100, x2 = 1000, y1 = 60, y2 = 700;
%BN = imcrop(BN,[x1 y1 x2 y2]);

se = strel('disk',3);
BN = imdilate(BN, se);
se = strel('line',13,20);
BN = imdilate(BN, se);

%subplot(2,1,1), imshow(BN); 

threshold = 100;

[BW,~] = segmentImage(Ig, 'white', 110, false); 
%imshow(BW)

show = false;
 % subplot(2,1,1);
 % imshow(BN);
 
  cc = bwconncomp(BW, 4); 
  tictac_data = regionprops(cc, 'all');
    
  t_en = [tictac_data.EulerNumber];
  t_area = [tictac_data.Area];
 
  [~,maxInd] = max(t_area);
  bb = tictac_data(maxInd).BoundingBox;

   BN = imcrop(BN, bb);
  
%hold on
  
[lines0,bb0] = showHoughLines(BN,'Theta',-90,-80,threshold,5, show);
[lines90,bb90] = showHoughLines(BN,'Theta',-10,10,threshold,5, show);
[lines_90,bb_90] = showHoughLines(BN,'Theta',80,89,threshold,5, show);

%hold off



% Connected component analysis
 %cc = bwconncomp(BW, 4);

% Region Properties
 %tictac_data = regionprops(cc, 'all');
 
% t_en = [tictac_data.EulerNumber];
 %t_area = [tictac_data.Area];
  
  bbL = [bb0(1) bb0(3) bb90(1) bb90(3) bb_90(1) bb_90(3)];
  bbU = [bb0(2) bb0(4) bb90(2) bb90(4) bb_90(2) bb_90(4)];
 
%  
  lowX = min(bbL, [], 'all');
  upX =  max(bbL, [], 'all');
  lowY = min(bbU, [], 'all');
  upY = max(bbU, [], 'all');
 
 boardBoundingBox = [lowX lowY upX-lowX upY-lowY];

%subplot(2,1,1);
%rgb = insertObjectAnnotation(Ig, 'rectangle', boardBoundingBox,'BOARD', 'LineWidth',5);
%imshow(rgb); 
%title('Result of image segmentation');

croppedBoard = imcrop(Ig,boardBoundingBox);

end
