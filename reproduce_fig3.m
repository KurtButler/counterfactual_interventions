clear all
close all
clc

% Seed
%rng(1)

addpath('util/')

%% SINGLE LAG

% Size of data
T = 350;

% Data size to use for comparison
T0 = 250;

% Dimension of system
D = 5;

% Nodes Intervened upon
i1 = 1;
i2 = 2;

% Intervention settings
stimfrequency = 1/2;

% The times of interventions 1 and 2
tint1 = 101:170;
tint2 = 201:270;

lag = 2;
CL = 0.35;
sp = 0.4;
[X,B] = generate_data(D, T, lag, i1, i2, tint1, tint2, stimfrequency, CL, sp);



%% Base Model - D0 only

% % Indices of base model (not intervened)
idx_all = setdiff(lag+1:T, [tint1, tint2]);
indices = cell(1,D);
indices(:) = {idx_all};

% % Initial lasso
[B_obs] = offline_lasso(D, T, X, lag, indices);

%% Base Model Learning - D0 + D1 + D2

% Indices of base model (not intervened)
idx_all = lag+1:T0;
indices = cell(1,D);
indices(:) = {idx_all};
indices{i1} = setdiff(indices{i1}, tint1);
indices{i2} = setdiff(indices{i2}, tint2);

% Initial lasso
[B_est] = offline_lasso(D, T0, X, lag, indices);



%% PERFORMANCE

% COMPUTE MSE 
for l = 1:lag
    mse_prop(l) = sum(sum((B{l} - B_est((l-1)*D + 1: l*D, 1:D)).^2));
    mse_naive(l) = sum(sum((B{l} - B_obs((l-1)*D + 1: l*D, 1:D)).^2));
end



%% PLOT
figure(1)
tiledlayout(lag,3,'Padding','tight','TileSpacing','compact')


% Coeff Range
CL = 0.35;


loc = 1:3:lag*3;
for l = 1:lag
    nexttile(loc(l))
    imagesc(B{l})
    set(gca, 'clim', [-CL, CL]);
    str = join(['B_', num2str(l), '- true matrix']);
    title(str, 'FontSize',12)
end

for l = 1:lag  
    nexttile(loc(l)+1)
    imagesc(B_obs((l-1)*D + 1: l*D, 1:D))
    set(gca, 'clim', [-CL, CL]);
    str = join(['MSE =', num2str(mse_naive(l))]);
    str1 = join(['B_', num2str(l),' - observational data only']);
    str = [str newline str1];
    title(str, 'FontSize',12)
end

for l = 1:lag  
    nexttile
    imagesc(B_est((l-1)*D + 1: l*D, 1:D))   
    colorbar
    set(gca, 'clim', [-CL, CL]);
    str = join(['MSE =', num2str(mse_prop(l))]);
    str1 = join(['B_', num2str(l),' - proposed method']);
    str = [str newline str1];
    title(str, 'FontSize',12)
end

sgtitle('Estimation of Model Coefficients with Lag 2', 'FontSize',15)


% COLOR MAP settings
BOT = [0.2 0.2 1];
MID = [0.35 0 0.35];
TOP = [1 0.2 0.2];
u = linspace(0,1,500)';
COLS = [(1-u)*TOP + u*MID; u*BOT + (1-u)*MID;];
colormap(COLS)

set(gcf,'Position',[484 341 673 406])











%% Save figure
saveas(gcf,'./figs/fig3.png');