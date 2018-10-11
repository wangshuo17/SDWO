function [ rbf ] = f_rbfcw( train, ctrs, w )
% build the RBF network with RBF centres and output weights

nctrs = size(ctrs, 2);

% sigma = f_sigma_distance(train_x);
% sigma = f_sigma_random(nctrs, 0.04, 0.2);
sigma = f_sigma_universal(nctrs, w);

rbf = f_rbf_base(train, ctrs, sigma);

end
