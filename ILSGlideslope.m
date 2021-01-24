%initialize constants for the Glide Slope simulation
clear
clc
close all
%% Define Constants
w_1 = 0.1 %gain
Gamma_ref = 0 % should always be zero
gamma = 3 %[deg]
H_0 = 5000 %[ft]
V_0 = 300 %[ft/s]
R_0 = 6737.5 %[ft] 5000ft altitude, 8 miles away from RWY 
T_0 = 1000 %[lb] initial thrust setting
TF = 5 % dummy simulation time

SS_lonA = [0,0,-299.999999992592,299.999999993193,0;
    0.000131652666249915,-0.0290966195151544,2.12995393381544,-32.1699999992045,-2.89516413593323;
    3.15369085604705e-06,-0.000696998743156418,-0.544660714511094,4.54984550946307e-13,0.915224835355286;
    0,0,0,0,1.00000000000000;
    -4.69868043886612e-21,1.03845763891205e-18,0.330324307903510,0,-0.816944109554731]

SS_lonB = [0,0;-0.00453382205143473,0.00154396044469381;
    -0.00111635553348495,-9.49308816068371e-07;
    0,0;
    -0.0570163434913098,0]

SS_lonC = [1 0 0 0 0]

SS_lonD = [0 0]


%% Run the model

sim('ILSGlideslopeSimulink.mdl')