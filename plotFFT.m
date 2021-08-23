function [] = plotFFT(X,name)
    w= linspace(-pi,pi,length(X));
    plot(w,abs(X))
    title(name);
    xlabel('\omega')
end

