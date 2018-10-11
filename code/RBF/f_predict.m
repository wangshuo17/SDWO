function [ predicty ] = f_predict( rbf, predictx )
% calculate the response of the RBF network
% rbf:          the RBF network
% predictx:     the unknown input vectors

newG = f_fai(predictx, rbf.ctrs, rbf.sigma); % calculate the matrix fai

predicty = newG * rbf.w;
predicty = predicty';

end