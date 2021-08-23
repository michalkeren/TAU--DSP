% writen by Michal Keren 7.6.21
close all;
clc;

%% ----A-----%
fs= 1000;
Ts=1/fs;
t= linspace(0,1,1000); % the spacing is exacly 1/fs.
x=(1.5*cos(2*pi*40.*t) + sin(2*pi*120.*t)).*exp(-100.*(t-0.5).^2);
%FFT:
X= fftshift(fft(x));    
plotFFT(X,'|X(e^j^w)|')

%% ----B-----%
%decimation by 3:
L=3;
x_d3= x(1:L:end);
X_d3= fftshift(fft(x_d3));
figure(2);
plotFFT(X,'|X(e^j^w)|')
hold on;
plotFFT(X_d3,'')
legend('|X(e^j^w)|','|X_d_3(e^j^w)|')
%interpolation by 3:

x_p3= zeros(1000,1);
x_p3(1:3:end)= x_d3; %zero padding
load('ex1.mat');
h= L.*[pidiv2filt; pidiv3filt ;pidiv4filt ;pidiv6filt];
h_names= ["pidiv2filt"; "pidiv3filt" ;"pidiv4filt" ;"pidiv6filt"];
figure(3);
for i=1:4
    x_int= conv(h(i,:),x_p3,'same');
    X_int= fftshift(fft(x_int));
    subplot(2,2,i)
    plotFFT(X,'|X(e^j^w)|')
    hold on;
    plotFFT(X_int,'H_i='+h_names(i))
    legend('original','X_i')
    hold off;
    ylim([0 200])
    xlim([-pi pi])
end
%plots in time domain
figure(4);
for i=1:4
    x_int= conv(h(i,:),x_p3);
    subplot(2,2,i)
    plot(t,x);
    hold on;
    ti= linspace(0,1,length(x_int));
    plot(ti,x_int);
    title('H_i='+h_names(i));
    legend('original','x_i')
    xlabel('t')
    hold off;
end

% %---plot the filters---%
% figure(5);
% for i=1:4
%     H= fftshift(fft(h(i,:)));
%     subplot(2,2,i)
%     plotFFT(fftshift(fft(x_p3)),'')
%     hold on 
%     plotFFT(H,'H_i='+h_names(i))
%     legend('X_p_3','H_i')
%     ylim([0 30])
%     xlim([-pi pi])
%     hold off;
% end
% sgtitle('|H_i(e^j^w)|') 

%% ----C-----%
%decimation by 6:
L=6;
x_d6= x(1:6:end);
X_d6= fftshift(fft(x_d6));
figure(5);
plotFFT(X,'|X(e^j^w)|')
hold on;
plotFFT(X_d6,'')
legend('|X(e^j^w)|','|X_d_6(e^j^w)|')
%interpolation by 6:
x_p6= zeros(1000,1);
x_p6(1:6:end)= x_d6; %zero padding
h= L.*[pidiv2filt; pidiv3filt ;pidiv4filt ;pidiv6filt];
h_names= ["pidiv2filt"; "pidiv3filt" ;"pidiv4filt" ;"pidiv6filt"];
figure(6);
for i=1:4
    x_int= conv(h(i,:),x_p6);
    X_int= fftshift(fft(x_int));
    subplot(2,2,i)
    plotFFT(X,'|X(e^j^w)|')
    hold on;
    plotFFT(X_int,'H_i='+h_names(i))
    legend('original','X_i')
    ylim([0 150])
    xlim([-pi pi])
    hold off;
end
%plots in time domain
figure(7);
for i=1:4
    x_int= conv(h(i,:),x_p6);
    subplot(2,2,i)
    plot(t,x);
    hold on;
    ti= linspace(0,1,length(x_int));
    plot(ti,x_int);
    legend('original','x_i')
    title('H_i='+h_names(i));
    xlabel('t')
    hold off;
end

%---plot the filters---%
figure(8);
for i=1:4
    H= fftshift(fft(h(i,:)));
    subplot(2,2,i)
    plotFFT(H,'H_i='+h_names(i))
%     hold on;
%     plotFFT(X_int,'H_i='+h_names(i))
%     legend('original','X_i')
%     ylim([0 300])
    xlim([-pi pi])
    hold off;
end
sgtitle('|H_i(e^j^w)|') 

%% ----D-----%
%Anti Aliasing filter:
wc =pi/6;
x_aa= lowpass(x,wc,fs);
figure(9);
plot(t,x)
hold on;
plot(t,x_aa);
legend('x','x_a_a');
xlabel('t')
hold off
X_aa = fftshift(fft(x_aa));

%decimation by 6:
x_d6_aa= x_aa(1:6:end);
X_d6_aa= fftshift(fft(x_d6_aa));
figure(10);
plotFFT(X,'|X(e^j^w)|')
hold on;
plotFFT(X_d6,'')
hold on;
plotFFT(X_d6_aa,'')
legend('|X(e^j^w)|','|X_d_6(e^j^w)|','|X_d_6_a_a(e^j^w)|')




%interpolation by 6:
x_p6= zeros(1000,1);
x_p6(1:6:end)= x_d6; %zero padding
h= 6.*[pidiv2filt; pidiv3filt ;pidiv4filt ;pidiv6filt];
h_names= ["pidiv2filt"; "pidiv3filt" ;"pidiv4filt" ;"pidiv6filt"];
figure(11);
for i=1:4
    x_int= conv(h(i,:),x_p6);
    X_int= fftshift(fft(x_int));
    subplot(2,2,i)
    plotFFT(X,'|X(e^j^w)|')
    hold on;
    plotFFT(X_aa,'|X_a_a(e^j^w)|')
    hold on;
    plotFFT(X_int,'H_i='+h_names(i))
    legend('|X(e^j^w)|','|X_a_a(e^j^w)|','|X_i(e^j^w)|')
    hold off;
    ylim([0 150])
end
figure(12);
for i=1:4
    x_int= conv(h(i,:),x_p6);
    subplot(2,2,i)
%     plot(t,x);
%     hold on;
    plot(t,x_aa);
    hold on;
    ti= linspace(0,1,length(x_int));
    plot(ti,x_int);
    legend('x_a_a','x_i')
    title('H_i='+h_names(i));
    xlabel('t')
    hold off;
end
