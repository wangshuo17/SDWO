function [ trainx, trainy, testx, testy, xdimen, settings ] = f_SDWO_preprocessing( trainset, testset )
%F_MNN_PRE data preprocessing

xdimen = size(trainset, 1)-1;
ntrain = size(trainset, 2);

[data_n, settings] = mapminmax([trainset testset], 0, 1);

train = data_n(:, 1:ntrain);
data_n(:, 1:ntrain) = [];
test = data_n;

trainx = train(1:xdimen, :);
trainy = train(xdimen+1, :);
testx = test(1:xdimen, :);
testy = test(xdimen+1, :);

end

