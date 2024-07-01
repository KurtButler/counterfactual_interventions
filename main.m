%% Matlab main file
% Title:   On Counterfactual Interventions in Vector Autoregressive Models
% Author:   Marija Iloska, Kurt Butler
% Date:     June 30, 2024
% Description:  Runs code used to generate experimental Figures from the 
%               paper and saves them to ./figs


%% Path configuration
addpath('./util')
addpath('./figs')

%% Run algorithms
% Estimation of model coefficients with lag 2
reproduce_fig3;

% Prediction of a counterfactual intervention
reproduce_fig4;