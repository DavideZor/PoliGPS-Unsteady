%This function takes a matrix A structured as ID_node/X/Y and a vector that
%contains all the interested ID_nodes and gives back a matrix with the
%location of the corresponding ID_node

function XY = find_location(A, ID_node)

n = length(ID_node);
m = length(A(:,1));

XY = zeros(n, 2);

for i = 1:n 
    for j = 1:m
        if A(j,1) == ID_node(i)
            XY(i,1) = A(j,2);
            XY(i,2) = A(j,3);
        end
    end
end
end
