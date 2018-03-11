% Triple Integral

tol = 1e-5; % precision to 5 decimal places
max = 10; % maximum iteration 

oldI = 0;
converged = false;
for i = 1:max
    I = glq(@q1_I, 0, 1, i*10); %Guass-Legendre Quadrature Rule
    fprintf('I = %g\n', I);
    if (abs(oldI - I) < tol)
        converged = true;
        break;
    end 
    oldI = I;
end

if (converged)
    fprintf('Integral converged to %g', I);
else
    fprintf('Integral did not converge (%g)', I);
end







