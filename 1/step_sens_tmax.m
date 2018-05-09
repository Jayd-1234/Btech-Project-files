function prob = step_sens_tmax(xsag, ysag, xmin, xmax, ymin, ymax, eta)

prob = zeros(size(xsag));
for i=1:length(ysag)
    if (xsag(i)>=xmin) && (xsag(i) <=xmax) && (ysag(i) <ymax)
        prob(i) = tanh(eta*((xsag(i)-xmin)/(xmax-xmin)));
    
    
    elseif (xsag(i)> xmax)&&(ysag(i)>=ymax) && (ysag(i)<=ymin)
        prob(i) = tanh(eta*(ymin-ysag(i))/(ymin-ymax));
    
    
    elseif (xsag(i)>=xmin) && (xsag(i) <=xmax) && (ysag(i)>=ymax) && (ysag(i)<=ymin)
        prob(i) = tanh(eta*((xsag(i)-xmin)/(xmax-xmin))*((ymin-ysag(i))/(ymin-ymax)));
    
    elseif (xsag(i) <xmin) && (ysag(i) > ymin)
        prob(i) = 0;
    
    
    elseif (xsag(i) > xmax) && (ysag(i) <ymax)
        prob(i) = 1;
    end
    
end

    
    