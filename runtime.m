function exec = runtime(f,data)
% run a given function and the derivative with given data 1000 times


runtimes = 31000;
exec = zeros(runtimes,1);

for i = 1:runtimes
tstart = tic;
y1 = f(data,0,0);
y2 = f(data,y1,1);
t_exec = toc(tstart);
exec(i) = t_exec*10^6; % microsecond
end

end