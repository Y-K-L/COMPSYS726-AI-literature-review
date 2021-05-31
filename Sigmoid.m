function y = Sigmoid(x,z,op)

    switch op
        case 0
            % return the function output
            y = 1./(1+exp(-1*x));
            
        case 1
            % return the derivative output of the function
            y = z.*(1-z);
    end

end

