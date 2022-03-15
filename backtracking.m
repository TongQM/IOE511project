function [alpha] = backtracking(problem, method, x, d)
% Functions that calculate backtracking step size.
%               Inputs: problem, method (structs), d
%               Outputs: alpha (step size)

alpha = method.options.alpha_bar;
tau = method.options.tau;
c1 = method.options.c1;
while problem.compute_f(x + alpha*d) > problem.compute_f(x) + c1*alpha*problem.compute_g(x)'*d    
    alpha = tau*alpha;
end
end
