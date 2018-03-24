function Fout= q1_f( Y, t )
% Y = vector of dependent variables
% t = scalar of independent variable

% Y(1) = x1
% Y(2) = x2
% Y(3) = y
Fout = [ Y(2), 3*Y(1)/Y(3), Y(1)*Y(1)/500 + Y(3)*cos(t) ];

end

