function result =  main()

dbstop if error;
rng default;  % For reproducibility

addpath('./ClusteringAlgorithm');
addpath('./RBF');
addpath('./DOE');
addpath('./Tools');

test_id = 1;
settings = f_get_settings(test_id);
result.data = testSDWO( settings.data, settings.method );
result.time = datestr(now);

% notification
sound(sin(2*pi*25*(1:4000)/100)); 
disp("************ End of all the simulations ************");


    function [ result ] = testSDWO( data_param, experiment_param )
        trainset            = data_param.train;
        testset             = data_param.test;
        expriment_times     = experiment_param.expriment_times;

        result.expriment_times  = expriment_times;
        result.mnns             = [];
        result.results          = [];

        for i=1:expriment_times
            % one experiment
            [ mnn, statistics ] = f_SDWO(trainset, testset, experiment_param);
            result.mnns = [result.mnns; mnn];
            result.results = [result.results; statistics];
            disp('********************');
        end

        result.results_mean = mean(result.results, 1);
        result.results_std = std(result.results,1);

    end

end