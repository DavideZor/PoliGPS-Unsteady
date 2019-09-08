%delta_minus is a matrix with in the first column the beginning node of the
%entering arc

function delta_minus = entering_arcs(arcs, ID_nodes)

n = length(arcs(:,1));
m = length(ID_nodes);

A = zeros(n, m);

for j = 1:m
    for i = 1:n
        if arcs(i,2) == ID_nodes(j) && all(ID_nodes ~= arcs(i,1))
            A(i,j) = arcs(i,1);
        end
    end
end

delta_minus = zeros(sum(sum(A ~= 0)),2);

k = 1;

for j = 1:m
    for i = 1:n
        if A(i,j) ~= 0
            delta_minus(k,1) = A(i,j);
            delta_minus(k,2) = ID_nodes(j);
            k = k + 1;
        end
    end
end
end