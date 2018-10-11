function [ sigmas ] = f_sigma_random( n, min, max )
% determine the widths with a random number

sigmas = ones(1, n);

for i=1:n
    r = rand*(max - min) + min;
    sigmas(i) = r;
end

end