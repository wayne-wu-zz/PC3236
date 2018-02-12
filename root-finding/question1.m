% Finite Square Well problem

% Using atomic unit: h = 1, me = 1
% Constants
a = 4/0.529; %Bohr
m = 10;
Vo = 8/27.211; %Hartree
h = 1;

% Plot the square well
plot([-2*a, -a],[Vo, Vo],'b', ...
[-a, -a], [0, Vo], 'b', ...
[-a, a], [0, 0], 'b', ...
[a, a], [0, Vo], 'b', ...
[a, 2*a], [Vo, Vo], 'b');
hold on

syms E %Energy
syms beta(E) alpha(E)
beta(E) = sqrt(2*m*(Vo - E));
alpha(E) = sqrt((2*m*E)/(h^2));

% Regions
x1 = -2*a:0.1:-a;
x2 = -a:0.1:a;
x3 = a:0.1:2*a;

% DE Parameter
C = 1e6;

% EVEN
syms even(E)
even(E) = alpha.*sin(alpha*a)-beta.*cos(alpha*a);
% plot(x, even(x));
% From plotting the graph, we see that the lowest state is 
% between 0 to ~0.02
root = bisection(even, 0, 0.02);
fprintf('Energy for the lowest even state is %g H\n', root);

aa = double(alpha(root)); %alpha @ root
bb = double(beta(root)); %beta @ root

% Region1
psi1 = C*exp(bb*x1);
% Region2 
B = (C*exp(-bb*a))/cos(aa*a);
psi2 = B*cos(aa*x2);
% Region3
psi3 = C*exp(-bb*x3);
plot(x1, psi1, 'r', x2, psi2, 'r', x3, psi3, 'r'); 
hold on

% ODD
syms odd(E)
odd(E) = alpha.*cos(alpha*a)+beta.*sin(alpha*a);

% plot(x, odd(x));
% From plotting the graph, we see that the lowest state is 
% between 0.001 to ~0.02

root = bisection(odd, 0.001, 0.02);
fprintf('Energy for the lowest odd state is %g H\n', root);

aa = double(alpha(root)); % alpha @ root
bb = double(beta(root)); % beta @ root

% Region1
psi1 = C*exp(bb*x1);
% Region2
A = (-C*exp(-bb*a))/sin(aa*a);
psi2 = A*sin(aa*x2);
% Region3
psi3 = -C*exp(-bb*x3);

plot(x1, psi1, 'g', x2, psi2, 'g', x3, psi3, 'g');


