function [ rbfr ] = f_rbfr( train, xdimen, ctr_percentage )
% build the RBF network (RBF centres are randomly selected)

% split input/output
train_x = train(1:xdimen, :);

% randomly select the RBF centres
ctrs = f_seperate(train_x, ctr_percentage);
nctrs = size(ctrs, 2);

% sigma = f_sigma_distance(train_x);
% sigma = f_sigma_random(nctrs, 0.04, 0.2);
sigma = f_sigma_universal(nctrs, 0.2);

rbfr = f_rbf_base(train, ctrs, sigma);

end