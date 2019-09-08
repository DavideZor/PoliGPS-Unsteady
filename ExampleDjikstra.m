%%% Esermpio preso dalle slide %%%

nodes = 1:6;
nodes = nodes';

graph = [1,2,3;
    1,3,2;
    2,3,6;
    2,4,10;
    3,2,8;
    3,5,4;
    4,2,1;
    4,3,9;
    4,6,3;
    5,3,3;
    5,4,2;
    6,4,1;
    6,5,4];

arcs = graph(:, 1:2);
costs = graph(:,end);

[L, pred] = shortest_path(nodes, arcs, costs, 1)
path = select_path(6, pred, nodes)