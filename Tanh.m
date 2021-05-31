function y = Tanh(x,z,op)

    switch op
        case 0
            % return the function output
            y = (exp(x) - exp(-1*x))./(exp(-1*x) + exp(x));
            
        case 1
            % return the derivative output of the function
            y = 1 - z.^2;
    end
end


