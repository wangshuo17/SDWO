function [ LRBFNs ] = f_partition_soft_num(sampleclusters, C, L, U, lambda)
% soft partition scheme

LNum = size(L, 1); % the number of LRBFNs
CNum = size(C, 1); % the numbr of RBF centres
U = U';

LRBFNs = cell(1, LNum);
for i=1:LNum
    LRBFNs{i}.C = [];
    LRBFNs{i}.T = [];
    LRBFNs{i}.label = zeros(1, CNum);
end

distance1 = f_distance(L', C');

for j=1:CNum    
    [~, position] = max(U(j, :));
    
    LRBFNs{position}.C = [LRBFNs{position}.C; C(j, :)];
    LRBFNs{position}.T = [LRBFNs{position}.T; sampleclusters{j}];
    LRBFNs{position}.label(1, j) = 1;
end

for i=1:LNum
    dis_row = distance1(i, :);
    [~, ids] = sortrows(dis_row', 1);
    
    leftNum = CNum - sum(LRBFNs{i}.label);
    addNum = ceil(leftNum*lambda);
    
    for id = ids'
        if addNum > 0 && LRBFNs{i}.label(1, id) == 0
            LRBFNs{i}.C = [LRBFNs{i}.C; C(id, :)];
            LRBFNs{i}.T = [LRBFNs{i}.T; sampleclusters{id}];
%             LRBFNs{i}.label(1, id) = 1;
            addNum = addNum-1;
        end
    end
end

% debug start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% analyse the relationship of the overlap rate and the expansion factor
totalCNum = 0;
totalTNum = 0;
for i=1:LNum
    totalCNum = totalCNum + size(LRBFNs{i}.C, 1);
    totalTNum = totalTNum + size(LRBFNs{i}.T, 1);
end
CTimes = totalCNum/CNum;
disp("lambda, overlap rate: ");
disp([lambda CTimes]);
% debug end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

