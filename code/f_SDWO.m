function [ SDWO, statistics ] = f_SDWO( trainset, testset, expriment_param )

% data preprocessing
[ trainx, trainy, testx, testy, xdimen, ~ ] = f_SDWO_preprocessing( trainset, testset );

% train the LRBFNs
SDWO = f_SDWO_train( [trainx; trainy]', xdimen, expriment_param );

% test the LRBFNs
[ train_time, totalIterNum, train_RMSE, test_RMSE ] = f_SDWO_analysis( SDWO, trainx, trainy, testx, testy );
statistics = [ train_time, totalIterNum, train_RMSE, test_RMSE ];

% debug start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% allx = [trainx testx];
% predict_info = f_mnn_predict( mnn, allx );
% allData = [allx; predict_info.y];
% allData0 = mapminmax.reverse(allData,settings);
% f_drawmatrix(allData0); hold on;

% ss=[];
% for i=0:0.1:1
%     lambda = i;
%     mnn = f_mnn_train( [trainx; trainy]', xdimen, nc, nl, lambda, parallel );
%     [ train_time, totalIterNum, train_RMSE, test_RMSE ] = f_mnn_predict_analysis( mnn, trainx, trainy, testx, testy );
%     statistics = [ train_time, totalIterNum, train_RMSE, test_RMSE ];
%     ss = [ss; statistics];
% end
% debug end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end