function [ rbf ] = f_rbfcw2( train_y, ctrs, distance, w )
% build the RBF network with predefined RBF centres, distance matrix, and
% output weights

nctrs = size(ctrs, 2);
sigma = f_sigma_universal(nctrs, w);
rbf = f_rbf_base2( train_y, ctrs, distance, sigma );

end
