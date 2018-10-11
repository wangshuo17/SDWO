function [ x ] = DOE_latin( bound, n )
%DOE_LATIN Latin hypercube sampling method
%   bound:      multi-row two-column matrix
%   n:          the number of sampling

p = size(bound, 1); % number of variables

x = lhsdesign(n, p, 'criterion','maximin');

for i = 1 : p
    down = bound(i, 1);
    up = bound(i, 2);
    x(:, i) = x(:, i) .* (up - down) + down;
end

% plot(x(:,1),x(:,2),'.');

end