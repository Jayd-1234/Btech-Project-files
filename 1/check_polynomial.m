clc;
clear all;
load('V_sag.mat')
%[ysag, xsag] = load_bus_data(5,V_sag);

for i=1:300
   ysag(i) = 5*rand();
   xsag(i) = rand();
end
y_cont = [4 3.8 3.1 2.4 2.3 3 4 5 6 7 8 9];
x_cont = [0 0.11 0.2 0.3 0.4 0.43 0.45 0.51 0.52 0.53 0.54 0.55];
x = x_cont'; y = y_cont';f = fit(x,y,'poly4');
x = 0:0.01:max(x_cont);
%rbf = newrb(x_cont,y_cont,0.0002,1, 100);
Y = [ones(size(y)) y y.^2 y.^3 y.^4];
b = coeffvalues(f);
x = 0:0.01:0.6;
plot(y_cont, x_cont, 'LineWidth', 2);
for i=1:length(xsag)
    x_check = 0:0.01:0.7;
    [pks, ind] = findpeaks(-polynomial_objective(x_check, b , ysag(i)));
    x_f = sort(x_check(ind));
    y_f = f(xsag(i));
    if size(x_f)== 2
        if (x_f(1) < xsag(i)) && (x_f(2) > xsag(i)) && (y_f < ysag(i))
            prob = abs(tanh(-0.6*(x_f(1)-xsag(i))*(-x_f(2)+xsag(i))*(-y_f+ysag(i))));
            hold on; plot(ysag(i), xsag(i), 'r*');
        else
            prob = -abs(tanh(-0.6*(x_f(1)-xsag(i))*(-x_f(2)+xsag(i))*(-y_f+ysag(i))));
            hold on; plot(ysag(i), xsag(i), 'b*');
        end
    else
        if (y_f > ysag(i))
            
            prob = abs(tanh(0.6*(x_f-xsag(i))*(y_f-ysag(i))));
            hold on; plot(ysag(i), xsag(i), 'r*');
        else
            prob = -abs(tanh(0.6*(x_f-xsag(i))*(y_f-ysag(i))));
            hold on; plot(ysag(i), xsag(i), 'b*');
        end
    end
end
 