function y = Softplus(x,z,op)

    switch op
        case 0
            % return the function output
            y = log(1+exp(x));
            
        case 1
            % return the derivative output of the function
            y = Sigmoid(x,0,0);
    end


end