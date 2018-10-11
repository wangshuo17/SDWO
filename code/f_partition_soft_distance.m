function [ LRBFNs ] = f_partition_soft_distance(sampleclusters, C, L, U, lambda)
% soft partition scheme

LNum = size(L, 1); % the number of LRBFNs
CNum = size(C, 1); % the numbr of RBF centres
U = U';

LRBFNs = cell(1, LNum);
for i=1:LNum
    LRBFNs{i}.C = [];
    LRBFNs{i}.T = [];
end

distance1 = f_distance(L', C');

for j=1:CNum    
    [~, position] = max(U(j, :));
    
    LRBFNs{position}.C = [LRBFNs{position}.C; C(j, :)];
    LRBFNs{position}.T = [LRBFNs{position}.T; sampleclusters{j}];
    
    for i=1:LNum
        if distance1(i, j) < lambda && i ~= position
            LRBFNs{i}.C = [LRBFNs{i}.C; C(j, :)];
            LRBFNs{i}.T = [LRBFNs{i}.T; sampleclusters{j}];
        end
    end

end

% debug start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% analyse the overlap rate
totalCNum = 0;
totalTNum = 0;
for i=1:LNum
    totalCNum = totalCNum + size(LRBFNs{i}.C, 1);
    totalTNum = totalTNum + size(LRBFNs{i}.T, 1);
end
CTimes = totalCNum/CNum;
disp("overlap rate: ");
disp([lambda CTimes]);
% debug end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

