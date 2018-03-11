function [ hessB, Hess ] = Hessian( func, params, h )
%HESSIAN find the Hessian matrix of S
%Hess: Hessian Matrix
%hessB: f0

M=length(params);
Hess = zeros(M, M);
hessB = zeros(M, 1);

for i = 1:M
    ABp=params; ABp(i)=params(i)+h;
    ABm=params; ABm(i)=params(i)-h;
    
    % 1st order central difference
    hessB(i)=-(sumsqerror(func, ABp)-sumsqerror(func, ABm))/(2*h);
    
    for j = i:M
        if (i == j)
            Ap=params; Am=params;
            Ap(i) = params(i)+h;
            Am(i) = params(i)-h;
            % Sii 2nd order central differentiation
            Hess(i,i)=(sumsqerror(func, Ap)-2*sumsqerror(func, params)+sumsqerror(func, Am))/(h*h);
        else
            App = params;
            Apm = params;
            Amp = params;
            Amm = params;
            App(i) = params(i) + h;
            App(j) = params(j) + h;
            Apm(i) = params(i) + h;
            Apm(j) = params(j) - h;
            Amp(i) = params(i) - h; 
            Amp(j) = params(j) + h; 
            Amm(i) = params(i) - h;
            Amm(j) = params(j) - h;
            % Sij 2 x 1st order central differentiation
            Hess(i,j) = ((sumsqerror(func, App)-sumsqerror(func, Apm))/(2*h) - ...
                (sumsqerror(func, Amp)-sumsqerror(func, Amm))/(2*h))/(2*h);
            Hess(j,i) = Hess(i,j);
        end
    end
end

