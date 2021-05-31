function y = RELU(x,z,op)

switch op
    case 0
        % return the function output
        y = max(0,x);
    case 1
        % return the derivative output of the function
        y = x>0;
        
end


end