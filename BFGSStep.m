% Function that: (1) computes the BFGS step; (2) updates the iterate; and, 
%                (3) computes the function and gradient, Hessian at the new iterate
% 
%           Inputs: x, f, g, problem, method, options
%           Outputs: x_new, f_new, g_new, d, H1
%
function [x_new, f_new, g_new, d, H1, update_skipped] = BFGSStep(x, f, g, H0, problem, method, options)
d = -H0*g;
alpha = 1;
x_new = x + alpha*d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);
s = x_new - x;
y = problem.compute_g(x_new) - g;
update_skipped = 0;
if s'*y < options.term_tol*norm(s, 2)*norm(y, 2)
    H1 = H0;
    update_skipped = 1;
else
    rho = 1/(s'*y);
    V = eye(problem.n) - rho*y*s';
    H1 = V'*H0*V + rho*(s*s');
end
end