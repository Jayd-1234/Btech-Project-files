function prob = check_prob2(xsag,ysag,b,eta)
 
prob = zeros(size(ysag));
for i=1:length(xsag)
    y1 = ysag(i);
    x1 = xsag(i);
    x_f = b(1)+b(2)*y1+b(3)*y1^2+b(4)*y1^3+b(5)*y1^4;
    y_f1 = (b'*b)\b'*x1;
    y_f = y_f1(2);
    if (y_f<0)
        y_f = 0;
    end
    
    if(x_f <0) 
        x_f = 0;
    end
    
    if ((x1>=x_f) && (y1<=y_f))
        prob = tanh(eta*(sqrt((x_f-x1)^2/max(x_f,x1)+(y1-y_f)^2/max(y1,y_f))))*(tanh(eta*(x_f-x1))/abs(tanh(eta*(x_f-x1))))*(tanh(eta*(y1-y_f))/abs(tanh(eta*(y1-y_f))));
    end
end