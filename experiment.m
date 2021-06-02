% A backpropagation script

%% pre-trsining


clear;
datasetNames = {{'wineInputs','wineTargets'},{'thyroidInputs','thyroidTargets'},...
                 {'irisInputs','irisTargets'}, {'glassInputs','glassTargets'},...
                 {'engineInputs','engineTargets'},{'cancerInputs','cancerTargets'},...
                 {'abaloneInputs','abaloneTargets'}};
dataTitle  = {'wine','thyroid', 'iris', 'glass','engine','cancer','abalone'};
             
% load the data set
% xor.mat: three sets are created {x,y}, {x_val, y_val) and {x_test, y_test}

for datasel = [1,3,6]%[5,7]


%     subplot(length(datasetNames),1,datasel);
load  ([datasetNames{datasel}{1},'.mat']);
load ([datasetNames{datasel}{2},'.mat']);

switch datasel
    case 1
        x = wineInputs;
        y = wineTargets;
    case 2
        x = thyroidInputs;
        y = thyroidTargets;        
    case 3
        x = irisInputs;
        y = irisTargets;        
    case 4
        x = glassInputs;
        y = glassTargets;        
    case 5
        x = engineInputs;
        y = engineTargets;       
    case 6
        x = cancerInputs;
        y = cancerTargets;        
    case 7 
        x = abaloneInputs;
        y = abaloneTargets;        
end
    
% Scale and normalize
N = length(x);
idx = randperm(length(x),N);
x = x(:,idx);
y = y(:,idx);

% reserve 15% for validation
x_val = x(:,1:0.15*N);
y_val = y(:,1:0.15*N);

% reserve 15% for testing
x_test = x(:,0.15*N:0.3*N);
y_test = y(:,0.15*N:0.3*N);

% remove the test data from the training data
x(:,1:0.3*N) = [];
y(:,1:0.3*N) = [];


mu=mean(x,2);
sigma = std(x')';

%Normalize the training set
for i = 1:length(x)
    x(:,i) = (x(:,i)-mu)./sigma;
end

% Normalize the validation set
for i = 1:length(x_val)
    x_val(:,i) = (x_val(:,i)-mu)./sigma;
end

% Normalize the testing set
for i = 1:length(x_test)
    x_test(:,i) = (x_test(:,i)-mu)./sigma;
end

   
save([dataTitle{datasel},'data'],'x','x_val','x_test','y','y_val','y_test');


[NI,NP] = size(x);
[NO,~] = size(y);

NH1 = 13;%100;%2;
NH2 = 8;
NH3 = 5;
NH4 = 3;

L=[NI,NH1,NH2,NH3,NH4,NO]; % NI,NH,NO are the number of neurons in the input, the hidden and output layers
% funcname = 'tansig';
funcpt = {@linear,@Sigmoid,@Tanh,@RELU,@ELU,@SELU,@Softplus};
fsel = 1:length(funcpt) ;%[1,2];%1:length(funcpt);% [1,2];
funcnames = {'linear','Sigmoid','Tanh','RELU','ELU','SELU','Softplus'};
mark = {'d--','s--','x--','*--','v--','+--','o--'};

lr = 0.001;%0.001;%[0.004, 0.01,0.1,1];%0.004;%0.4;
mom = 0;%0.9;
nEpochs = 1000;%5*10^4;
mseCriterion = 0.01;
sf_rand = 0.01;%0.3;%0.8;%0.8;



%Create a free form network


%create the state matrices
        % rand() produces uniform random number between [0, 1]. So you will
        % need to scale rand( ... ) suitably.
%         
% 
% 
%            w1 = sf_rand * rand(NH1,NI);
%            b1 = sf_rand * rand(NH1,1);
%            w2 = sf_rand * rand(NH2,NH1);
%            b2 = sf_rand * rand(NH2,1);
%            w3 = sf_rand * rand(NH3,NH2);
%            b3 = sf_rand * rand(NH3,1);
%            w4 = sf_rand * rand(NH4,NH3);
%            b4 = sf_rand * rand(NH4,1);
%            w5 = sf_rand * rand(NO,NH4);
%            b5 = sf_rand * rand(NO,1);
%             
%            save(['wbRandom',dataTitle{datasel}],'w1','b1','w2','b2','w3','b3','w4','b4','w5','b5');
% %                 
        load(['wbRandom',dataTitle{datasel}]);
        

        
%%   Training    

    %     subplot(2,2,r);
    figure;
    for f = fsel
        func = funcpt{f};
        
        % initialise everything
%         net1 = zeros(NH,NP);
%         a1 = zeros(NH,NP);
%         net2 = zeros(NO,NP);
%         a2 = zeros(NO,NP);
        
        prev_dw1 = zeros( size(w1)); % prev_dw starts at 0
        sum_dw1 = zeros(size(w1));
        prev_db1 = zeros(size(b1));
        sum_db1 = zeros(size(b1));
        
        prev_dw2 = zeros(size(w2)); % prev_dw starts at 0
        sum_dw2 = zeros(size(w2));
        prev_db2 = zeros(size(b2));
        sum_db2 = zeros(size(b2));
        
        prev_dw3 = zeros( size(w3)); % prev_dw starts at 0
        sum_dw3 = zeros(size(w3));
        prev_db3 = zeros(size(b3));
        sum_db3 = zeros(size(b3));
        
        prev_dw4 = zeros(size(w4)); % prev_dw starts at 0
        sum_dw4 = zeros(size(w4));
        prev_db4 = zeros(size(b4));
        sum_db4 = zeros(size(b4));
        
        prev_dw5 = zeros(size(w5)); % prev_dw starts at 0
        sum_dw5 = zeros(size(w5));
        prev_db5 = zeros(size(b5));
        sum_db5 = zeros(size(b5));
        
        load(['wbRandom',dataTitle{datasel}]);
        
        %% complete the first FWD Pass
        % execute a forward pass for one or all inputs
        % store netsums and activations
        % determine the error
        [a1,a2,a3,a4,a5] = fwdpass(func,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,x);
%         net1 = w1*x + b1;
%         net2 = w2*a1 + b2;
%         disp('a1 =   ' );
%         disp(a1);
%         disp('a2 =   ' );
%         disp(a1);
        
        
        err = (y - a5);
%         disp('err =   ' );
%         disp(num2str(err));
        % calculate the mean squared error
        mse = sum(err.^2,'all')/NP/NO;
        %%
        epochs = 1;
        
        while (epochs < nEpochs)
            mse_plot(epochs,1) = mse;
            
%                 if (mod(epochs,100) == 0)
%                     fprintf('%d %f\n', epochs, mse);
%                 end
%                 fprintf('%d %f\n', epochs, mse);
            
            if mse < mseCriterion
                break;
            end
            % BP Pass
            
            %Calculate the deltas, propagate the deltas
            
            delta5 = err.*func(net5,a5,1);
            sum_dw5 = delta5*a4';
            sum_db5 = sum(delta5,2);
            
            delta4 = (w5'*delta5).*func(net4,a4,1);
            sum_dw4 = delta4*a3';
            sum_db4 = sum(delta4,2);
            
            delta3 = (w4'*delta4).*func(net3,a3,1);
            sum_dw3 = delta3*a2';
            sum_db3 = sum(delta3,2);
            
 
            delta2 = (w3'*delta3).*func(net2,a2,1);
            sum_dw2 = delta2*a1';
            sum_db2 = sum(delta2,2);
            
            delta1 = (w2'*delta2).*func(net1,a1,1);
            sum_dw1 = delta1*x';
            sum_db1 = sum(delta1,2);    
            
            
            prev_dw5 = lr * (sum_dw5 ./NP) + (mom * prev_dw5);
            w5 = w5 + prev_dw5;
            prev_db5 = lr * (sum_db5 ./NP) + (mom * prev_db5);
            b5 = b5 + prev_db5;
            
            prev_dw4 = lr * (sum_dw4 ./NP) + (mom * prev_dw4);
            w4 = w4 + prev_dw4;
            prev_db4 = lr * (sum_db4 ./NP) + (mom * prev_db4);
            b4 = b4 + prev_db4;
            
            prev_dw3 = lr * (sum_dw3 ./NP) + (mom * prev_dw3);
            w3 = w3 + prev_dw3;
            prev_db3 = lr * (sum_db3 ./NP) + (mom * prev_db3);
            b3 = b3 + prev_db3;            
            
            prev_dw2 = lr * (sum_dw2 ./NP) + (mom * prev_dw2);
            w2 = w2 + prev_dw2;
            prev_db2 = lr * (sum_db2 ./NP) + (mom * prev_db2);
            b2 = b2 + prev_db2;
            
            prev_dw1 = lr * (sum_dw1 ./NP) + (mom * prev_dw1);
            w1 = w1 + prev_dw1;
            prev_db1 = lr * (sum_db1 ./NP) + (mom * prev_db1);
            b1 = b1 + prev_db1;
            
            %% compute the new error by executing a new forward pass
            
            
            [a1,a2,a3,a4,a5] = fwdpass(func,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,x);
%             net1 = w1*x + b1;
%             net2 = w2*a1 + b2;
            
            err = y-a5;
            mse = sum(err.^2,'all')/NP/NO;
            
            epochs = epochs + 1;
            
            % Uncomment to display/debug
            %     sum_dw1
            %     sum_db1
            %
            %     sum_dw2
            %     sum_db2
            
            
        end

%         figure;
        subplot(2,4,f);

        plot(mse_plot,mark{f});
        title(funcnames{f});
        xlabel('Epochs');
        ylabel('mse');
%         hold on;
        grid on;


        
        %
        %
%         figure;
% %         subplot(2,1,1);
%         plot(err(1,:));
%         xlabel('Sample index');
%         ylabel('Error for y');
%         grid on;
        
%         subplot(2,1,2);
%         plot(err(2,:));
%         xlabel('Sample index');
%         ylabel('Error for y2');
%         grid on;
%         sgtitle(funcnames{f});

%         title(funcnames{f});
        
        
        disp(func);
        disp(dataTitle{datasel});
        
        
        
%         save([funcnames{f},'_',dataTitle{datasel},'wb'], 'w1','b1','w2','b2','w3','b3','w4','b4','w5','b5');
    end
%             legend(funcnames{fsel});
                sgtitle(dataTitle{datasel});

end




