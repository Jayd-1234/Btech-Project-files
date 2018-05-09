function prob = step_sens(xsag, ysag, xmin, xmax, ymin, ymax, eta)

%Generate points for fit
for i=1:40
    if i<=20
        x_min_sens(i) = xmin;
        x_max_sens(i) = xmax;
    else
        x_min_sens(i) = xmin+i-19;
        x_max_sens(i) = xmax+i-19;
    end
end

for i=1:40
    if i<=20
        y_min_sens(i) = i*ymin/20;
        y_max_sens(i) = i*ymax/20;
    else
        y_min_sens(i) = ymin;
        y_max_sens(i) = ymax;
    end
end

x_max_sens = x_max_sens'; x_min_sens = x_min_sens'; y_min_sens = y_min_sens'; y_max_sens = y_max_sens';

ft = fittype('normal_step(x,v)');

f1 = fit(x_min_sens-xmin, y_min_sens,ft, 'StartPoint', ymin);
f2 = fit(x_max_sens-xmax, y_max_sens, ft, 'StartPoint', ymax);

for i=1:length(ysag)
    y_min_sag = f1(xsag(i)-xmin);
    y_max_sag = f2(xsag(i)-xmax);
    prob(i) = tanh(eta*(ysag(i)-y_min_sag)*(y_max_sag-ysag(i)));
%     if ysag(i)>=y_min_sag
%         if ysag(i) <=y_max_sag
%             prob(i) = 1;
%         else
%             prob(i)=0;
%         end
%     else 
%         prob(i) = 0;
%     end
end

    
    