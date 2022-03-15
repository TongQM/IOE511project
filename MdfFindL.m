% Function that: (1) compute the positive definite enough L for modified
% Newton's method
% 
%           Inputs: Hess H, beta, the size of H n
%           Outputs: L
%
function [L] = MdfFindL(H, beta, n)
if min(diag(H)) > 0
    eta = 0;
else
    eta = -min(diag(H)) + beta;
end
[L, flag] = chol(eta*eye(n) + H);
while flag ~= 0
    eta = max(2*eta, beta);
    [L, flag] = chol(eta*eye(n) + H);    
end
end