function [ hardU, softU, idx ] = f_get_U( X, C )
% calculate the membership degree matrix

    d = f_distance(X', C');
    d = d';
    fai = exp(-(d./0.34).^2);

    k = size(d, 1);
    N = size(d, 2);

    hardU = zeros(k, N);
    softU = zeros(k, N);
    idx = zeros(1, N);

    for j = 1:N
        colSum = sum(fai(:, j));
        softU(:, j) = fai(:, j)./colSum;

        [~, max_id] = max(fai(:, j));

        hardU(max_id, j) = 1;
        idx(1, j) = max_id;
    end
end