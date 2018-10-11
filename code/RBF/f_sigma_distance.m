function [ sigma ] = f_sigma_distance( ctrs )
%f_calSigma determine the widths with pNN

n = size(ctrs, 1);

% gama = 10.0; % 
% 
% D = zeros(n, n);
% 
% for i=1:n
% 	for j=1:n
% 		d = norm( ctrs(i, :)-ctrs(j, :), 2);
%         
%         if d == 0
%             d = 1000000000; % a large number
%         end
%         
% 		D(i, j) = d;
% 	end
% end

% sigma = min(D)*gama; %sigma vector
sigma = ones(n, 1);

end

