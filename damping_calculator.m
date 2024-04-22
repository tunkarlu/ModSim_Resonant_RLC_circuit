R_v = 468;
L = 2.2939e-3;
C = 1.0202e-6;
R_L = 0.82;

M1 = 0.526544;
M2 = 0.293430;
t = 0.292e-3;
delta = log(M1/M2);
D = delta/sqrt(4*pi*pi+delta*delta);
w = 2*pi/(t*sqrt(1-(D*D)));
b = 2*D/w;
Rd_opt = R_v*(b*R_L-L)/(L+R_v*R_L*C-b*R_v);

