% IOE 511/MATH 562, University of Michigan
% Code written by: Albert S. Berahas

% Script to run code

%% close all figures, clear all variables from workspace and clear command
% window
close all
clear
clc
addpath(genpath(pwd));

%% set problem Rosenbrock (minimal requirement: name of problem)
problem.name = 'Rosenbrock';
problem.x0 = [1.2;1.2];
problem.n = length(problem.x0);
problem.x_star = [1;1];

%% set problem Function 2
problem.name = 'Function 2';
problem.y = [1.5; 2.25; 2.625];
problem.x0 = [1; 1];
problem.n = length(problem.x0);
problem.x_star = [3; 0.5];

%% set problem Function 3
problem.name = 'Function 3';
problem.n = 10;
problem.x0 = [1;zeros(problem.n-1, 1)];
problem.x_star = [log(1/19*(1+2*sqrt(5)));ones(problem.n-1, 1)];

%% set method Gradient Descent
method.name = 'GradientDescent';
method.options.alpha_bar = 1;
method.options.c1 = 1e-4;
method.options.tau = 0.5;

%% set method Modified Newton's method
method.name = 'MdfNewton';
method.options.alpha_bar = 1;
method.options.c1 = 1e-4;
method.options.tau = 0.5;
method.options.beta = 1e-6;
method.num_Hess_modified = 0;

%% set method BFGS
method.name = 'BFGS';
method.H0 = eye(problem.n);

%% set method LBFGS
method.name = 'LBFGS';
method.Hk0 = eye(problem.n);
method.m = 2;

%% set options and run
% set options
options.term_tol = 1e-6;
options.max_iterations = 1e3;

% run method and return x^* and f^*
t1 = clock;
[x,f] = optSolver_Miao_Yidi(problem,method,options);
t2 = clock;
etime(t2, t1)