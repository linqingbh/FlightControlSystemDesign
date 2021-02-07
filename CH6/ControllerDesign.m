% ==================================
% Description
% ==================================
%
% This matlab file contains the design of a pitch rate command system satisfying CAP/Gibson Mil-specs
%

%%
% ==================================
% Inputs
% ==================================

figures = false;

ft = 0.3048;    % [m]
V = 600*ft;     % [m/s]
V_gust = 4.572; % [m/s]
g = 9.81;       % [m/s2]

%%
% ==================================
% Import State Space model
% ==================================

import = load('StateSpace.mat');
ss_long = import.SS_long;
ss_long.C = [0 0 0 1];
ss_long.D = [0];

%%
% ==================================
% Create short period reduced model
% ==================================

A_pitch = ss_long.A;
A_pitch([1,3],:) = [];
A_pitch(:,[1,3]) = [];

B_pitch = ss_long.B;
B_pitch([1,3],:) = [];

C_q = [0 1];
D_pitch = [0];

ss_pitch = ss(A_pitch,B_pitch,C_q,D_pitch);

ss_pitch.StateName = {'alpha','q'};
ss_pitch.InputName = {'del'};

%%
% ==================================
% Step input
% ==================================

if figures
    %figure('Name','4 State Model');
    %step(ss_long);
    t = 0:0.5:1400;
    y = step(ss_long,t);
    figure;
    plot(t,y);
    title('Step Response 4 State Model')
    xlabel('t [s]')
    ylabel('q [rad/s]')
    
    %figure('Name','2 State Model');
    %step(ss_pitch);
    t = 0:0.05:9;
    y = step(ss_pitch,t);
    figure;
    plot(t,y);
    title('Step Response 2 State Model')
    xlabel('t [s]')
    ylabel('q [rad/s]')
end

%%
% ==================================
% Requirements and properties
% ==================================

e = eig(A_pitch);
re_e = real(e(1));
im_e = imag(e(1));

C_alpha = [1 0];
[Num_q,Den_q] = ss2tf(A_pitch,B_pitch,C_q,D_pitch);
[Num_alpha,Den_alpha] = ss2tf(A_pitch,B_pitch,C_alpha,D_pitch);

wn = sqrt(re_e^2 + im_e^2);
Ttheta2 = Num_q(2)/Num_q(3);
damp = -re_e/wn;

wn_req = 0.03*V;
Ttheta2_req = 1/(0.75*wn_req);
damp_req = 0.5;

%%
% ==================================
% Design
% ==================================

% Natural frequency and Damping

Re_p_req = -damp_req*wn_req;
Im_p_req = sqrt(wn_req^2 - Re_p_req^2);
pole_req = Re_p_req + Im_p_req*1i;

a1 = 2*damp_req*wn_req;
a2 = wn_req^2;
ac_A = A_pitch^2 + a1*A_pitch + a2*[1 0; 0 1];

C_M = [B_pitch A_pitch*B_pitch];

K = [0 1]*inv(C_M)*ac_A;

K_alpha = K(1);
K_q = K(2);

a_induced = atan(V_gust/V);
de_gust = K_alpha*a_induced;

% Time constant

H_q = tf(Num_q,Den_q);
H_alpha = tf(Num_alpha,Den_alpha);

A_CL = A_pitch - B_pitch*K;

[Num_CL,Den_CL] = ss2tf(A_CL,B_pitch,C_q,D_pitch);
H_CL = tf(Num_CL,Den_CL);

K_ll = Ttheta2_req/Ttheta2;
z_ll = [1 1/Ttheta2_req];
p_ll = [1 1/Ttheta2];

LeadLag = K_ll*tf(z_ll,p_ll);

H_pitch = H_CL*LeadLag;

%%
% ==================================
% Requirement verification
% ==================================

% Design point
CAP_d = wn_req^2/((V/g)*(1/Ttheta2_req));

DBqss_d = Ttheta2_req - 2*damp_req/wn_req;
t_d = 0:0.01:1.8;
y_d = step(H_pitch,t_d);
qm_d = min(y_d);
qs_d = y_d(end);
qmqs_d = qm_d/qs_d;

% Current parameter
CAP_c = wn^2/((V/g)*(1/Ttheta2));

DBqss_c = Ttheta2 - 2*damp/wn;
t_c = 0:0.05:9;
y_c = step(ss_pitch,t_c);
qm_c = min(y_c);
qs_c = y_c(end);
qmqs_c = qm_c/qs_c;

% Time responses
if figures
    figure;
    plot(t_d,y_d);
    title('Step Response Pitch Rate Command System')
    xlabel('t [s]')
    ylabel('q [rad/s]')
    
    integrator = tf([0 1],[1 0]);
    t = 0:0.01:5;
    y = step(H_pitch*integrator,t);
    figure;
    plot(t,y);
    title('Step Response Pitch Rate Command System');
    xlabel('t [s]')
    ylabel('\theta [rad]')
end