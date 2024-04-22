R_v = 470;
R_d = 1000;
L = 2e-3;
C = 1e-6;
R_L = 0.8;
num = [R_d*L R_d*R_L];
den = [R_d*R_v*L*C R_d*L+R_v*L+R_d*R_L*R_v*C R_v*(R_d+R_L)];
G = tf(num,den);
