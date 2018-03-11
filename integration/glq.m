function integral = glq(f,a,b,n)
%Three-Point Gauss-Legendre Quadrature Integration
%a, b are the limits of integration
%n is the number of "panels" (for some-what composite)

h2 = (b-a)/(2*n);
sq35 = sqrt(0.6); %abscissa
w1 = 5/9;
w2 = 8/9;
x = linspace(a, b, n+1);
sum = 0.0; 
for i = 1:n
    sum = sum + w1 * f(x(i) + h2 - sq35 * h2); 
    sum = sum + w2 * f(x(i) + h2);
    sum = sum + w1 * f(x(i) + h2 + sq35 * h2);
end
integral=h2*sum;

end

