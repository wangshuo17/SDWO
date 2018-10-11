function [ rbfe ] = f_rbfe( train, xdimen )
% build the RBF network under interpolation condition
% suitable for samples without noise

ctrs = train(1:xdimen, :);

nctrs = size(ctrs, 2);

% sigma = f_sigma_distance(train_x);
% sigma = f_sigma_random(nctrs, 0.04, 0.5);
sigma = f_sigma_universal(nctrs, 0.1);

rbfe = f_rbf_base(train, ctrs, sigma);

end