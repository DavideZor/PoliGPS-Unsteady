%This algorithm generates one couple of Origin and Destination within the
%given size
%size can be small (1), medium (2), large (3)

function OD = random_OD(nodes, size)

%Non devono coincidere O e D!

s_min = 0; %m
s_max = 5*1e3; %m
m_min = 5*1e3; %m
m_max = 10*1e3; %m
l_min = 15*1e3; %m
l_max = 20*1e3; %m

X = nodes(:,2);
Y = nodes(:,3);

%Origin generation

X_O = min(X) + round((max(X) - min(X)) * rand(1,1));
Y_O = min(Y) + round((max(Y) - min(Y)) * rand(1,1));

O = find_nearest_node([X_O, Y_O], nodes);

if size == 1
    radius = s_max - s_min;
elseif size == 2
    radius = m_max - m_min;
elseif size == 3
    radius = l_max - l_min;
end

angle = 2 * pi * rand(1,1);

X_D = 1 + max(X); %To enter the while cycle
Y_D = 1 + max(Y);
D = [0,0,0];

while X_D > max(X) || Y_D > max(Y) || D(1,1) == O(1,1)
    X_D = X_O + ceil(round(radius * cos(angle)));
    Y_D = Y_O + ceil(round(radius * sin(angle)));
    D = find_nearest_node([X_D, Y_D], nodes);
end 

OD = [O; D];

end

