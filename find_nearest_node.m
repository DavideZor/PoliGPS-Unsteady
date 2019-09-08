function ID_X_Y = find_nearest_node(XY, nodes)

X_P = XY(1);
Y_P = XY(2);

X = nodes(:,1);
Y = nodes(:,2);

minX = 100; %minimum_distance(X) would give a too low value; 100m is reasonable
minY = 100; %minimum_distance(Y) would give a too low value; 100m is reasonable

X_interval = [X_P - minX, X_P + minX];
Y_interval = [Y_P - minY, Y_P + minY];

[test, list_of_nodes] = search_nodes(X_interval, Y_interval, nodes);

r = 2;

while test == 0
    X_interval = [X_P - r * minX, X_P + r * minX];
    Y_interval = [Y_P - r * minY, Y_P + r * minY];
    [test, list_of_nodes] = search_nodes(X_interval, Y_interval, nodes);
    r = r + 1;
end

N = length(list_of_nodes(:,1));
temp = zeros(N,1);

for k = 1:N
    temp(k) = norm([X_P - list_of_nodes(k,2), Y_P - list_of_nodes(k,3)]);
end

ID_X_Y = list_of_nodes(temp == min(temp), :);

end

%N number of nodes present in a region