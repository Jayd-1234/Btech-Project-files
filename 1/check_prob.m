function [prob] = check_prob(x1,y1,b,eta)
 
y_f = b(1)+b(2)*x1+b(3)*x1^2+b(4)*x1^3+b(5)*x1^4+b(6)*x1^5;
x_f1 = (b'*b)\b'*y1;
x_f= x_f1(2);
prob = tanh(eta*(sqrt((x_f-x1)^2/max(x_f,x1)+(y1-y_f)^2/max(y1,y_f))))*(tanh(eta*(x_f-x1))/abs(tanh(eta*(x_f-x1))))*(tanh(eta*(y1-y_f))/abs(tanh(eta*(y1-y_f))));

