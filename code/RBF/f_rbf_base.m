function [ rbf ] = f_rbf_base( train, ctrs, sigma )

xdimen = size(ctrs, 1);

% split input/output
train_x = train(1:xdimen, :);
train_y = train(xdimen+1:size(train, 1), :);

% calculate the matrix fai
fai = f_fai(train_x, ctrs, sigma);

% calculate the output weights with LSM
w = pinv(fai) * train_y';  % pseudo-inverse

% save the results
rbf.ctrs = ctrs;
rbf.sigma = sigma;
rbf.w = w;

end