function [ xn, settings ] = f_normalize_col( x )
% normalize the input vector x to [-1,1]

[xn, settings] = mapminmax(x');
xn = xn';

end