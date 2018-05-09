clear all;
load('data.mat');

% Load min-max data of sensitivity; x for duration, y for voltage. Y is in
% per unit or normalized in scale of sag data. The base value is unknown
% to me. Also for non-asd drives, please interchange ymin and ymax (i.e.
% put max voltage tolerance in ymin and vice versa)
xmin = 40;
xmax = 205;
ymin = 0.63;
ymax = 0.46;

%Load sag data
[xsag, ysag] = load_bus_data(2, V_sag);

%Generate points
% for i=1:400
%     if i<=20
%         x_sens1(i) = xmin;
%         x_sens2(i) = xmax;
%         y_sens1(i) = 0;
%         y_sens2(i) = 0;
%     else
%         x_sens1(i) = xmin+i-19;
%         x_sens2(i) = xmax+i-19;
%         y_sens1(i) = ymin;
%         y_sens2(i) = ymax;
%     end
% end
%Prob vector: 1 for trip, 0 for no trip.
prob1 = step_sens_tmax(xsag, ysag, xmin, xmax, ymin, ymax, 1);
prob2 = step_sens_tmax(xsag, ysag, 20, 400, 0.9, 0.3, 1);
prob3 = step_sens_tmax(xsag, ysag, 20, 80, 0.6, 0.4, 1);
prob4 = step_sens_tmax(xsag, ysag, 30, 80, 0.8, 0.6, 1);
prob5 = step_sens_tmax(xsag, ysag, 15, 175, 0.71, 0.59, 1);

process_prob = max(min(prob5, prob4), max(min(prob2, prob3), min(prob1, prob2)));
count = 0;
for i=1:length(process_prob)
    if (process_prob(i)>0.5)
        count = count+1;
    end
end

% process_prob(find(process_prob>1))=1;
% process_prob(find(process_prob<0)) = 0;
% j=1;
% for i=1:length(process_prob)
%     if (process_prob(i)>0.2)
%         x_data(j) = xsag(i);
%         y_data(j) = ysag(i);
%         z_data(j) = process_prob(i);
%         j = j+1;
%     end
% end
% plot(x_sens1, y_sens1); hold on; plot(x_sens2, y_sens2); hold on;
% for i=1:length(xsag)
%     if prob(i)>0
%         plot(xsag(i), ysag(i),'g*');
%         hold on;
%     else 
%         plot(xsag(i), ysag(i), 'r*');
%         hold on;
%     end
%     
% end