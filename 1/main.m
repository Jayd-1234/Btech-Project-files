clc;
clear all;
load('V_sag.mat');
[x1, y1] = load_bus_data(5, V_sag);
x = [2:200]';
y = 0.5-0.5*exp(-(x-2));
rbf = newrb(x,y,0.0002,1);
X = [ones(size(x)) x x.^2 x.^3 x.^4 x.^5];
b = regress(y,X);
ypred2 = rbf(x);
ypred = X*b;
% x1 = [0:0.5:25];
% y1 = zeros(size(x1));
% parfor i=1:size(x1,2)
%     y1(i) = abs(randn())* 5;
% end
count = 0;
parfor i=1:size(x1,2)
    p(i) = check_prob(x1(i),y1(i),b,0.3);
    if (p(i)>0)
        count = count+1;
    end
end
 
plot(x,y, 'black', 'LineWidth',2); hold on;
for i=1:length(y1)
    if (p(i)>0) && (y1(i)<1)
        plot(x1(i), y1(i),'r*');
    else
        plot(x1(i), y1(i), 'b.');
    end
end
p(find(p>1))=1;
j=1;
for i=1:length(p)
    if (p(i)>0)
        x_data(j) = x1(i);
        y_data(j) = y1(i);
        z_data(j) = p(i);
        j = j+1;
    end
end
xlim([0,200]);ylim([0, 3]);