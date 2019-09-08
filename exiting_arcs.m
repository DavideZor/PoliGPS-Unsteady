%delta_plus is a matrix with in the first column the beginning node of the
%exiting arc

function delta_plus = exiting_arcs(arcs, ID_nodes)

n = length(arcs(:,1));
m = length(ID_nodes);

A = zeros(n, m);

for j = 1:m
    for i = 1:n
        if arcs(i,1) == ID_nodes(j) && all(ID_nodes ~= arcs(i,2)) %Exclude the arcs inside the set S
            A(i,j) = arcs(i,2);
        end
    end
end

delta_plus = zeros(sum(sum(A ~= 0)),2);

k = 1;

for j = 1:m
    for i = 1:n
        if A(i,j) ~= 0
            delta_plus(k,1) = ID_nodes(j);
            delta_plus(k,2) = A(i,j);
            k = k + 1;
        end
    end
end

end