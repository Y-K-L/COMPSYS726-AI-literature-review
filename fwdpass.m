function [a1,a2,a3,a4,a5] = fwdpass(f,w1,b1,w2,b2,w3,b3,w4,b4,w5,b5,p)

net1 = w1*p + b1;
assignin('base','net1',net1);
a1 = f(net1,0,0);

net2 = w2*a1 + b2;
assignin('base','net2',net2);
a2 = f(net2,0,0);

net3 = w3*a2 + b3;
assignin('base','net3',net3);
a3 = f(net3,0,0);

net4 = w4*a3 + b4;
assignin('base','net4',net4);
a4 = f(net4,0,0);

net5 = w5*a4 + b5;
assignin('base','net5',net5);
a5 = f(net5,0,0);


end