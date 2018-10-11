function [ C, U, idx ] = f_fkm( X, nClusters, fuzzy )
%Fuzzy k-means clustering algorithm
% X:            one row represents an instance
% nClusters:    number of the clusters
% fuzzy:        1: fuzzy kmeans, other: kmeans

addpath('../Tools');

% initialization
[C, ~] = f_seperate(X', nClusters);
C = C';

isStop = 0;
iters = 0;
while isStop == 0
    iters = iters + 1;    
    [ hardU, softU, idx ] = f_get_U( X, C );
    
    if fuzzy == 1
        U = softU;
    else
        U = hardU;
    end
    
    newC = f_get_C( X, U );
    isStop = f_check_termination( C, newC );    
    C = newC;
end

    function [ part1, part2 ] = f_seperate( X, percentage )

        n = size(X, 2);

        if percentage > 1
            n_selected = floor(percentage);
        else
            n_selected = floor(n * percentage);
        end

        select_flag = zeros(1, n);
        while sum(select_flag) < n_selected
            col_id = ceil(rand(1,1) * n);
            if select_flag(col_id) == 0
                select_flag(col_id) = 1;
            end
        end

        part1 = X(:, select_flag == 1);
        part2 = X(:, select_flag == 0);

    end

end
