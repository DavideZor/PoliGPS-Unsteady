function rho = generalized_potential(lambda, rho_t, T, rho_c, G, rho_r, R)

rho = lambda(1)*rho_t/T + lambda(2)*rho_c/G + lambda(3)*rho_r/R;

end