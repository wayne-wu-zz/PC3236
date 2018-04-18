function [dx, dv] = backward_euler( Y, bc )
%BACKWARD_EULER backward Euler solver
%Y: variables (pos, vel)
%dx: boundary constraints

global h M inv_M

x0 = Y(:,1);
v0 = Y(:,2);
f0 = net_force(x0, v0);

[dfdx, dfdv] = get_jacobian(x0, v0);

A = M - h*h*dfdx - h*dfdv;
b = h*(f0 + h*dfdx*v0);

dv = A\b;        % Solve System of Equations using linsolve
dv = bc.*dv;     % Apply Boundary Constraints
dx = h*(v0 + dv);  

% Correction Method
f1 = net_force(x0 + dx, v0 + dv);
dv = h*inv_M*f1;
dv = bc.*dv;
dx = h*(v0 + dv);

