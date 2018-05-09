clear all;
load('V_sag.mat');

% Load min-max data of sensitivity; x for duration, y for voltage. Y is in
% per unit or normalized in scale of sag data. The base value is unknown
% to me. Also for non-asd drives, please interchange ymin and ymax (i.e.
% put max voltage tolerance in ymin and vice versa)
xmin = 20;
xmax = 80;
ymin = 0.6;
ymax = 0.4;

%Load sag data
[xsag, ysag] = load_bus_data(5, V_sag);

%Generate points
for i=1:200
    if i<=20
        
        x_sens2(i) = xmax;
        
        y_sens2(i) = 0;
    else
       
        x_sens2(i) = xmax+i-19;
        
        y_sens2(i) = ymax;
    end
end
for i=1:800
    if i<=20
        x_sens1(i) = xmin;
  
        y_sens1(i) = 0;
        
    else
        x_sens1(i) = xmin+i-19;
        
        y_sens1(i) = ymin;
        
    end
end
x_tol_min = [xmin, xmin, 500];
y_tol_min = [0, ymin, ymin];
x_tol_max = [xmax, xmax, 500];
y_tol_max = [0, ymax, ymax];
%Prob vector: 1 for trip, 0 for no trip.
prob = step_sens_tmax(xsag, ysag, xmin, xmax, ymin, ymax, 1);
clear V_sag;
%surf(xsag, ysag, prob);figure;
count = 0;
for i=1:length(prob)
    if prob(i)==1
        count =  count+1;
    end
end
clear V_sag
plot(x_tol_min, y_tol_min,'black','LineWidth', 3); hold on; plot(x_tol_max, y_tol_max, 'LineWidth', 3); hold on;
for i=1:length(xsag) 
    if prob(i)==1
        plot(xsag(i), ysag(i),'r*');
        xlim([0 500]);
        hold on;
    else 
        plot(xsag(i), ysag(i), 'b.');
        xlim([0 500]);
        hold on;
    end
    
end
prob(find(prob>1))=1;
j=1;
for i=1:length(prob)
    if (prob(i)>0)
        x_data(j) = xsag(i);
        y_data(j) = ysag(i);
        z_data(j) = prob(i);
        j = j+1;
    end
end