function [ fai ] = f_fai2(d, sigma)
% calculate the fai matrix
% d:        distance matrix
% sigma:    width

fai = exp(-(d./sigma).^2);

end