import = load('SS_ILS.mat')
SS_ILS = import.SS_long

SS_ILS.C = [0 0 1 0 0]
[num_alpha,den_alpha] = ss2tf(SS_ILS.A, SS_ILS.B, SS_ILS.C, SS_ILS.D, 1)

SS_ILS.C = [0 0 0 1 0]
[num_theta,den_theta] = ss2tf(SS_ILS.A, SS_ILS.B, SS_ILS.C, SS_ILS.D, 1)

transfer_function = 1 - tf(num_alpha, num_theta)

save transfer_functions_ILS.mat transfer_function ;