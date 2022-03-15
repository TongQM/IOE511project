% Function that: (1) construct new S and Y pairs depending on whether the
% latest pairs are positive enough
% 
%           Inputs: S_old, Y_old, s_new, y_new, method, options
%           Outputs: S_new, Y_new
%
function [S_new, Y_new] = constructSY(S_old, Y_old, s_new, y_new, method, options)
if s_new'*y_new < options.term_tol*norm(s_new, 2)*norm(y_new, 2)
    S_new = S_old;
    Y_new = Y_old;
else
    if size(S_old, 2) < method.m
        S_new = [S_old, s_new];
        Y_new = [Y_old, y_new];
    else
        S_new = [S_old(:,2:method.m), s_new];
        Y_new = [Y_old(:,2:method.m), y_new];
    end
end
end