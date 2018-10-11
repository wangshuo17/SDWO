function [ rbf, optimization_result ] = f_rbfo_1( train, rbfctrs, optimAlgorithm )
% optimize the single width parameter

[model_samples, optimization_samples] = f_seperate(train, 0.8); % seperate the training and validation samples
x_dimen = size(rbfctrs, 1);
train_y = model_samples(x_dimen+1,:);
distance = f_distance(model_samples(1:x_dimen,:), rbfctrs);
distance_predict = f_distance(optimization_samples(1:x_dimen,:), rbfctrs);

optimization_result.history = [];      % optimization history
X0 = 1;                                % initial width
L = 0.1;                               % lower bound
U = 2;                                 % upper bound

switch optimAlgorithm
    case 1
        % fmincon
        [optimal_w, ~, exitflag, output] = fmincon(@obj, X0, [], [], [], [], L, U);
        
    case 2
        % PSO
        options = optimoptions('particleswarm','SwarmSize',20,'HybridFcn',@fmincon,'Display','off');
%         options = optimoptions('particleswarm','SwarmSize', 20,'Display','off');
        [optimal_w, ~, exitflag, output] = particleswarm(@obj, 1, L, U);

    case 3
        % MultiStart
        opts = optimoptions(@fmincon,'Algorithm','sqp', 'Display','none');
        problem = createOptimProblem('fmincon','objective', @obj,'x0',X0,'lb', L,'ub', U,'options',opts);
        ms = MultiStart;
        [optimal_w, ~, exitflag, output] = run(ms, problem, 15);
        
    case 4
        % GA
        [optimal_w, ~, exitflag, output] = ga(@obj, 1, [], [], [], [], L, U);
        
    case 5
        % GlobalSearch
        opts = optimoptions(@fmincon,'Algorithm','sqp');
        problem = createOptimProblem('fmincon','objective', @obj,'x0',X0,'lb', L,'ub', U,'options',opts);
        gs = GlobalSearch;
        [optimal_w, ~, exitflag, output] = run(gs, problem);
        
end

if(exitflag == 0)
    disp('optimization failed');
else
    disp('optimal width:');
    disp(optimal_w);
    rbf = f_rbfcw(model_samples, rbfctrs, optimal_w);
end


% ************************************** the objective function ********************************************
    function RMSE = obj(w)
        err = f_row_error(f_predict2( f_rbfcw2( train_y, rbfctrs, distance, w ), distance_predict ), optimization_samples(x_dimen+1,:));

        % minimize the RMSE
        RMSE = err.rmse;
        
        optimization_result.history = [optimization_result.history; [w RMSE]];
    end

end