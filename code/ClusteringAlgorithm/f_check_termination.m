function [ stop, totalDistance ] = f_check_termination( C, newC )
% check the termination condition

totalDistance = 0;
N = size(C, 1);
for i=1:N
    diff = C(i, :) - newC(i, :);
    totalDistance = totalDistance + norm(diff);
end

if totalDistance < 10^-5
    stop = 1;
else
    stop = 0;
end
end