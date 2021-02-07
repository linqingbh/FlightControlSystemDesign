% ==================================
% Description
% ==================================
%
% This matlab file creates the desired state-spaces, both for the
% longitudinal and lateral case.
%
% First you need to run the FindF16Dynamics.m file and run this file next.
%
% Do you want to save the state-spaces in a .mat file?
saving = false;

%%
% ==================================
% Imports
% ==================================

% Import of low fidelity model
[A_long_lo, B_long_lo, C_long_lo, D_long_lo] = ssdata(SS_long_lo);
[A_lat_lo, B_lat_lo, C_lat_lo, D_lat_lo] = ssdata(SS_lat_lo);

%% 
% ==================================
% Longitudinal case
% ==================================

% Create longitudinal Aa/c
Aac_long = A_long_lo;
% Take right rows and columns
Aac_long([1,6,7],:) = [];
Aac_long(:,[1,6,7]) = [];
% Get right order
Aac_long = Aac_long([2,3,1,4],[2,3,1,4]);

% Create longitudinal Ba/c
Bac_long = A_long_lo;
% Take right rows and columns
Bac_long([1,6,7],:) = [];
Bac_long(:,[1,2,3,4,5,6]) = [];
% Get right order
Bac_long = Bac_long([2,3,1,4],[1]);

% Create longitudinal Ca/c
Cac_long = [1 0 0 0];

% Create longitudinal Da/c
Dac_long = 0;

% Create longitudinal state-space model
SS_long = ss(Aac_long,Bac_long,Cac_long,Dac_long);

% Change names
SS_long.StateName = {'vT','alpha','theta','q'};
SS_long.InputName = {'del'};

%%
% ==================================
% Lateral case
% ==================================

% Create lateral Aa/c
Aac_lat = A_lat_lo;
% Take right rows and columns
Aac_lat([2,3,7,8,9],:) = [];
Aac_lat(:,[2,3,7,8,9]) = [];
% Get right order
Aac_lat = Aac_lat([2,1,3,4],[2,1,3,4]);

% Create lateral Ba/c
Bac_lat = A_lat_lo;
% Take right rows and columns
Bac_lat([2,3,7,8,9],:) = [];
Bac_lat(:,[1,2,3,4,5,6,7]) = [];
% Get right order
Bac_lat = Bac_lat([2,1,3,4],[1,2]);

% Create lateral Ca/c
Cac_lat = [1 0 0 0];

% Create longitudinal Da/c
Dac_lat = 0;

% Create lateral state-space model
SS_lat = ss(Aac_lat,Bac_lat,Cac_lat,Dac_lat);

% Change names
SS_lat.StateName = {'beta','phi','p','r'};
SS_lat.InputName = {'da','dr'};

%%
% ==================================
% Save the state-spaces
% ==================================

% Save lateral state-space model
if saving
    save StateSpace.mat SS_long SS_lat;
end