function [ C ] = f_get_C( X, U )
% calculate the centers of all the clusters

    [k, N] = size(U);
    C = zeros(k, size(X, 2));

    for i=1:k

        weightSum = 0;
        center = zeros(1, size(X, 2));
        for j=1:N
            if U(i, j) ~= 0
                weightSum = weightSum + U(i, j);
                center = center + X(j, :) * U(i, j);
            end        
        end

        if weightSum ~= 0
            C(i, :) = center./weightSum;
        end
    end

end