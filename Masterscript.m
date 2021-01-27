%initialize constants for the Glide Slope simulation
clear
clc
close all
%% Define Constants
w_1 = 0.1 %gain
Gamma_ref = 0 % should always be zero
gamma = 3 %[deg]
H_0 = 5000 %[ft]
H   = 5000  %[ft] actual altitude
V_0 = 300 %[ft/s]
R_0 = 6737.5 %[ft] 5000ft altitude, 8 miles away from RWY 
T_0 = 1000 %[lb] initial thrust setting
TF = 5 % dummy simulation time per 'iteration'
H_flare = 3050 %[ft] = 50 ft AGL
t_sim = 0 %[s] simulation time


%% Run the GlideSlope Model while H > H_flare
while H > H_flare;
    sim('ILSGlideslopeSimulink.mdl');
    t_sim += TF
    H = yout.getElement('H');
    
    figure
    plot(TF, t_sim)
end
%while H > 3000
    %sim('flare.mdl')
    %t_sim += TF
    