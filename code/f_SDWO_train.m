function [ mnn ] = f_SDWO_train( train, xdimen, expriment_param )

% receive the parameters
nc = expriment_param.nc;
nl = expriment_param.nl;
lambda = expriment_param.lambda;
optimAlgorithm = expriment_param.optimAlgorithm;
parallel = expriment_param.parallel;


% step1: carry out the two-stage fuzzy clustering algorithm with the
% expansion factor lambda
mnn.gate = f_two_stage_fuzzy_clustering(train, xdimen, nc, nl, lambda);


% step2: training the LRBFNs by solving single-variable optimizations
LRBFNs = cell(1, nl);
optHistory = cell(1, nl);
LRBFN_data = mnn.gate.LRBFNs;

tic();

if parallel
    
    % training the LRBFNs in parallel
    parfor i=1:nl
        model_samples = LRBFN_data{1, i}.T; % training samples in group i
        model_rbfctrs = LRBFN_data{1, i}.C; % RBF centres in group i

        % train each LRBFN by solving one single-variable optimization
        % problem
        [rbf, optimization_result] = f_rbfo_1(model_samples', model_rbfctrs', optimAlgorithm);
        LRBFNs{i} = rbf;
        optHistory{i} = optimization_result;
    end
else
    
    % training the LRBFNs in serial
    for i=1:nl
        model_samples = LRBFN_data{1, i}.T; % training samples in group i
        model_rbfctrs = LRBFN_data{1, i}.C; % RBF centres in group i
        
        if size(model_samples, 1)==0 || size(model_rbfctrs, 1)==0
            disp('wrong data');
        end

        % train each LRBFN by solving one single-variable optimization
        % problem
        [rbf, optimization_result] = f_rbfo_1(model_samples', model_rbfctrs', optimAlgorithm);
        LRBFNs{i} = rbf;
        optHistory{i} = optimization_result;
    end
end

mnn.time = toc();                   % save the training time
mnn.LRBFNs = LRBFNs;                % save all the LRBFNs
mnn.optHistory = optHistory;        % save the optimization history data
end
