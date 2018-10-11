function [ rbf, optimization_result ] = f_rbfo_n( train, rbfctrs, rbfctr_cluster_id, nc, optimAlgorithm )
% build the RBF network by solving the multivariable optimization

[model_samples, optimization_samples] = f_seperate(train, 0.8);
x_dimen = size(rbfctrs, 1);
train_y = model_samples(x_dimen+1,:);
distance = f_distance(model_samples(1:x_dimen,:), rbfctrs);
distance_predict = f_distance(optimization_samples(1:x_dimen,:), rbfctrs);

optimization_result.history = [];
X0 = 1;                                % initial width
L = 0.1;                               % lower bound
U = 2;                                 % upper bound

X0 = X0 * ones(1, nc);
L = L * ones(1, nc);
U = U * ones(1, nc);

switch optimAlgorithm
    case 1 % fmincon
        [optimal_w, ~, exitflag, output] = fmincon(@obj, X0, [], [], [], [], L, U);
        
    case 2 % PSO
        options = optimoptions('particleswarm','SwarmSize',20,'HybridFcn',@fmincon,'Display','off');
        % options = optimoptions('particleswarm', 'SwarmSize', 20, 'Display','off');
        [optimal_w, ~, exitflag, output] = particleswarm(@obj, nc, L, U);
        
    case 3 % MultiStart
        opts = optimoptions(@fmincon,'Algorithm','sqp', 'Display','none');
        problem = createOptimProblem('fmincon','objective', @obj,'x0',X0,'lb', L,'ub', U,'options',opts);
        ms = MultiStart;
        [optimal_w, ~, exitflag, output] = run(ms, problem, 20);
        
        
    case 4 % GA
        [optimal_w, ~, exitflag, output] = ga(@obj, nc, [], [], [], [], L, U);
        
    case 5 % GlobalSearch    
        opts = optimoptions(@fmincon,'Algorithm','sqp');
        problem = createOptimProblem('fmincon','objective', @obj,'x0',X0,'lb', L,'ub', U,'options',opts);
        gs = GlobalSearch;
        [optimal_w, ~, exitflag, output] = run(gs, problem);
end

if (exitflag == 0)
    disp('optimization failed');
else
    disp('optimal width: ');
    disp(optimal_w);
    disp('******************************');
    sigma = zeros(1, size(rbfctrs, 2));
    for j=1:nc
        sigma(rbfctr_cluster_id==j) = optimal_w(j);
    end
    rbf = f_rbf_base(model_samples, rbfctrs, sigma);
end


% ************************************** the objective function ********************************************
    function rmse = obj(w)
        sigma_iter = zeros(1, size(rbfctrs, 2));        
        for i=1:nc
            sigma_iter(rbfctr_cluster_id==i) = w(i);
        end
        
        err = f_row_error(f_predict2(f_rbf_base2(train_y, rbfctrs, distance, sigma_iter), distance_predict), optimization_samples(x_dimen+1,:));% ¿ì
        
        % minimize the RMSE
        rmse = err.rmse;
        optimization_result.history = [optimization_result.history; [w rmse]];
        if mod(size(optimization_result.history, 1), 300) == 0
            disp(['iterations: ' num2str(size(optimization_result.history, 1))]);
        end

    end
end