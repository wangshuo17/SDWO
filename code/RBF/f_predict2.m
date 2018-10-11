function [ predicty ] = f_predict2( rbf, distance )
% calculate the response of the RBF network

fai = f_fai2(distance, rbf.sigma);

predicty = fai * rbf.w;
predicty = predicty';
end