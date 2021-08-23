close all;
clear all;
clc;
c= 0.7*2.82*10^(-3)/(0.5*9);
%---H1---
numerator1= c*poly([0.5 4*exp(1j*pi/3) 4*exp(-1j*pi/3)]);
denominator = poly([0.3 0.95*exp(1j*pi/8) 0.95*exp(-1j*pi/8)]);
H1= freqz(numerator1,denominator);
%---H2---
%the numerator is multiplied by 0.5 due to the change in representation of
%(1-a*z)-> -a*(z-1/a*)
%but the minus sign is irelevent in our case.
numerator2= c*0.5*poly([2 4*exp(1j*pi/3) 4*exp(-1j*pi/3)]); 
H2= freqz(numerator2,denominator);
%---H3---
numerator3= c*4*4*poly([0.5 (1/4)*exp(-1j*pi/3) (1/4)*exp(1j*pi/3)]);
H3= freqz(numerator3,denominator);
%---H4---
numerator4= c*4*4*0.5*poly([2 (1/4)*exp(-1j*pi/3) (1/4)*exp(1j*pi/3)]);
H4= freqz(numerator4,denominator);


%Trnasfer Functions
Z1 = [0.5 4*exp(1j*pi/8) 4*exp(-1j*pi/8)]';
P1 = [0.3 0.95*exp(1j*pi/3) 0.95*exp(-1j*pi/3)]';
K1 = 1/7.2;
K2 = K1 * (-0.5);
K3 = 16*K1;
K4 = 16*K2;
Z2 = [2 4*exp(1j*pi/8) 4*exp(-1j*pi/8)]';
Z3 = [0.5 1/(4*exp(1j*pi/8)) 1/(4*exp(-1j*pi/8))]';
Z4 = [2 1/(4*exp(1j*pi/8)) 1/(4*exp(-1j*pi/8))]';
P2 = P1;
P3 = P1;
P4 = P1;
% [a1,b1] = zp2tf(Z1, P1, K1);
% [a2,b2] = zp2tf(Z2, P2, K2);
% [a3,b3] = zp2tf(Z3, P3, K3);
% [a4,b4] = zp2tf(Z4, P4, K4);
% a = [a1 a2 a3 a4];
% b = [b1 b2 b3 b4];
[numerator1,denominator] = zp2tf(Z1, P1, K1);
[numerator2,] = zp2tf(Z2, P2, K2);
[numerator3,] = zp2tf(Z3, P3, K3);
[numerator4,] = zp2tf(Z4, P4, K4);

[H1,w1]= freqz(numerator1,denominator);
[H2,w2]= freqz(numerator2,denominator);
[H3,w3]= freqz(numerator3,denominator);
[H4,w4]= freqz(numerator4,denominator);




%Plot:
figure();
w= linspace (0,2*pi,length(H1));
H = [H1 H2 H3 H4];
W = [w1 w2 w3 w4];
Numerator = [numerator1.' numerator2.' numerator3.' numerator4.'];
i=1;
for lamda=1:4
    subplot(4,2,i)
    plot(W(:,lamda),abs(H(:,lamda)))
    title(sprintf('|H_%d(e^{jw})|',lamda));
    xlabel('\omega [rad]');
%     axis ([0 2*pi 0 0.2]);
    subplot(4,2,i+1)
    zplane(Numerator(:,lamda).',denominator);
    title(sprintf('Poles &Zeros of H_%d(e^{jw})',lamda));
    i=i+2;
end

figure();
for i=1:4
    subplot(4,1,i)
    for lamda=1:4
        switch i
            case 1   
                plot(w,unwrap(angle(H(:,lamda))));
                title('\phi(H(e^{jw}))');
                xlabel('\omega [rad]');
                legend('H_1(e^{jw})','H_2(e^{jw})','H_3(e^{jw})','H_4(e^{jw})');
                hold on;
            case 2
                plot(w,grpdelay(Numerator(:,lamda).',denominator));
                title('GropDelay(H(e^{jw}))');
                xlabel('\omega [rad]');
                legend('H_1(e^{jw})','H_2(e^{jw})','H_3(e^{jw})','H_4(e^{jw})');
                hold on;
            case 3
                impz(Numerator(:,lamda).',denominator);
                title('h[n]');
                xlabel('n');
                legend('h_1[n]','h_2[n]','h_3n]','h_4[n]');
                hold on;
            otherwise
                [h,n] = impz(Numerator(:,lamda).',denominator);
                for m=1:51
                    E(m)= sum((h(1:m).^2));
                end
              
                plot([0:50],E);
                title('E_h[m]');
                xlabel('m');
                legend('E_h_1[m]','E_h_2[m]','E_h_3[m]','E_h_4[m]');
                hold on;
        end
    end

end

