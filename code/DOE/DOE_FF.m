function [ dff ] = DOE_FF( bound, level )
%DOE_FF Full factorial design method
%   bound:      multi-row two-column matrix
%   level:      column vector

dff = fullfact(level)-1;
piece = (bound(:,2)-bound(:,1))./(level-1);
piece = ones(size(dff,1), 1) * piece';
dff = dff .* piece + ones(size(dff,1), 1) * bound(:,1)';
end

