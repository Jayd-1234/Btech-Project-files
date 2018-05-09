function y = polynomial_objective(x,b,y1)

y = (y1-(b(1)*x.^4+b(2)*x.^3+b(3)*x.^2+b(4)*x+b(5))).^2;