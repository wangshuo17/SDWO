function [ rbf ] = f_rbfc( train, ctrs )
% build the RBF network with RBF centres


% 1. number of RBFs
nctrs = size(ctrs, 2);


% 2. width of the RBFs
% sigma = f_sigma_distance(train_x);
% sigma = f_sigma_random(nctrs, 0.04, 0.2);
sigma = f_sigma_universal(nctrs, 0.3);

rbf = f_rbf_base(train, ctrs, sigma);

end
