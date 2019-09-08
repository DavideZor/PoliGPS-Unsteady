%[t, c, r] = select_data(vehicle, times, costs, risks); da mettere nel main
%così per il veicolo selezionato si inseriscono direttamente i dati che lo
%riguardano senza dover ogni volta estrapolare i dati necessari

function [T, G, R] = NCM1(o, d, ID_nodes, arcs, t, c, r)

A = [t,c,r];
H = zeros(3,3);

for i = 1:3
    [~, pred] = shortest_path(ID_nodes, arcs, A(i), o);
    path = select_path(d, pred, ID_nodes);
    H(i,1) = path_cost_calculator(path, arcs, t);
    H(i,2) = path_cost_calculator(path, arcs, c);
    H(i,3) = path_cost_calculator(path, arcs, r);
end

T = max(H(:,1));
G = max(H(:,2));
R = max(H(:,3));

end