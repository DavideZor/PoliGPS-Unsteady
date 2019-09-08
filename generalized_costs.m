%Generalized costs depend on time

function C = generalized_costs(lambda, t, T, c, G, r, R)

C = lambda(1)*t/T + lambda(2)*c/G + lambda(3)*r/R;

end