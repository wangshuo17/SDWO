function [ predict_info ] = f_SDWO_predict( SDWO, predictx )

npredict = size(predictx, 2);
gate = SDWO.gate;
LRBFNs = SDWO.LRBFNs;

% select the proper LRBFN for the unknown input vectors predictx
[ LRBFN_id, ~ ] = f_select_LRBFN(gate, predictx);

tic();

% test the LRBFNs with the testing samples
predicty = zeros(1, npredict);
for i=1:npredict
    predicty(i) = f_predict(LRBFNs{LRBFN_id(i, 1)}, predictx(:, i));
end
predict_info.t = toc();
predict_info.y = predicty; % predicted results

end