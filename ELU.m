function y = ELU(x,z,op)

[i_pos,j_pos] = find(x>0);
[i_neg,j_neg] = find(x<=0);
alpha = 1;

switch op
    case 0
        % return the function output
        y(i_pos,j_pos) = x(i_pos,j_pos);
        y(i_neg,j_neg) = alpha*(exp(x(i_neg,j_neg)) - 1);
        
    case 1
        % return the derivative output of the function
        y(i_pos,j_pos) = 1;
        y(i_neg,j_neg) = z(i_neg,j_neg) + alpha;
        
end


end