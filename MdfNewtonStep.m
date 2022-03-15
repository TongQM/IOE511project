% Function that: (1) computes the Newton step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,d,alpha, Hess_modified] = MdfNewtonStep(x, f, g, H, problem, method, options)
Hess_modified = 0;
if min(eig(H)) <= 0
    L = MdfFindL(H, method.options.beta, problem.n);
    H = L*L';
    Hess_modified = 1;
end
% search direction is -g
d = -H\g;

% determine step size
alpha = backtracking(problem, method, x, d);
x_new = x + alpha*d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);
end