function [lines,bb] = showHoughLines(BW, str, angleLow, angleHigh,threshold,gap,show)

    [H,theta,rho] = hough(BW, str, angleLow:0.5:angleHigh);
    
    P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(BW,theta,rho,P,'FillGap',gap,'MinLength',threshold);
    %len = zeros(1,length(lines));

  % -- hold on
    
    smallX = 1280; smallY = 720; bigX = 0; bigY = 0;
   
    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
if(show)
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
        % Plot beginnings and ends of lines
    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
end        
        if xy(1,1) < xy(2,1)
            if smallX > xy(1,1)
                smallX = xy(1,1);
            end
            if bigX < xy(2,1)
                bigX = xy(2,1);
            end
        else
             if smallX > xy(2,1)
                smallX = xy(2,1);
            end
            if bigX < xy(1,1)
                bigX = xy(1,1);
            end
        end
        
        if xy(1,2) < xy(2,2)
             if smallY > xy(1,2)
                smallY = xy(1,2);
            end
            if bigY < xy(2,2)
                bigY = xy(2,2);
            end
        else
             if smallY > xy(2,2)
                smallY = xy(2,2);
            end
            if bigY < xy(1,2)
                bigY = xy(1,2);
            end
        end
       
        
%       len = norm(lines(k).point1 - lines(k).point2);
%       fprintf('length is ');
%       fprintf(int2str(len));
%       fprintf('\n');
    end
  
        bb= [smallX smallY bigX bigY];
    
% --   title('Result of Prewitt edge detection + disk/line dilation + Hough transform');
% --   hold off

end