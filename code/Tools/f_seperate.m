function [ part1, part2 ] = f_seperate( X, percentage )
% Randomly split the matrix by column

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