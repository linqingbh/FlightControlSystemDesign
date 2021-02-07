%initialize constants for the Glide Slope simulation
clear
clc
close all
%% Define Constants
w_1 = 0.1 %gain
Gamma_ref = 0 % should always be zero
alpha_ref = 0 
gamma_r = 3/180*pi %[deg]
Initial_elevator = -4.1891 %[deg]
H_0 = 5000 %[ft]
H   = 100  %[ft] actual altitude
V_ref = 300 %[ft/s]
R_init = 42000 %[ft] 5000ft altitude, 8 miles away from RWY 
TF = 500 % if H_flare is not reached within this time, the simulation ends
H_flare = 3017.5 %[ft] = 17.5 ft AGL
tau = 1.1233 %[s] time constant for flare mode
Ground_elevation = 3000 %[ft]






sim('ILSGlideslopeSimulinkRIK.mdl')
%sim('flare_mode_saturation.slx')


    
