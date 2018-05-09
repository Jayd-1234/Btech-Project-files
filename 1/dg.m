function J=dg(x)
f1x1 = 4*x(1); 
f2x1 = 2*x(1) -2; 
f1x2 = 8*x(2) +1; 
f2x2 = -4; 

J = [f1x1 f1x2; f2x1 f2x2]; %Jacobian
end