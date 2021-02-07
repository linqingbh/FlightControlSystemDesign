import = load('StateSpace.mat')
ss_long = import.SS_long
ss_lat = import.SS_lat

% Phugoid

[y_ph,t] = impulse(ss_long,linspace(0,1000,5000))

figure(1)
plot(t,-y_ph*0.3048)
yline(0, '--')
title('Elevator impulse response (Phugoid)')
xlabel('t [s]')
ylabel('delta V [m/s]')

% Short Period
ss_long.C = [0 1 0 0]

[y_sp,t] = impulse(ss_long,linspace(0,10,500))
figure(2)
plot(t,-y_sp*180/pi)
yline(0, '--')
title('Elevator impulse response (Short Period)')
xlabel('t [s]')
ylabel('delta alpha [deg]')

% Dutch Roll

[y_lat,t] = impulse(ss_lat,linspace(0,20,1000))
y_dr = y_lat(:,:,2)
figure(3)
plot(t,y_dr*180/pi)
yline(0, '--')
title('Rudder impulse response (Dutch Roll)')
xlabel('t [s]')
ylabel('delta bèta [deg]')

% Aperiodic Roll
ss_lat.C = [0 1 0 0]

[y_lat,t] = impulse(ss_lat,linspace(0,10,1000))
y_ar = y_lat(:,:,1)
figure(4)
plot(t,y_ar*180/pi)
title('Aileron impulse response (Aperiodic Roll)')
xlabel('t [s]')
ylabel('delta phi [deg]')

% Spiral

[y_lat,t] = impulse(ss_lat,linspace(0,300,20000))
y_sp = y_lat(:,:,1)
figure(5)
plot(t,y_sp*180/pi)
title('Aileron impulse response (Spiral)')
xlabel('t [s]')
ylabel('delta phi [deg]')