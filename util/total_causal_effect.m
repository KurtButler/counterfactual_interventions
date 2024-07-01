function Ttensor = total_causal_effect(Btensor,K)
% Input:
%   Btensor : DxDxQ tensor -should be the matrix coefficients B
%   K       : Maximum no. of time steps that you care to forecast.
%
% Output:
%   Ttensor : DxDxK tensor. Ttensor(:,:,k) is the total causal effect from
%               x(t) to x(t+k)

[D,DD,Q] = size(Btensor);
if D ~= DD
    error('B matrix is not square. Total causal effect cannot be computed.')
end
Ttensor = zeros(D,D,K);
for k = 1:K
    for q = 1:Q
        if k-q>0
            Ttensor(:,:,k) = Ttensor(:,:,k) + Ttensor(:,:,k-q)*Btensor(:,:,q);
        elseif k==q
            Ttensor(:,:,k) = Ttensor(:,:,k) + Btensor(:,:,q);
        end
    end
end
end

