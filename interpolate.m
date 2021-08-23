function [] = interpolate(x,L,h,h_names)
    x_p= zeros(1000,1);
    x_p(1:3:end)= x; %zero padding
%     h= L.*[pidiv2filt; pidiv3filt ;pidiv4filt ;pidiv6filt];
%     h_names= ["pidiv2filt"; "pidiv3filt" ;"pidiv4filt" ;"pidiv6filt"];
    figure(3);
    for i=1:4
        x_i= conv(h(i,:),x_p);
        X_i= fftshift(fft(x_i));
        subplot(2,2,i)
        plotFFT(X,'|X(e^j^w)|')
        hold on;
        plotFFT(X_i,'H_i='+h_names(i))
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

