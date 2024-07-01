% Random seed
rng(0)

% Parameters for generating the data
D = 5;
T = 100;
C = eye(D); % noise covariance

% Parameters for modeling the intervention
i1 = 1; % Node to be intervende upon
i2 = 2; % Node to observe the effect at
Tint = 40; % time of intervention start
dX= zeros(1,D); dX(i1) = 1; % Intervention to be repeatedly applied

% Model parameters
Q = 2;
Btensor = 0.3*(rand(D,D,Q)-0.5);
Btensor(:,:,1) = Btensor(:,:,1) + eye(D)*0.5;

% Plotting parameters
NoSTDs = 2; % Number of standard deviations in the confidence intervals

%% Generate data for both time series
tt = (1:T)';
Xobs = zeros(T,D);
Xint = Xobs;

% Intervention moment
u = zeros(T,D);
u(:,i1) = 1 + randn(T,1);
u(:,i1) = 10*(1 + sin(tt/5));
Binttensor = Btensor;
Binttensor(:,i1,:) = 0;
% Binttensor(i1,i1,1) = 0.9;

% Noise
w = randn(T,D)*chol(C);

for t = Q+1:T
    Xobs(t,:) = w(t,:);
    for q = 1:Q
        Xobs(t,:) = Xobs(t,:) + Xobs(t-q,:)*Btensor(:,:,q);
    end

    if t < Tint
        Xint(t,:) = Xobs(t,:);
    else
        % Intervention (we are only injecting stimulus)
        Xint(t,:)  = w(t,:);
        % Additive intervention
        Xint(t,i1) = u(t,i1);
        for q = 1:Q
            Xint(t,:) = Xint(t,:) + Xint(t-q,:)*Binttensor(:,:,q);
        end
    end
end

%% 1. Compute the T tensor
Ttensor = total_causal_effect(Binttensor,T);

%% 2. Use observational data and T matrix to anticipate the change in X
Xpredint = Xobs;

% Make counterfactual predictions
for t = Tint:T
    for s = Tint:t-1
        k = t-s;
        Xpredint(t,:) = Xpredint(t,:) + u(s,:)*Ttensor(:,:,k);
    end
end


%% Plot the results
figure(2)
tiledlayout(1,1,'Padding','tight')

nexttile
plot(Xobs(:,i2),'k-+','LineWidth',1);
hold on;
plot(Xint(:,i2),'b-o','LineWidth',1);
plot(Xpredint(:,i2),'r-','LineWidth',1);
hold off;

xlabel('Time')
title('Counterfactual analysis of x_{2,t}')

legend('Observed time series','Alternate universe',...
    'Prediction of counterfactual event','Location','best')


