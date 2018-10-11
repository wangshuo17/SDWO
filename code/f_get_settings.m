function settings = f_get_settings(test_case_id)

    switch test_case_id
        case 1
            settings.readme = 'test1';
            load('../TestCases/Test1/test1_60.mat', 'test1_60');
            data = test1_60;
            settings.method.nc = 12;                                % the number of the RBF centres

        case 2
            settings.readme = 'test2';
            load('../TestCases/Test2/test2_OLHD_300.mat', 'test2_OLHD_300');
            data = test2_OLHD_300;
            settings.method.nc = 60;                                % the number of the RBF centres

        case 3
            settings.readme = 'test3';
            load('../TestCases/Test3/test3_OLHD_2000.mat', 'test3_OLHD_2000');
            data = test3_OLHD_2000;
            settings.method.nc = 120;                               % the number of the RBF centres

        case 4
            settings.readme = 'aeroplane';
            load('../TestCases/Test4/test4_FF_10000.mat', 'test4_FF_10000');
            data = test4_FF_10000;
            settings.method.nc = 220;                               % the number of the RBF centres
    end

    settings.method.nl = 4;                                         % the number of the local regions
    settings.method.lambda = 0.6;                                   % the expansion factor
    settings.method.parallel = 0;                                   % 0: serial 1: parallel
    settings.method.optimAlgorithm = 2;                             % 1: SQP algorithm 2: PSO algorithm
    settings.method.expriment_times = 30;                           % 30 independent trials

    [traindata, testdata] = f_seperate(data, 0.8);                  % randomly split all the available samples
    settings.data.train = traindata;                                % training and validation samples
    settings.data.test = testdata;                                  % testing samples
end