R_v = 468;
R_d = 978.9;
L = 2.2939e-3;
C = 1.0202e-6;
R_L = 0.82;
num = [R_d*L R_d*R_L];
den = [R_d*R_v*L*C R_d*L+R_v*L+R_d*R_L*R_v*C R_v*(R_d+R_L)];
G = tf(num,den);
