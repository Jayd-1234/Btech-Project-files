clear all; 
load('V_sag.mat');

xmin = 1;
xmax = 70;
ymin = 0.46;
ymax = 0.63;

%Load sag data
[xsag, ysag] = load_bus_data(5, V_sag);

%Generate points
for i=1:400
    if i<=20
        x_sens1(i) = xmin;
        x_sens2(i) = xmax;
        y_sens1(i) = 0;
        y_sens2(i) = 0;
    else
        x_sens1(i) = xmin+i-19;
        x_sens2(i) = xmax+i-19;
        y_sens1(i) = ymin;
        y_sens2(i) = ymax;
    end
end
%Prob vector: 1 for trip, 0 for no trip.
prob = step_sens_asd(xsag, ysag, xmin, xmax, ymin, ymax, 1);

plot(x_sens1, y_sens1); hold on; plot(x_sens2, y_sens2); hold on;
for i=1:length(xsag)
    if prob(i)>0
        plot(xsag(i), ysag(i),'g*');
        xlim([0 205]);
        hold on;
    else 
        plot(xsag(i), ysag(i), 'r*');
        xlim([0 205]);
        hold on;
    end
    
end