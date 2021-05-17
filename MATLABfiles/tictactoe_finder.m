% choose X or O
%place the playboard then press start at the beginning or press restart

clear all;
%camObj = webcam('FaceTime HD Camera'); %videoinput('macvideo');

gridState = ['b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'];

gameOver = false;
playerTurn = 'O';
turn_flag = true;

for i = 1:1
%while ~gameOver
    
   % I = snapshot(camObj);
   I = imread('7.jpg');
    
    Ig = rgb2gray(I);
    [croppedBoard, boardBoundingBox] = detectBoard(Ig);
    [croppedGrid, gridBoundingBox] = detectGrid(croppedBoard);
     
    
    if croppedGrid == 0
              % fprintf('Game update: No grid detected yet. \n');
    else
                  
      % subplot(2,1,1);
      % imshow(croppedBoard);
          
         % subplot(2,1,2);
         % imshow(croppedGrid);
        
        newState = extractState(croppedGrid);
       
        [gridState,gameOver,updated] = updateState(gridState, newState, playerTurn);
       
        if updated
            printState(gridState);
            
            turn_flag = ~turn_flag;
            
            if turn_flag
                playerTurn = 'O';
            else
            playerTurn = 'X';
            end
        end
    end
end

clear all;


function printState(state)

    fprintf(state(1));fprintf(state(2));fprintf(state(3));
    fprintf('\n');
    
    fprintf(state(4));fprintf(state(5));fprintf(state(6));
    fprintf('\n');
    
    fprintf(state(7));fprintf(state(8));fprintf(state(9));
    fprintf('\n');

end
