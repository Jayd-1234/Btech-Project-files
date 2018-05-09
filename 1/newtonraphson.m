function [x, results] = newtonraphson(f, Df, x0, TolX, MaxIter);
%---------------------------------------------------
% PURPOSE: 
% Newton Raphson Optimization Procedure for a set of Non-Linear Equations
%---------------------------------------------------
% USAGE: 
% results = newtonraphson(f, df, startingvals, TolX, MaxIter)
%
% INPUTS:
% f: the M-file containing the functions,
% df: the M-file containing the Jacobian vector,
% x0: initial set of parameters,
% TolX: Termination tolerance of the variables, 
% MaxIter: Maximum Number of Iterations, 
%
% NOTES:
% In case no Jacobian vector is presented,
% then the derivatives are estimated using the Broyden Method.
%
% The default values of TolX and MaxIter are 1e-8 and 500, respectivelly.
%---------------------------------------------------
% OUTPUTS: 
% xf: the estimated values
% results: further results
%---------------------------------------------------
% Author:
% Alexandros Gabrielsen, a.gabrielsen@city.ac.uk
% Date: 07/2010
%---------------------------------------------------

if nargin == 0 
    error('Function, Derivative of the Function, Initial Values and Options') 
end

if isempty(TolX) 
   TolX = 1e-8;
end

if isempty(MaxIter) 
   MaxIter = 500;
end

x(:,1)= x0;      % Initial Parameters
F(:,1)= f(x);   % Initial Values of the Function
index = 1;       % Index
e=1;             % Error
iter=0;          % Iterations
n=length(x0);    % Number of Parameters

if isempty(Df) 
   disp('No Jacobian Vector was presented, continue estimation with initial Broyden procedure followed by Sherman-Morrison formula');
   results.method = 'Newton Raphson, Broyden Method initial Jacobian estimation and Sherman-Morrison update formula';
   Dt=1e-0; % Specify Time Step, Function Dependent 
else
    results.method = 'Newton Raphson';
end

while e>TolX & iter <=MaxIter
% Estimating Jacobian Vector using Broyden Method
    if iter == 0 & isempty(Df) % Estimating the initial Jacobian vector
        ii=1; % Index used in the estimation of the initial Jacobian vector
        for jj = 1:n
            t1=x(:,1); t1(jj)=x(jj)+Dt; f1=f(t1);
            t2=x(:,1); t2(jj)=x(jj)-Dt; f2=f(t2);
            df(:,ii) = ((f1-f2)/2*Dt)';
            ii=ii+1;
        end
        clear ii jj
        x(:,index+1) =  x(:,index) - inv(df)*(f(x(:,index))');  
    elseif iter >= 1 & isempty(Df)
        df = df + ((F(:,index)-F(:,index-1))-df*(x(:,index)-x(:,index-1)))*((x(:,index)-x(:,index-1))')/(((x(:,index)-x(:,index-1))')*(x(:,index)-x(:,index-1)));
        x(:,index+1) =  x(:,index) - inv(df)*(f(x(:,index))');
        D(:,:,index) = df;
    else
        x(:,index+1) =  x(:,index) - inv(Df(x(:,index)))*(f(x(:,index))');
        D(:,:,index) = Df(x(:,index));
    end
    F(:,index+1) = f(x(:,index+1)); 
    e=abs(x(:,index)-x(:,index+1));
    index=index+1;
    iter=iter+1;
end

% Saving Results
results.parameters = x;     % Parameters
results.function=F;         % Saving the function values at each step
results.Jacobian=D;         % Saving the Jacobian Matrix at each step
results.iter=iter;          % Number of iterations required for convergence

% Displaying estimated parameters
disp('The estimated parameters are');
disp(x(:,iter));

clear x0 index e iter 
end % End of Function