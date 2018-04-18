% Main Simulation(s)

n = [5 5; 10 10; 20 20; 40 40];
h = [0.01];

for i = 1:length(n)
    for j = 1:length(h)
        clothsim_rk(n(i,1), n(i,2), h(j));     
        clothsim_be(n(i,1), n(i,2), h(j));
    end
end

    