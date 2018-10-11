function [ LRBFN_id, Distance ] = f_select_LRBFN( gate, x )
% select the proper LRBFN of x with kNN algorithm

k = 2;
[LRBFN_id, Distance] = knnsearch(gate.L, x', 'k', k); 

end