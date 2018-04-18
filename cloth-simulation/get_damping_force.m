function f = get_damping_force( v )
%GET_DAMPING_FORCE Get the damping force

global Kd
f = -Kd*v;
end

