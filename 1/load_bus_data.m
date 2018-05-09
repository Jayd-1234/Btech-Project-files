function [duration, voltage] = load_bus_data(bus_num,M)

duration = [];
voltage = [];

for j=1:size(M,1)
    if (M(j,1)==bus_num)
        duration(j) = M(j,2);
        voltage(j) = M(j,4);
    end
end

