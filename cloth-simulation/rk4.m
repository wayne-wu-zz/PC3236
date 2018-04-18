function Yout = rk4( Y, t, tau, F )
%RK4 Runge-Kutta 4th Order
%Y (vector) left side of differentials
%F (vector) right side of differentials
%t (scalar) current time
%tau (scalar) timestep

half_tau = 0.5*tau;
half_step = t + half_tau;

f0 = feval(F, Y, t);
f1 = feval(F, Y + half_tau*f0, half_step);
f2 = feval(F, Y + half_tau*f1, half_step);
f3 = feval(F, Y + tau*f2, t + tau);

Yout = Y + (tau/6)*(f0 + 2*f1 + 2*f2 + f3);

end

