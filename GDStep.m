% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that: (1) computes the GD step; (2) updates the iterate; and, 
%                (3) computes the function and gradient at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, alpha
%
function [x_new,f_new,g_new,d,alpha] = GDStep(x, f, g, problem, method, options)

% search direction is -g
d = -g;
% determine step size
alpha = backtracking(problem, method,x,d);
x_new = x + alpha*d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);
end

