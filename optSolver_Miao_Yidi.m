% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that runs a chosen algorithm on a chosen problem
%           Inputs: problem, method, options (structs)
%           Outputs: final iterate (x) and final function value (f)
function [x,f] = optSolver(problem, method, options)

% set problem, method and options
[problem] = setProblem(problem);
[method] = setMethod(method);
[options] = setOptions(options);

% compute initial function/gradient/Hessian
x = problem.x0;
f = problem.compute_f(x);
f_star = problem.compute_f(problem.x_star);
g = problem.compute_g(x);
switch method.name
    case 'BFGS'
        H = method.H0;
    case 'LBFGS'
        S = [];
        Y = [];
    otherwise
        H = problem.compute_H(x);
end
norm_g = norm(g,inf);
norm_g_0 = norm(g, inf);
f_values = [f];
num_Hess_modified = 0;
num_update_skipped = 0;
% set initial iteration counter
k = 0;

while (norm_g > options.term_tol*max(norm_g_0, 1) && k < options.max_iterations)
    
    % take step according to a chosen method
    switch method.name
        case 'GradientDescent'
            [x_new, f_new, g_new, d, alpha] = GDStep(x, f, g, problem, method, options);
        case 'MdfNewton'
            [x_new, f_new, g_new, d, alpha, Hess_modified] = MdfNewtonStep(x, f, g, H, problem, method, options);
            num_Hess_modified = num_Hess_modified + Hess_modified;
        case 'BFGS'
            [x_new, f_new, g_new, d, H, update_skipped] = BFGSStep(x, f, g, H, problem, method, options);
            num_update_skipped = num_update_skipped + update_skipped;
        case 'LBFGS'
            [x_new, f_new, g_new, d, s_new, y_new] = LBFGSStep(x, f, g, S, Y, problem, method, options);
            [S, Y] = constructSY(S, Y, s_new, y_new, method, options);
        otherwise
            
            error('Method not implemented yet!')
            
    end
    
    % update old and new function values
    x_old = x; f_old = f; g_old = g; norm_g_old = norm_g;
    x = x_new; f = f_new; g = g_new; norm_g = norm(g,inf);
    f_values = [f_values, f];
    % increment iteration counter
    k = k + 1;
    
end
switch method.name
    case 'MdfNewton'
        num_Hess_modified
    case 'BFGS'
        num_update_skipped
end
gaps = f_values - f_star;
semilogy([0:k], gaps, 'Linewidth', 3)
end