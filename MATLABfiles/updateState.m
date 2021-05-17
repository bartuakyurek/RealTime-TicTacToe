function [state,gameOver,updated] = updateState(currentState, newState, playerTurn) %sonradan önceki stateparam olarak gelebilir karşl. için

equality_count = 0;
unequality_count = 0;
unequality_flag = 0;

%if state is full (no blank)
%gameOver = true;
updated = false;

for i = 1:9
    
    if(currentState(i) == newState(i))
        equality_count = equality_count + 1;
        
    else
        unequality_count = unequality_count + 1;
        unequality_flag = i;
    end
    
end

if( equality_count == 8 ) %this is not accurate, if an X is detected as O mistakenly, then it fails
    
    if( currentState(unequality_flag) == 'b' )
        if (newState(unequality_flag) == playerTurn)
            state = newState; %plus, the logic might be inaccurate, so update this according to player turn etc.
            updated = true;
        else
            state = currentState;
        end
    else
            state = currentState;
    end
else
    state = currentState;
end

gameOver = isOver(state);
end

function over = isOver(state)

over = false;

flag = 0;

for i = 1: length(state)
    if(state(i) == 'b')
        flag = flag + 1;
    end
end

if (flag == 0)
    over = true;
end

end
