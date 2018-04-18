function y = fb( x, L )
%FB (Used in Type 2 interaction)

global Kb Cb

k = 2*inv_sinc(x/L)/L;
y = Kb*k*k/(cos(k*L/2)-sin(k*L/2)/(k*L/2));

if y < Cb*(x - L)
    y = Cb*(x - L);
end

end

