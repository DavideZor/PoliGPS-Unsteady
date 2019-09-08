OperationGPSDataLoading

size = ceil(3 * rand(1,1)); %It generates a number between 1 and 3

OD = random_OD(nodes, size);
o = OD(1,1); X_o = OD(1,2); Y_o = OD(1,3);
d = OD(2,1); X_d = OD(2,2); Y_d = OD(2,3);

figure()
plot(X/1e3, Y/1e3, 'm.'), grid on;
hold on;
plot(X_o/1e3, Y_o/1e3, 'r.', 'MarkerSize', 20);
hold on;
plot(X_d/1e3, Y_d/1e3, 'r.', 'MarkerSize', 20);
hold on;
quiver(XY_A(:,1)/1e3, XY_A(:,2)/1e3, (XY_B(:,1)-XY_A(:,1))/1e3, ...
    (XY_B(:,2)-XY_A(:,2))/1e3, 0, 'MaxHeadSize', 0.005, 'Color', 'k');
xlabel('X (Gauss-Boaga) [km]'), ylabel('Y (Gauss-Boaga) [km]');
title('Graph of the Milan Metropolitan Area (Comune di Milano 2008)');

