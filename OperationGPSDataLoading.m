nodes = load('NODES.txt'); %Position of the graph nodes
graph = load('GRAPH.txt'); %Arcs and graph properties
turns = load('TURNS.txt'); %Not allowed turns

X = nodes(:, 2);
Y = nodes(:, 3);
x_min = min(X); x_max = max(X);
y_min = min(Y); y_max = max(Y);

A_n = graph(:, 2); %ID of the beginning node of an arc
B_n = graph(:, 3); %ID of the ending node of the arc
arcs = [graph(:,2), graph(:,3)];

P = turns(:,1);
Q = turns(:,2);
R = turns(:,3);

XY_A = find_location(nodes, A_n);
XY_B = find_location(nodes, B_n);

XY_P = find_location(nodes, P);
XY_Q = find_location(nodes, Q);
XY_R = find_location(nodes, R);

vehicle = [2, 1, 1];
eta = 96; %Number of timeslots

[t, c, r] = select_data(vehicle, eta); %Richiede un casino di tempo, vedi se riesci ad ottimizzare

return

figure()
plot(X/1e3, Y/1e3, 'r.'), grid on;
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Nodes of the Milan Metropolitan Area (Comune di Milano 2008)');

figure()
plot(X/1e3, Y/1e3, 'r.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0.005, 'Color', 'b');
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Graph of the Milan Metropolitan Area (Comune di Milano 2008)');

figure()
plot(X/1e3, Y/1e3, 'r.'), grid on;
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0.005, 'Color', 'b');
hold on;
quiver(XY_P(:,1)/1e3, XY_P(:,2)/1e3, (XY_Q(:,1)-XY_P(:,1))/1e3, ...
    (XY_Q(:,2)-XY_P(:,2))/1e3, 0, 'MaxHeadSize', 0, 'Color', 'm');
hold on;
quiver(XY_Q(:,1)/1e3, XY_Q(:,2)/1e3, (XY_R(:,1)-XY_Q(:,1))/1e3, ...
    (XY_R(:,2)-XY_Q(:,2))/1e3, 0, 'MaxHeadSize', 0, 'Color', 'm');
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Forbidden turns in the Milan Metropolitan Area (Comune di Milano 2008)');