function [prob] = check_prob_nn(x1,y1,b,x,y,eta)

errvec = sqrt((x-x1).^2+(y-y1).^2);
sorted = sort(errvec,'ascend');
d_min = sorted(1);
prob = tanh(eta*d_min);