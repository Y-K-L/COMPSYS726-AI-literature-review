function y = SELU(x,z,op)

[i_pos,j_pos] = find(x>0);
[i_neg,j_neg] = find(x<=0);
alpha = 1.6733;
lamda = 1.0507;

switch op
    case 0
        % return the function output
        y(i_pos,j_pos) = lamda * x(i_pos,j_pos);
        y(i_neg,j_neg) = lamda *alpha*(exp(x(i_neg,j_neg)) - 1);
        
    case 1
        % return the derivative output of the function
        y(i_pos,j_pos) = lamda ;
        y(i_neg,j_neg) = z(i_neg,j_neg) + lamda *alpha;
        
end

end