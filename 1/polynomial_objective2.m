function y = polynomial_objective2(x,rbf,y1)

y = (y1-rbf(x)).^2;