function Fout = func( Y, t )
%FUNC right hand side of the DE. 
%t -> time (not used)
%Y(1) -> position of all particles
%Y(2) -> velocity of all particles

global inv_M bc

x = Y(:,1);
v = Y(:,2);
f = net_force(x, v);
v1 = inv_M*f;
Fout = [v, bc.*v1];
        
end

