%initialize constants for the Glide Slope simulation
clear
clc
close all
%% Define Constants
w_1 = 0.1 %gain]
Gamma_ref = 0 % should always be zero
gamma = 3 %[deg]
TF = 60

%% Run the model

sim('ILSGlideslope.mdl')