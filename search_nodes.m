%nodes must be written as follows:
%first column: node ID
%second column: X coordinate of the node
%third column: Y coordinate of the node
%The same stands for the output list_of_nodes

function [test, list_of_nodes] = search_nodes(X_interval, Y_interval, nodes)

n = size(nodes,1);

ID_nodes = nodes(:,1);
X = nodes(:,2);
Y = nodes(:,3);

test = 0;
list_of_nodes = zeros(n, 3);

for i = 1:n
    if X(i) >= X_interval(1) && X(i) <= X_interval(2) && ...
            Y(i) >= Y_interval(1) && Y(i) <= Y_interval(2)
        list_of_nodes(i,1) = ID_nodes(i);
        list_of_nodes(i,2) = X(i);
        list_of_nodes(i,3) = Y(i);
        test = 1;
    end
end

list_of_nodes = delete_null_rows(list_of_nodes);

end
        
    
