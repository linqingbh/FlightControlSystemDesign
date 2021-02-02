%initialize constants for the Glide Slope simulation
clear
clc
close all
%% Define Constants
w_1 = 0.1 %gain
Gamma_ref = 0 % should always be zero
gamma = 3 %[deg]
Initial_elevator = -4.1 %[deg]
H_0 = 5000 %[ft]
H   = 5000  %[ft] actual altitude
V_ref = 300 %[ft/s]
R_init = 6737.5 %[ft] 5000ft altitude, 8 miles away from RWY 
Initial_throttle = 1000 %[lb] initial thrust setting
TF = 5 % dummy simulation time per 'iteration'
H_flare = 3050 %[ft] = 50 ft AGL
t_sim = 0 %[s] simulation time
tau = 1.1233 %[s] time constant for flare mode






sim('ILSGlideslopeSimulink.mdl')
%sim('flare_mode_saturation.slx')


    
