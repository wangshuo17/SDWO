function [ rbf ] = f_rbf_base2( train_y, ctrs, distance, sigma )

% calculate the matrix fai
fai = f_fai2(distance, sigma);

% the output weight vector
w = pinv(fai) * train_y';  % pseudo-inverse

% save the results
rbf.ctrs = ctrs;
rbf.sigma = sigma;
rbf.w = w;

end