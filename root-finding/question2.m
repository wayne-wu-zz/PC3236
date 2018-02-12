syms c e a %constants
eqns = [c/(1+e*sin(-0.52333+a))==6870, c/(1+e*sin(a))==6728, c/(1+e*sin(0.52333+a))==6615, e > 0];
S = solve(eqns, [c e a]); %solve for the constants (stored in a struct)

syms R(theta)
R(theta) = double(S.c)./(1 + double(S.e)*sin(theta + double(S.a)));
dR = diff(R, theta);
d2R = diff(dR, theta); %Used for NR-scheme

%Graph R and dR
x = -pi:0.01:pi;
plot(x, R(x));
hold on
plot(x, dR(x));

%Find the root of dR(x) = 0 numerically, using NR Method.
%From the graph of dR, a reasonable guess of the root is at 1.0
%Convergence is guaranteed.
root = newtonRaphson(dR, d2R, 1.0);
fprintf('The root is %g\n', root)

%Plug the root back in to R(x)
minR = R(root);
fprintf('The mininum R of the trajectory is %g km, at theta = %g degree\n', minR, (root/pi)*180)




