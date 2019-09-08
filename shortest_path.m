%Dijkstra algorithm
%The predecessor of the origin is zero
%If a node cannot be reached by the origin the value of pred is -1 and of
%L is +inf

function [L, pred] = shortest_path(ID_nodes, arcs, costs, o)

%Insert positive costs
%Insert dimension check

n = length(ID_nodes);
S = o;
L = zeros(n,1); %Vettore coi costi dei singoli nodi
%al posto k corrisponde il costo del nodo nella k-esima posizione del
%vettore nodes
pred = zeros(n,1); %Vettore che contiene i predecessori del nodo nella 
%k-esima posizione (corrispondente alla posizione in nodes)

while (length(S) ~= n)
    delta_plus = exiting_arcs(arcs, S);
    m = length(delta_plus(:,1));
    temp = zeros(m,1); %Conterrà i prezzi di tutti gli exiting arcs
    for k = 1:m
        arc = delta_plus(k,:); %row vector
        i = find_arc_index(arc, arcs);
        j = find_node_index(arc(1), ID_nodes);
        temp(k) = L(j) + costs(i);
    end
    z = find_first_index(temp == min(temp));
    selected_arc = delta_plus(z, :);
    selected_node = selected_arc(2);
    i = find_arc_index(selected_arc, arcs);
    j = find_node_index(selected_node, ID_nodes);
    q = find_node_index(selected_arc(1), ID_nodes);
    pred(j) = selected_arc(1);
    L(j) = L(q) + costs(i);
    S = [S; selected_node];
end

end