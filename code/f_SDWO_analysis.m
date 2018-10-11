function [ train_time, totalIterNum, train_RMSE, test_RMSE, predict_time ] = f_SDWO_analysis( SDWO, trainx, trainy, testx, testy )

% statistical result
train_time = SDWO.time;
totalIterNum = 0;
nl = size(SDWO.LRBFNs, 2);
for i=1:nl
    totalIterNum = totalIterNum + size(SDWO.optHistory{i}.history, 1);
end

train_predict_info      = f_SDWO_predict( SDWO, trainx );
test_predict_info       = f_SDWO_predict( SDWO, testx );

% prediction time
predict_time    = train_predict_info.t + test_predict_info.t;
nPoints = size(trainx,2) + size(testx,2);
predict_time = predict_time/nPoints;

% approximation accuracy analysis
err = f_row_error(trainy, train_predict_info.y);    
train_RMSE = err.rmse;                              % training RMSE

err = f_row_error(testy, test_predict_info.y);      
test_RMSE = err.rmse;                              % testing RMSE

% for debug
% f_drawmatrix([trainx; trainy]); hold on;
% figure(1);
% f_drawmatrix([testx; test_predict_info.y]); hold on;
% figure(2);
% f_drawmatrix([testx; err.detail(3, :)]); hold on;

end