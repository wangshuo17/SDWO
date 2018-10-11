function [ sampleclusters ] = f_partition_hard( train, idx, nc )
% no overlap between the sample clusters

sampleclusters = cell(1, nc);

for i=1:nc
    sampleclusters{1, i} = [sampleclusters{1, i}; train(idx == i, :)];    
end

end
