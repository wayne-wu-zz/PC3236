function clothsim_rk( row, col, stepsize )
% CLOTHSIM_RK Cloth simulation using Runge-Kutta's 4th order method

% Parameters
global h N L g Kd Kb Ks Cb d rows cols
Ks = 1000;     % Stretch Constant (g/s2)
Kb = 100;      % Flexural Rigidity (g/s2)
Kd = 10;       % Damping Constant
Cb = 800;      % Compression Constant (Comparable to Ks)
h = stepsize;  % Step size (s)
rows = row;    % Rows of particles
cols = col;    % Cols of particles
N = rows*cols; % Number of Particles
L = 1 ;        % Grid Spacing (cm)
g = 981;       % Gravity (cm/s2)
d = 1.54;      % Cloth Density (g/cm3)

frameSpeed = stepsize*100;
titleStr = sprintf('RK4: %gx%g, h=%g',rows,cols,h);
fileStr = sprintf('clothsim_rk4_%gx%g_%g', rows, cols, h); 

% Interaction Types
global type1 type2
type1 = [1 0; 0 1; 1 1; -1 0; 0 -1; -1 -1; -1 1; 1 -1];
type2 = 2*type1;

% Data Structures
global pos vel M inv_M bc

% Current Time Step
pos = zeros(3*N, 1);      % Position
vel = zeros(3*N, 1);      % Velocity
M = zeros(3*N, 3*N);      % Mass

% Initial Values
for i = 1:rows
    for j = 1:cols
        idx = ptc_idx(i,j);
        pos(idx:idx+2) = [-(rows-1)*L/2 + (i-1)*L, -(cols-1)*L/2 + (j-1)*L, 0];
    end
end

X = reshape(pos(1:3:3*N),rows,cols);
Y = reshape(pos(2:3:3*N),rows,cols);
Z = reshape(pos(3:3:3*N),rows,cols);
mesh(X, Y, Z);

% Calculate Mass
Area = L*L*0.5; % Area of triangle
mass = d*Area;
for i = 1:rows
    for j = 1:cols
        if (i==1||i==rows)&&(j==1||j==cols)
            m = (mass/3);  % Corner
        elseif (i==1||i==rows)||(j==1||j==cols)
            m = mass;      % Border
        else
            m = 2*mass;    % Interior
        end
        idx = ptc_idx(i, j);
        M(idx, idx) = m;
        M(idx+1, idx+1) = m;
        M(idx+2, idx+2) = m;
    end
end
 
% Calculate the inverse mass to save computation time
inv_M = inv(M);

% Boundary Constraints
%bc = simple_bc(rows, cols);
bc = table_bc(rows, cols);

% Simulation
frame = 1;
for t = 1:h:5
    Yout = rk4([pos, vel], t, h, @func);
    pos = Yout(:,1);
    vel = Yout(:,2);
    X = reshape(pos(1:3:3*N),rows,cols);
    Y = reshape(pos(2:3:3*N),rows,cols);
    Z = reshape(pos(3:3:3*N),rows,cols);
    mesh(X, Y, Z)
    axis([-rows*L/2, rows*L/2, -cols*L/2, cols*L/2, -3*max(rows,cols)*L, 1]);
    title(titleStr);
    Frames(frame) = getframe;
    frame = frame + 1;
end 

% % Output Animation
vidObj = VideoWriter(fileStr);
vidObj.Quality = 70;
vidObj.FrameRate = 30;
open(vidObj);
writeVideo(vidObj, Frames);
close(vidObj);

end

