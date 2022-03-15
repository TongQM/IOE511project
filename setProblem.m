% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Function that specifies the problem. Specifically, a way to compute: 
%    (1) function values; (2) gradients; and, (3) Hessians (if necessary).
%
%           Input: problem (struct), required (problem.name)
%           Output: problem (struct)
%
% Error(s): 
%       (1) if problem name not specified;
%       (2) function handles (for function, gradient, Hessian) not found
%
function [problem] = setProblem(problem)

% check is problem name available
if ~isfield(problem,'name')
    error('Problem name not defined!!!')
end

% set function handles according the the selected problem
switch problem.name
        
    case 'Rosenbrock'
        
        problem.compute_f = @rosen_func;
        problem.compute_g = @rosen_grad;
        problem.compute_H = @rosen_Hess;
        
    case 'Function 2'
        
        problem.compute_f = @(x)func2_func(x, problem.y);
        problem.compute_g = @(x)func2_grad(x, problem.y);
        problem.compute_H = @(x)func2_Hess(x, problem.y);
        
    case 'Function 3'
        
        problem.compute_f = @(x)func3_func(x, problem.n);
        problem.compute_g = @(x)func3_grad(x, problem.n);
        problem.compute_H = @(x)func3_Hess(x, problem.n);
        
    otherwise
        
        error('Problem not defined!!!')
end