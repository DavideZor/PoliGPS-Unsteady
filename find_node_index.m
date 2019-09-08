function j = find_node_index(ID_node, ID_nodes)

%Insert dimension check
%Inserire la possibilità che il nodo non sia presente nella lista

j = find_first_index(ID_node == ID_nodes);

end