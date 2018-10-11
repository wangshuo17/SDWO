function [ num ] = f_get_rand_int( max_num)
% Return a random integer from [1, max_num]

max_num = floor(max_num);
num = ceil(rand(1,1) * max_num);

end