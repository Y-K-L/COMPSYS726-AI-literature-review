%% fucntion and dirrivative plot

x = -5:0.01:5;



y1 = Sigmoid(x,0,0);
y2 = Tanh(x,0,0);
y3 = RELU(x,0,0);
y4 = ELU(x,0,0);
y5 = SELU(x,0,0);
y6 = Softplus(x,0,0);
y7 = linear(x,0,0);

y1_dot = Sigmoid(x,y1,1);
y2_dot = Tanh(x,y2,1);
y3_dot = RELU(x,y3,1);
y4_dot = ELU(x,y4,1);
y5_dot = SELU(x,y5,1);
y6_dot = Softplus(x,y6,1);
y7_dot = linear(x,y7,1);


% plot activation functions
% figuures in subfigures
figure;
% subplot(2,3,1);
plot(x,y1);hold on;plot(x,y1_dot,'--');title("Sigmoid");legend('Activation function','Gradient function'); grid on;
% subplot(2,3,2);
figure;
plot(x,y2);hold on;plot(x,y2_dot,'--');title("Tanh");legend('Activation function','Gradient function');grid on;
% subplot(2,3,3);
figure;
plot(x,y3);hold on;plot(x,y3_dot,'--');title("RELU");legend('Activation function','Gradient function');grid on;
% subplot(2,3,4);
figure;
plot(x,y4);hold on;plot(x,y4_dot,'--');title("ELU");legend('Activation function','Gradient function');grid on;
% subplot(2,3,5);
figure;
plot(x,y5);hold on;plot(x,y5_dot,'--');title("SELU ");legend('Activation function','Gradient function');grid on;
% subplot(2,3,6);
figure;
plot(x,y6);hold on;plot(x,y6_dot,'--');title("Softplus");legend('Activation function','Gradient function');grid on;
figure;
plot(x,y7);hold on;plot(x,y7_dot,'--');title("Linear");legend('Activation function','Gradient function');grid on;
% sgtitle('Activation functions');

%% runtime plot

clear;
funcnames = {'linear','Sigmoid','Tanh','RELU','ELU','SELU','Softplus'};
funcpt = {@linear,@Sigmoid,@Tanh,@RELU,@ELU,@SELU,@Softplus};
randx = 10 * rand(100,1)-5;

for i = 1:100
    for f = 1:length(funcnames)
        func = funcpt{f};
        runtimes(:,f) = runtime(func,randx);
    end
    sums(i,:) = sum(runtimes,1);
end

% boxplot(runtimes,'Labels',funcnames);
% ylable("\mu s");


boxplot(sums,'Labels',funcnames);
ylable("\mu s");



