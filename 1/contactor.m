clc;
clear all;
load('M.mat')
%[xsag, ysag] = load_bus_data(5,M);

for i=1:20
    xsag(i) = 5*rand();
    ysag(i) = rand();
end
x_cont = [4 3.8 3.1 2.4 2.3 3 4 5 6 7 8 9];
y_cont = [0 0.11 0.2 0.3 0.4 0.43 0.45 0.51 0.52 0.53 0.54 0.55];
x = x_cont'; y = y_cont';f = fit(y,x,'poly4');
Y = [ones(size(y)) y y.^2 y.^3 y.^4];
b = coeffvalues(f);

%b = regress(x,Y);
%prob = check_prob2(xsag, ysag, b, 0.9);
%plot(Y*b,y); hold on; stem(xsag, ysag);
plot(y, f(y)); %hold on; plot (x,y);
