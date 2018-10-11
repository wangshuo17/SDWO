function [ d ] = f_distance( X, ctrs )
% solve the distance matrix
% X:          the input component of training samples
% ctrs:       the RBF centres

rowNum = size(X, 2);
colNum = size(ctrs, 2);

d = ones(rowNum, colNum);

for i = 1:rowNum
    for j = 1:colNum
        d(i, j) = norm( ctrs(:, j) - X(:, i), 2);     % 2-norm
    end
end
end