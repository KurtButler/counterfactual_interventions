function [B] = offline_lasso(D, T, X, lag, indices)

% Initialize matrix variable
B = zeros(D*lag, D);

% My data notation
y = X(lag+1:T,:);
H = [];
range = 0:T-lag-1;
for l = 1:lag
    H = [ X(l + range, :)  H ];
end

% ESTIMATE TOPOLOGY

% Define initial batch data


for j = 1 : D
    
    % Initial batch terms for each row
    y0 = y(indices{j}-lag, j)';
    H0 = H(indices{j}-lag, :);
    
    
    % Initial LASSO estimate
    [THETA, STATS] = lasso(H0, y0, 'CV', 10);
    B(:,j) = THETA(:, STATS.IndexMinMSE);
    
end


end