function [X, B] = generate_data(D, T, lag, i1, i2, tint1, tint2, stimfrequency, CL, sp)

% True Transition matrices
for l = 1:lag
    B{l} = create_B(CL, sp,  D);
end

% Covariance 
C = toeplitz([1, 0.5,zeros(1,D-2)]);
L = chol(C);

% Initialize Data
X = zeros(T,D);
X(1:lag,:) = mvnrnd(zeros(1,D), C, lag);

for t = lag+1:T

    transition = 0;
    for l = 1:lag
        transition = transition + X(t-l,:)*B{l};
    end
    % Base model 
    X(t,:) = transition + randn(1,D)*L;
    
    % Intervention 1
    if any(t == tint1)
        X(t,i1) = 10*sin(t*stimfrequency);
    end
    % Intervention 2
    if any(t == tint2)
        X(t,i2) = 10*sin(t*stimfrequency);
    end

end


end