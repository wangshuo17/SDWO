function [ fai ] = f_fai(X, ctrs, sigma)
% calculate the fai matrix
% X:        samples
% ctrs:     RBF centres
% sigma:    width

rowNum = size(X, 2);
colNum = size(ctrs, 2);

fai = ones(rowNum, colNum);

for i = 1:rowNum
    for j = 1:colNum
        d = norm( ctrs(:, j) - X(:, i), 2);     % 2-norm
        sigmaj = sigma(j);
        fai(i, j) = exp(-d^2/sigmaj^2);           % the Gaussian function
    end
end

%save(savepath, 'fai', '-ASCII');

end