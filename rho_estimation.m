function rho_u = rho_estimation(d, nodes, delta)

ID_nodes = nodes(:,1);
n = length(ID_nodes);

i = find_node_index(d, ID_nodes);

X_d = nodes(i,2); Y_d = nodes(i,3);

rho_u = zeros(n,1);

for u = 1:n
    X_u = nodes(u,2); Y_u = nodes(u,3);
    rho_u(u) = norm([X_d - X_u, Y_d - Y_u]) / delta;
end

end