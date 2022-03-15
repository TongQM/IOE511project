% Function that: (1) computes the LBFGS step; (2) updates the iterate; and, 
%                (3) computes the function and gradient, Hessian at the new iterate
% 
%           Inputs: x, f, g, S, Y, problem, method, options
%           Outputs: x_new, f_new, g_new, d, s_new, y_new
%
function [x_new, f_new, g_new, d, s_new, y_new] = LBFGSStep(x, f, g, S, Y, problem, method, options)
m = min(method.m, size(S, 2));
q = g;
alpha = zeros(m, 1);
rho = zeros(m, 1);
for i = 1:m
    rho(m-i+1) = 1/(S(:,m-i+1)'*Y(:,m-i+1));
    alpha(m-i+1) = rho(m-i+1)*(S(:,m-i+1)'*q);
    q = q - alpha(m-i+1)*Y(:, m-i+1);
end
r = method.Hk0*q;
for j = 1:m
    beta = rho(j)*Y(:,j)'*r;
    r = r + S(:, j)*(alpha(j)-beta);
end
d = -r;
x_new = x + d;
f_new = problem.compute_f(x_new);
g_new = problem.compute_g(x_new);
s_new = x_new - x;
y_new = g_new - g;
end