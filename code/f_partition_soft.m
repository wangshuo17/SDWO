function [ LRBFNs ] = f_partition_soft(sampleclusters, C, L, U, lambda)

% try different soft-partition schemes
% LRBFNs = f_partition_soft_distance(sampleclusters, C, L, U, lambda);
% LRBFNs = f_partition_soft_num(sampleclusters, C, L, U, lambda);

U = U';

CNum = size(U, 1);
LNum = size(U, 2);

% threshold = (1-lambda)/2;              % good
threshold = (1-lambda^(1/LNum))/2;       % better

LRBFNs = cell(1, LNum);
for i=1:LNum
    LRBFNs{i}.C = [];
    LRBFNs{i}.T = [];
end

for i=1:CNum
    posibilityRow = U(i, :);
    [~, position] = max(posibilityRow);
    
    LRBFNs{1, position}.C = [LRBFNs{1, position}.C; C(i, :)];
    LRBFNs{1, position}.T = [LRBFNs{1, position}.T; sampleclusters{1, i}];
    
    for j=1:LNum
       if  posibilityRow(1, j) >= threshold && j ~= position
           
           LRBFNs{1, j}.C = [LRBFNs{1, j}.C; C(i, :)];
           LRBFNs{1, j}.T = [LRBFNs{1, j}.T; sampleclusters{1, i}];

       end
    end
end

% debug start%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
totalCNum = 0;
totalTNum = 0;
for i=1:LNum
    totalCNum = totalCNum + size(LRBFNs{i}.C, 1);
    totalTNum = totalTNum + size(LRBFNs{i}.T, 1);
end
CTimes = totalCNum/CNum;
disp("overlap rate: ");
disp(CTimes);
% debug end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
