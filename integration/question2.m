% Question 2
global W_data I_data
W_data = [0.0, 1.5, 3.0, 4.5, 6.0, 7.5, 9.0, 10.5, 12.0, 13.5, 15.0];
I_data = [0.0137, 0.0268, 0.0630, 0.1087, 0.1265, 0.1208, 0.1063, 0.0906, 0.0767, 0.0649, 0.0553];

plot(W_data, I_data, 'O')
hold on

syms w a b z y x

% Change of variable
x = y/(1-y);
dxdy = (1-y).^-2;

% Numerical Integration using Gauss-Legendre Quadrature Rule

% Get optimal number of panels for numerical integration
% Let w, a, b = 1 to test the glq function
syms f_temp(y)
f_temp(y) = (exp(-x.^2)/((1 - 1/x)^2 + 1)).*dxdy;

n = 10;
oldI = 0;
for i = 1:20
    n = 10*i;
    I = glq(f_temp, 0, 1, n);
    if (abs(oldI - I) < 1e-6)
        break;
    end
    oldI = I;
end

% Define the actual integrand with w, a, b
syms f(y)
f(y) = (exp(-x.^2)/((w - a/x).^2 + b)).*dxdy;

syms I(w, a, b)
I(w,a,b) = glq(f, 0, 1, n);

% Obtain initial value for the nonlinear fitting
params = [4 2]; % Obtained from rough estimate through trial and error
% Two cycles of CRUDE to get better starting values
params = crude(I, params, 0.1);
params = crude(I, params, 0.1*0.5);

% Nonlinear Curve Fitting
h = 1e-4; % differentiation step

% Use Newton-Raphson Scheme to solve the systems of equations
for i = 1:10
    [hessB, Hess] = Hessian(I, params, h);
    dx = (Hess\hessB)';
    params = params + dx;
    % Test for convergence
    if sqrt(dot(dx,dx)/length(params)) < 1e-4
        fprintf('Converged!\n');
        break;
    end
end

fprintf('a = %g, b = %g\n', params(1), params(2));

% Plot I(w) on top of the data points
w = 0 : 0.1 : 15;
plot(w, I(w, params(1), params(2)))
xlabel('w')
ylabel('I(w)')

hold off






