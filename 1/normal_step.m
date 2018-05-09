function y = normal_step(x,v)

y = zeros(size(x));
for i=1:length(x)
    if (x(i))>0
        y(i) = v;
    elseif x(i)== 0 
        y(i) = rand()*v;
    else 
        y(i)=0;
    end
end



