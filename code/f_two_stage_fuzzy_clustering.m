function [ gate ] = f_two_stage_fuzzy_clustering( train, xdimen, nc, cl, lambda )

% the input component of the training samples
X = train(:,1:xdimen);


% 1. the first clustering stage using k-means clustering algorithm to
% determine the RBF centres
[idx, C] = kmeans(X, nc);
% [ C, ~, idx ] = fc( X, nc, 0 );

% Distribute the training samples into different clusters
% "hard partition" means there is no overlap
sampleclusters = f_partition_hard(train, idx, nc);


% 2. the second clustering stage using fuzzy k-means clustering algorithm
[L, U] = fcm(C, cl);
% [ L, U ] = fc( C, cl, 1 );

% "soft partition" means the clusters overlap each other, and the
% overlapping degree is controlled by the expansion factor, lambda
LRBFNs = f_partition_soft(sampleclusters, C, L, U, lambda);

% Save the results
gate.L =  L;
gate.LRBFNs = LRBFNs;
gate.C = C;
gate.U = U;
gate.sampleclusters = sampleclusters;

end

