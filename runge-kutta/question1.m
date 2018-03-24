% Define timestep
timestep = 0.05;
t = 0:timestep:10;

% Initialize matrix (Y vector x all timesteps)
Y = zeros(3, length(t));
Y(:, 1) = [10, 0, 10]; % Initial Conditions

% Step through time
for i = 2:length(t)
    Y(:, i) = rk4(Y(:, i-1), t(i-1), timestep, @q1_f);
end 

% Plot
plot(t, Y(1,:), '-')
hold on
plot(t, Y(3,:), '--')
xlabel('t')
legend('x(t)', 'y(t)')
hold off